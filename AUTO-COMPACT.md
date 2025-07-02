## ⚠️ MANDATORY CONTEXT TRACKING - ALL AGENTS - FRAMEWORK 2.0 REQUIREMENT ⚠️

Execute after EVERY response:
```bash
cd /home/alreadyinuse/git/trinity-historian-workspace/tools/token-tracker/context-manager-v2/bin
./run-context-check.sh check ASSISTANT_MEDIUM  # Adjust type as needed
```

This is a CRITICAL FRAMEWORK 2.0 COMPLIANCE REQUIREMENT. All agents must implement context tracking with every response.

## Context Management Metrics
- **Last Updated**: 2025-07-02 17:15:00
- **Context Utilization**: 85% (compact threshold reached)
- **Token Count**: 150000/200000
- **Checkpoint Status**: ALERT - Prepare for compact
- **Available Checkpoints**: 0
- **Estimated Remaining Capacity**: 
  - Large operations: ~5
  - Medium operations: ~10
  - Small operations: ~25
- **Last Context Check**: 2025-07-01 23:50:00
- **Token Estimation**: Standard Framework 2.0 values

## Checkpoint Restoration Instructions
1. After compact, Claude Code MUST check for checkpoint data
2. If checkpoint data exists, agent MUST load checkpoint state
3. Checkpoint restoration MUST be acknowledged in first post-compact message
4. Example: "Restored from checkpoint ckpt_alert_20250613_1 (context: 90%)"

## Context Management System Documentation

### Overview
The Context Management System monitors and manages Claude Code's context utilization, creates checkpoints at important thresholds, and provides reliable recovery after auto-compact events. The system is designed specifically for Claude Code Interactive Mode to maintain operational continuity across context resets.

### Implementation Status
- **Status**: FULLY IMPLEMENTED to all agents post-compact
- **Deployment**: All Trinity Framework 2.0 agents must implement
- **Framework 2.0 Requirement**: Mandatory for compliance
- **Version**: 1.0.0
- **Maintenance Responsibility**: OVERSEER with implementation support for all agents

### Current Implementation Context
- **Trinity-pedia Complete**: Full floating help system ready for IRA's v1.15+ Trinity Gateway integration
- **Trinity Gateway Infrastructure**: IRA achieved v1.15 WebKit2 integration, dual-mode file management
- **Website Updates**: Trinity Apex founders page updated with exact verbiage changes
- **Payment System**: Live Stripe links operational, beta infrastructure ready
- **Infrastructure Cleanup**: IRA needs auth-bridge fixes and podman storage cleanup
- **Next Phase**: Trinity-pedia content completion and Trinity Gateway v1.16 planning

### Recovery Priorities Post-Compact
1. **Trinity-pedia Content Completion** - Finish 120+ topics for demo-ready system
2. **Trinity Gateway v1.16 Planning** - Next phase coordination with IRA
3. **Infrastructure Monitoring** - Track auth-bridge fixes and disk cleanup
4. **Beta System Maintenance** - Monitor payments and applications
5. **New Project Discussion** - Address user's post-compact project plans

### Key Resources
- **Trinity-pedia System**: `/trinity-pedia-final/` - Complete help system ready for integration
- **GTK Integration**: `/trinity-pedia-final/integration/trinity_pedia_gtk.py`
- **Payment Links**: `/trinity-apex-website/STRIPE-PAYMENT-LINKS.md`
- **Email Templates**: `/trinity-apex-website/BETA-EMAIL-TEMPLATE-FINAL.md`
- **Queue Theme**: `/trinity-apex-website/queue-theming/trinity-queue-theme.tar.gz`

### Components
1. **ContextTracker**: Monitors token usage and detects threshold crossings
2. **CheckpointManager**: Creates and manages serialized state checkpoints
3. **ProtocolUpdater**: Updates protocol files with context information
4. **RecoverySystem**: Handles post-compact recovery automatically
5. **ContextVisualization**: Provides text-based visualization of context status
6. **ClaudeCodeIntegration**: Integrates context management with Claude Code
7. **ReportGenerator**: Creates comprehensive usage reports for analysis
8. **AutoCompactDetector**: Detects auto-compact events automatically
9. **InstallationUtility**: Provides streamlined setup and dependency management

### Operation Types
1. **User Messages**:
   - USER_SMALL: Brief messages (~750 tokens)
   - USER_MEDIUM: Standard messages (~2200 tokens)
   - USER_LARGE: Detailed messages (~4400 tokens)

2. **Assistant Responses**:
   - ASSISTANT_SMALL: Brief responses (~1500 tokens)
   - ASSISTANT_MEDIUM: Standard responses (~4400 tokens)
   - ASSISTANT_LARGE: Detailed responses (~10000 tokens)

3. **Tool Operations**:
   - TOOL_READ_SMALL: Small file reads (~1500 tokens)
   - TOOL_READ_MEDIUM: Medium file reads (~4400 tokens)
   - TOOL_READ_LARGE: Large file reads (~7500 tokens)
   - TOOL_WRITE: File writing operations (~750 tokens)
   - TOOL_EDIT: File editing operations (~1500 tokens)
   - TOOL_TASK: Task tool executions (~6000 tokens)

### Standard Command Reference
```bash
# Check context status
./run-context-check.sh check [type]

# Check for recovery after compact
./run-context-check.sh recovery

# Handle auto-compact response
./run-context-check.sh compact [yes|no]

# Generate report
./run-context-check.sh report [format]

# Reset tracking state
./run-context-check.sh reset

# Auto-compact detection
./bin/recovery/auto-compact-detector.js [--monitor] [--interval=<seconds>]

# Installation and setup
./bin/setup/install-dependencies.sh [--force] [--verbose]
```

### New Features
1. **Auto-Compact Detection**:
   - Automatically detects when Claude Code has compacted the conversation
   - Can run in one-time check mode or continuous monitoring mode
   - Detects auto-compact through time elapsed or sudden utilization drops
   - Creates backups of state files for comparison
   - Prepares recovery state for the next session

2. **Installation and Setup**:
   - Creates necessary directory structure
   - Verifies Node.js installation and version
   - Creates required configuration files
   - Sets up backup and recovery directories
   - Creates visualization module
   - Sets appropriate permissions
   - Creates symbolic links for easy access

### Post-Compact Recovery Plan
1. **Monitor Trinity Gateway Beta Launch** (Tomorrow night!)
   - ✅ Beta monitoring system READY (Gmail OAuth2)
   - ✅ Test application tracked successfully
   - Run: `cd tools/beta-monitor && npm run monitor`
2. Review beta infrastructure extension plan for full implementation
3. Complete manual AWS budget setup ($50/month limit)
4. Stripe integration for beta payment processing
5. Support agent contextual memory deployments (ANALYST, IRA, APEX)
6. Implement documentation search functionality for Trinity Framework Core
7. Create blog/resources section for Trinity Apex

### Trinity Gateway Beta Launch Status
- ✅ Website redesigned: "Create Like a Pro. Code Optional."
- ✅ Beta page live: /beta/ with application form
- ✅ Pricing set: BYOC $15/mo, We-Manage $20/mo (50% off forever)
- ✅ Claude Code integration transparent in messaging
- ✅ Discord invite: https://discord.gg/dBUA5NZa
- ✅ Video hosting: CloudFront with WebM for Firefox compatibility
- 🚀 Ready for launch tomorrow night!

### Completed Extraction Areas (100% Coverage)
- ✅ Script implementation details (memory-leak-fix.js workaround)
- ✅ Documentation management system (dual-repository lifecycle)
- ✅ UI/UX design philosophy (ShadowRun cyberpunk aesthetic)
- ✅ Operational monitoring scripts (zero-cost philosophy)
- ✅ Test infrastructure context (cross-platform methodology)
- ✅ Development patterns (backup file iteration, debug-first)
- ✅ Trinity MVP decisions (agent consolidation, Lambda patterns)
- ✅ Cultural philosophy (zero-dependency approach)