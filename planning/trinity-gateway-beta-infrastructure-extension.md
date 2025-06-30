# Trinity Gateway Beta Infrastructure Extension Plan

**Date**: June 30, 2025  
**Author**: HISTORIAN  
**Status**: PROPOSED  

## Overview

Extending Trinity Gateway from single-session demo to full multi-user beta platform with dedicated user accounts, persistent workspaces, and production-grade infrastructure.

## Current Demo Infrastructure

### What We Have (demo.trinityapex.io):
- **Session Management**: Queue-based, single active session
- **Authentication**: Basic/temporary (likely Auth0 dev tenant)
- **Storage**: Ephemeral during session
- **Scaling**: Single instance
- **CloudFront**: Video delivery only (d29tpqz2wgn380.cloudfront.net)

## Beta Infrastructure Requirements

### 1. Authentication System

#### Current Demo:
```
User → Auth0 (basic) → Queue → Single Session → Timeout/Release
```

#### Beta Extension:
```
User → Auth0 (production) → User Dashboard → Dedicated Workspace
         ↓
    Stripe Subscription → Access Control → Resource Limits
```

**Implementation:**
```javascript
// auth0-config.js
const auth0Config = {
  domain: 'trinity-gateway.auth0.com',
  clientId: process.env.AUTH0_CLIENT_ID,
  audience: 'https://api.trinitygateway.io',
  scope: 'openid profile email subscription:read workspace:access',
  
  // New for beta: Custom rules
  rules: {
    checkSubscription: true,
    enforceEmailVerification: true,
    assignWorkspace: true
  }
};

// Custom Auth0 Rule for subscription check
function checkStripeSubscription(user, context, callback) {
  // Check if user has active Stripe subscription
  const hasSubscription = await checkStripeAPI(user.email);
  
  if (!hasSubscription) {
    return callback(new UnauthorizedError('Active subscription required'));
  }
  
  context.idToken['https://trinitygateway.io/subscription'] = {
    status: 'active',
    plan: user.app_metadata.plan_type // 'byoc' or 'we-manage'
  };
  
  callback(null, user, context);
}
```

### 2. User Workspace Architecture

#### Demo (Current):
- Single shared environment
- Ephemeral file storage
- No persistence between sessions

#### Beta (Proposed):
```yaml
# kubernetes/user-workspace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: beta-user-{{USER_ID}}
  labels:
    trinity.io/user: "{{USER_EMAIL}}"
    trinity.io/plan: "{{PLAN_TYPE}}"
    trinity.io/created: "{{TIMESTAMP}}"
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: user-workspace-storage
  namespace: beta-user-{{USER_ID}}
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi  # BYOC users
      # storage: 100Gi  # We-Manage users
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: trinity-workspace
  namespace: beta-user-{{USER_ID}}
spec:
  replicas: 1
  template:
    spec:
      containers:
      - name: workspace
        image: trinityapex/gateway-workspace:beta-v1
        resources:
          limits:
            cpu: "2"  # BYOC: 2 cores
            memory: "4Gi"  # BYOC: 4GB RAM
            # cpu: "4"  # We-Manage: 4 cores
            # memory: "8Gi"  # We-Manage: 8GB RAM
```

### 3. Session Management Extension

#### From Queue-Based to User-Based:
```javascript
// session-manager.js

// DEMO: Queue-based
class DemoSessionManager {
  constructor() {
    this.queue = [];
    this.activeSession = null;
    this.timeout = 30 * 60 * 1000; // 30 minutes
  }
  
  async requestSession(userId) {
    this.queue.push(userId);
    // Wait for turn...
  }
}

// BETA: User-dedicated
class BetaSessionManager {
  constructor() {
    this.activeSessions = new Map(); // userId -> session
    this.workspaces = new Map(); // userId -> k8s namespace
  }
  
  async createSession(userId, subscription) {
    // Check if workspace exists
    let workspace = this.workspaces.get(userId);
    
    if (!workspace) {
      // Provision new workspace
      workspace = await this.provisionWorkspace(userId, subscription);
      this.workspaces.set(userId, workspace);
    }
    
    // Create session
    const session = {
      id: generateSessionId(),
      userId,
      workspace,
      startTime: Date.now(),
      lastActivity: Date.now(),
      resources: this.getResourceLimits(subscription.plan)
    };
    
    this.activeSessions.set(userId, session);
    return session;
  }
  
  getResourceLimits(plan) {
    const limits = {
      'byoc': {
        cpu: 2,
        memory: '4Gi',
        storage: '50Gi',
        claudeApiCalls: 'user-provided',
        concurrentSessions: 1
      },
      'we-manage': {
        cpu: 4,
        memory: '8Gi',
        storage: '100Gi',
        claudeApiCalls: 1000, // per month
        concurrentSessions: 3
      }
    };
    return limits[plan];
  }
}
```

### 4. Infrastructure Components

#### A. API Gateway (New)
```javascript
// api-gateway/routes/workspace.js
router.post('/workspace/create', authenticate, async (req, res) => {
  const { userId, email } = req.user;
  const subscription = await getStripeSubscription(email);
  
  if (!subscription.active) {
    return res.status(402).json({ error: 'Payment required' });
  }
  
  const workspace = await workspaceManager.provision({
    userId,
    email,
    plan: subscription.plan,
    limits: getPlanLimits(subscription.plan)
  });
  
  res.json({ workspace });
});

router.get('/workspace/:id/status', authenticate, async (req, res) => {
  const status = await workspaceManager.getStatus(req.params.id);
  res.json({ status });
});
```

#### B. CloudFront Multi-Purpose CDN
```javascript
// CloudFront configuration for beta
const distribution = {
  origins: [
    {
      // Static assets
      domainName: 's3.amazonaws.com/trinity-gateway-assets',
      originPath: '/beta',
      s3OriginConfig: { originAccessIdentity }
    },
    {
      // API Gateway
      domainName: 'api.trinitygateway.io',
      customOriginConfig: {
        HTTPPort: 443,
        originProtocolPolicy: 'https-only'
      }
    },
    {
      // WebSocket connections
      domainName: 'ws.trinitygateway.io',
      customOriginConfig: {
        HTTPPort: 443,
        originProtocolPolicy: 'https-only'
      }
    }
  ],
  behaviors: [
    {
      pathPattern: '/api/*',
      targetOriginId: 'API-Gateway',
      viewerProtocolPolicy: 'redirect-to-https',
      cachePolicyId: 'CACHING_DISABLED'
    },
    {
      pathPattern: '/ws/*',
      targetOriginId: 'WebSocket',
      viewerProtocolPolicy: 'redirect-to-https',
      cachePolicyId: 'CACHING_DISABLED'
    },
    {
      pathPattern: '/*',
      targetOriginId: 'S3-Assets',
      viewerProtocolPolicy: 'redirect-to-https',
      cachePolicyId: 'CACHING_OPTIMIZED'
    }
  ]
};
```

#### C. Database Schema (New)
```sql
-- PostgreSQL schema for beta
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  auth0_id VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  stripe_customer_id VARCHAR(255),
  workspace_id VARCHAR(255)
);

CREATE TABLE subscriptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  stripe_subscription_id VARCHAR(255) UNIQUE,
  plan_type VARCHAR(50), -- 'byoc' or 'we-manage'
  status VARCHAR(50), -- 'active', 'cancelled', 'past_due'
  current_period_end TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE workspaces (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  k8s_namespace VARCHAR(255) UNIQUE,
  status VARCHAR(50), -- 'provisioning', 'active', 'suspended'
  resource_limits JSONB,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_accessed TIMESTAMP
);

CREATE TABLE usage_metrics (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  workspace_id UUID REFERENCES workspaces(id),
  metric_type VARCHAR(50), -- 'cpu', 'memory', 'storage', 'api_calls'
  value DECIMAL,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 5. Monitoring & Observability

```yaml
# monitoring/prometheus-rules.yaml
groups:
  - name: trinity_gateway_beta
    rules:
      - alert: HighWorkspaceMemoryUsage
        expr: |
          (container_memory_usage_bytes{namespace=~"beta-user-.*"} / 
           container_spec_memory_limit_bytes{namespace=~"beta-user-.*"}) > 0.9
        for: 5m
        annotations:
          summary: "User workspace {{ $labels.namespace }} high memory usage"
          
      - alert: SubscriptionExpiring
        expr: |
          (subscription_days_remaining < 3)
        annotations:
          summary: "User {{ $labels.email }} subscription expiring"
```

### 6. Beta Monitoring Dashboard Extension

```javascript
// Extend our existing monitor
class BetaMonitorExtended {
  constructor() {
    this.gmail = new GmailMonitor();
    this.stripe = new StripeMonitor();
    this.k8s = new K8sMonitor();
    this.database = new DatabaseConnection();
  }
  
  async getComprehensiveStatus() {
    const [applications, subscriptions, workspaces] = await Promise.all([
      this.gmail.getApplicationCount(),
      this.stripe.getActiveSubscriptions(),
      this.k8s.getActiveWorkspaces()
    ]);
    
    return {
      applications: {
        total: applications.total,
        pending: applications.pending,
        approved: applications.approved
      },
      subscriptions: {
        active: subscriptions.active,
        byoc: subscriptions.byPlan.byoc,
        weManage: subscriptions.byPlan.weManage,
        mrr: subscriptions.monthlyRecurringRevenue
      },
      infrastructure: {
        activeWorkspaces: workspaces.active,
        totalCPU: workspaces.metrics.cpu,
        totalMemory: workspaces.metrics.memory,
        totalStorage: workspaces.metrics.storage
      }
    };
  }
}
```

## Migration Plan

### Phase 1: Authentication & User Management (Week 1)
1. Set up Auth0 production tenant
2. Configure Stripe integration
3. Create user database schema
4. Build authentication flow

### Phase 2: Workspace Provisioning (Week 2)
1. Create K8s workspace templates
2. Build provisioning API
3. Implement resource limits
4. Test workspace isolation

### Phase 3: Session Management (Week 3)
1. Migrate from queue to user-based sessions
2. Implement persistence layer
3. Add workspace state management
4. Create backup/restore functionality

### Phase 4: Monitoring & Operations (Week 4)
1. Deploy Prometheus/Grafana
2. Set up alerts
3. Create admin dashboard
4. Implement usage tracking

## Cost Considerations

### Infrastructure Costs (Monthly)
- **Auth0**: ~$25 (up to 1,000 users)
- **AWS EKS**: ~$75 (control plane)
- **EC2 Nodes**: ~$200-500 (depending on usage)
- **RDS PostgreSQL**: ~$50
- **CloudFront**: ~$20-50
- **S3 Storage**: ~$50-100
- **Total**: ~$420-820/month

### Revenue Projections
- **50 Beta Users**:
  - 30 BYOC @ $15 = $450
  - 20 We-Manage @ $20 = $400
  - **Total MRR**: $850

## Security Considerations

1. **Workspace Isolation**: Network policies between namespaces
2. **API Security**: Rate limiting, DDoS protection
3. **Data Encryption**: At rest and in transit
4. **Compliance**: SOC2 preparation, GDPR considerations
5. **Access Control**: RBAC for all resources

## Next Steps

1. **Validate with IRA**: Confirm infrastructure assumptions
2. **Cost Approval**: Get budget approval for infrastructure
3. **Team Assignment**: Who builds what components
4. **Timeline**: Realistic launch date for full beta
5. **Testing Plan**: Load testing, security testing

---

*This extension plan transforms the single-session demo into a production-ready multi-tenant SaaS platform*