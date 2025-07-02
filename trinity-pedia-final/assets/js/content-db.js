// Trinity-pedia Content Database
// Organized by category with cross-references

const TrinityContent = {
  // Home page content
  home: {
    id: 'home',
    title: 'Trinity-pedia',
    icon: '🏠',
    content: `
      <div class="hero-section">
        <h1 class="hero-title">🤖 Claude Code + APEX + You = BOOM! 🚀</h1>
        <p class="hero-subtitle">Your complete guide to AI-powered development with Trinity Gateway</p>
      </div>
      
      <div class="topic-grid">
        <div class="topic-card" onclick="navigateTo('trinity-system')">
          <span class="topic-icon">🤖</span>
          <h3 class="topic-title">The Trinity System</h3>
          <p class="topic-description">Learn how AI agents collaborate with humans to create unprecedented development velocity</p>
        </div>
        
        <div class="topic-card" onclick="navigateTo('tools-overview')">
          <span class="topic-icon">🛠️</span>
          <h3 class="topic-title">Tools & Features</h3>
          <p class="topic-description">Master the Trinity Gateway interface and all integrated development tools</p>
        </div>
        
        <div class="topic-card" onclick="navigateTo('workflows-overview')">
          <span class="topic-icon">⚡</span>
          <h3 class="topic-title">Workflows</h3>
          <p class="topic-description">Discover efficient patterns for AI-assisted development across all project types</p>
        </div>
        
        <div class="topic-card" onclick="navigateTo('concepts-overview')">
          <span class="topic-icon">🏗️</span>
          <h3 class="topic-title">Trinity Concepts</h3>
          <p class="topic-description">Understand the philosophy, architecture, and principles behind Trinity Framework</p>
        </div>
        
        <div class="topic-card" onclick="navigateTo('quick-start')">
          <span class="topic-icon">🚀</span>
          <h3 class="topic-title">Quick Start Guide</h3>
          <p class="topic-description">Get up and running with Trinity Gateway in under 5 minutes</p>
        </div>
        
        <div class="topic-card" onclick="navigateTo('reference-overview')">
          <span class="topic-icon">📖</span>
          <h3 class="topic-title">Quick Reference</h3>
          <p class="topic-description">Commands, shortcuts, troubleshooting, and power user tips</p>
        </div>
      </div>
    `,
    related: []
  },

  // Trinity System Topics
  'trinity-system': {
    id: 'trinity-system',
    title: 'The Trinity Development System',
    icon: '🤖',
    category: 'trinity-system',
    readTime: 5,
    content: `
      <div class="article-header">
        <span class="article-icon">🤖</span>
        <div class="article-meta">
          <h1 class="article-title">The Trinity Development System</h1>
          <p class="article-subtitle">A revolutionary approach to software development through AI-human collaboration</p>
        </div>
      </div>
      
      <div class="article-content">
        <p>The Trinity Development System represents a paradigm shift in how software is created. By combining the analytical power of AI with human creativity and strategic thinking, Trinity enables development at unprecedented speed and quality.</p>
        
        <h2>The Three Pillars of Trinity</h2>
        
        <h3>1. Claude Code - The AI Brain</h3>
        <p><span class="link" onclick="navigateTo('claude-code-overview')">Claude Code</span> is an advanced AI assistant that understands natural language and generates high-quality code. It's not just a code generator - it's a collaborative partner that:</p>
        <ul>
          <li>Understands context and intent from conversational descriptions</li>
          <li>Generates complete, production-ready code with best practices</li>
          <li>Explains its reasoning and teaches as it codes</li>
          <li>Adapts to your coding style and project conventions</li>
          <li>Handles everything from simple scripts to complex architectures</li>
        </ul>
        
        <h3>2. APEX - The Framework Coordinator</h3>
        <p>The <span class="link" onclick="navigateTo('apex-agent')">APEX agent</span> orchestrates the development workflow, ensuring smooth integration between AI capabilities and your project needs:</p>
        <ul>
          <li>Manages project structure and file organization</li>
          <li>Coordinates between different AI capabilities</li>
          <li>Maintains consistency across your codebase</li>
          <li>Handles dependency management and environment setup</li>
          <li>Provides Trinity-specific enhancements and workflows</li>
        </ul>
        
        <h3>3. You - The Creative Visionary</h3>
        <p>As the human developer, you bring irreplaceable elements to the collaboration:</p>
        <ul>
          <li>Creative vision and problem definition</li>
          <li>Business logic and domain expertise</li>
          <li>Strategic decisions and architecture choices</li>
          <li>Quality oversight and user experience design</li>
          <li>Ethical considerations and real-world context</li>
        </ul>
        
        <h2>The Synergy Effect</h2>
        <p>When these three elements work together, the result is greater than the sum of its parts. You can:</p>
        
        <div class="code-block">
          <code>// Traditional Development
Developer: *Spends hours writing boilerplate*
Developer: *Googles syntax and best practices*
Developer: *Debugs implementation details*
Time: 8 hours

// Trinity Development
You: "Create a REST API for user management with auth"
Claude Code: *Generates complete API with JWT auth*
APEX: *Sets up project structure and dependencies*
Time: 30 minutes</code>
        </div>
        
        <h2>Real-World Benefits</h2>
        <ul>
          <li><strong>10x Faster Development</strong>: Focus on what to build, not how to build it</li>
          <li><strong>Higher Quality Code</strong>: AI applies best practices consistently</li>
          <li><strong>Continuous Learning</strong>: Learn from AI explanations and patterns</li>
          <li><strong>Reduced Errors</strong>: AI catches issues before they become bugs</li>
          <li><strong>Better Architecture</strong>: AI suggests optimal patterns for your use case</li>
        </ul>
        
        <h2>Getting Started with Trinity</h2>
        <p>The beauty of Trinity is its simplicity. You don't need to learn a new programming language or complex APIs. Just:</p>
        <ol>
          <li>Open <span class="link" onclick="navigateTo('trinity-gateway-overview')">Trinity Gateway</span> in your browser</li>
          <li>Describe what you want to build in natural language</li>
          <li>Watch as Claude Code generates your solution</li>
          <li>Iterate and refine through conversation</li>
          <li>Export your completed project</li>
        </ol>
        
        <h2>Trinity vs Traditional Development</h2>
        <p>Trinity fundamentally changes the development workflow:</p>
        <ul>
          <li><strong>Before</strong>: Write code → Test → Debug → Repeat</li>
          <li><strong>After</strong>: Describe intent → Review AI code → Refine → Ship</li>
        </ul>
        
        <p>This shift allows developers to operate at a higher level of abstraction, focusing on solving business problems rather than wrestling with syntax and implementation details.</p>
      </div>
      
      <div class="related-topics">
        <h4>Explore Related Topics</h4>
        <div class="related-grid">
          <div class="related-card" onclick="navigateTo('claude-code-overview')">
            <span class="icon">🧠</span>
            <div class="title">Claude Code</div>
          </div>
          <div class="related-card" onclick="navigateTo('apex-agent')">
            <span class="icon">🎯</span>
            <div class="title">APEX Agent</div>
          </div>
          <div class="related-card" onclick="navigateTo('natural-language-coding')">
            <span class="icon">💬</span>
            <div class="title">Natural Language</div>
          </div>
          <div class="related-card" onclick="navigateTo('quick-start')">
            <span class="icon">🚀</span>
            <div class="title">Quick Start</div>
          </div>
        </div>
      </div>
    `,
    keywords: ['trinity', 'system', 'overview', 'ai', 'development', 'collaboration'],
    related: ['claude-code-overview', 'apex-agent', 'natural-language-coding', 'quick-start']
  },

  'claude-code-overview': {
    id: 'claude-code-overview',
    title: 'Claude Code - The AI Brain',
    icon: '🧠',
    category: 'trinity-system',
    readTime: 4,
    content: `
      <div class="article-header">
        <span class="article-icon">🧠</span>
        <div class="article-meta">
          <h1 class="article-title">Claude Code - The AI Brain</h1>
          <p class="article-subtitle">Your AI-powered development partner that understands natural language and writes production-ready code</p>
        </div>
      </div>
      
      <div class="article-content">
        <p>Claude Code is the AI engine at the heart of Trinity Gateway. Built on advanced language models, it transforms natural language descriptions into working software with remarkable accuracy and speed.</p>
        
        <h2>Key Capabilities</h2>
        
        <h3>Natural Language Understanding</h3>
        <p>Claude Code excels at understanding what you want to build from conversational descriptions:</p>
        <ul>
          <li>Interprets technical and non-technical language equally well</li>
          <li>Understands context from previous conversations</li>
          <li>Asks clarifying questions when requirements are ambiguous</li>
          <li>Remembers project conventions and preferences</li>
        </ul>
        
        <h3>Code Generation Excellence</h3>
        <p>When generating code, Claude Code consistently delivers:</p>
        <ul>
          <li><strong>Complete Solutions</strong>: Not just snippets, but fully functional applications</li>
          <li><strong>Best Practices</strong>: Modern patterns, security considerations, and performance optimizations</li>
          <li><strong>Multiple Languages</strong>: Proficient in Python, JavaScript, TypeScript, Go, Rust, and more</li>
          <li><strong>Framework Expertise</strong>: Deep knowledge of React, Vue, Django, Express, and other popular frameworks</li>
        </ul>
        
        <h2>How Claude Code Works</h2>
        
        <div class="code-block">
          <code>// Example interaction
You: "I need a user authentication system with email verification"

Claude Code: "I'll create a complete authentication system for you. Let me build:
1. User registration endpoint with email validation
2. Secure password hashing with bcrypt
3. JWT token generation for sessions
4. Email verification with secure tokens
5. Password reset functionality

Here's the implementation..."

[Generates complete, production-ready code]</code>
        </div>
        
        <h3>Beyond Code Generation</h3>
        <p>Claude Code is more than just a code generator. It's a comprehensive development assistant that:</p>
        <ul>
          <li><strong>Explains</strong>: Provides clear explanations of how the code works</li>
          <li><strong>Teaches</strong>: Shares best practices and alternative approaches</li>
          <li><strong>Debugs</strong>: Identifies and fixes issues in existing code</li>
          <li><strong>Refactors</strong>: Improves code structure and performance</li>
          <li><strong>Tests</strong>: Generates comprehensive test suites</li>
          <li><strong>Documents</strong>: Creates clear, professional documentation</li>
        </ul>
        
        <h2>Working with Claude Code</h2>
        
        <h3>Effective Communication</h3>
        <p>To get the best results from Claude Code:</p>
        <ol>
          <li><strong>Be Clear</strong>: Describe what you want to achieve, not how to code it</li>
          <li><strong>Provide Context</strong>: Share relevant details about your project</li>
          <li><strong>Iterate</strong>: Refine the solution through conversation</li>
          <li><strong>Ask Questions</strong>: Claude Code loves to explain and teach</li>
        </ol>
        
        <h3>Advanced Features</h3>
        <ul>
          <li><strong>Multi-file Projects</strong>: Manages complex projects with multiple files</li>
          <li><strong>Dependency Management</strong>: Handles package installation and configuration</li>
          <li><strong>Database Design</strong>: Creates schemas and migration scripts</li>
          <li><strong>API Integration</strong>: Connects to external services and APIs</li>
          <li><strong>Performance Optimization</strong>: Identifies and resolves bottlenecks</li>
        </ul>
        
        <h2>Claude Code Commands</h2>
        <p>Access Claude Code features with these commands:</p>
        <ul>
          <li><code>@apex help</code> - Get started with Claude Code</li>
          <li><code>@apex create [project]</code> - Start a new project</li>
          <li><code>@apex explain [code]</code> - Get detailed explanations</li>
          <li><code>@apex debug</code> - Fix issues in your code</li>
          <li><code>@apex test</code> - Generate test suites</li>
        </ul>
        
        <h2>Privacy and Security</h2>
        <p>Claude Code is designed with privacy in mind:</p>
        <ul>
          <li>Your code stays in your workspace</li>
          <li>No training on user data</li>
          <li>Secure handling of sensitive information</li>
          <li>Compliant with data protection regulations</li>
        </ul>
      </div>
      
      <div class="related-topics">
        <h4>Learn More</h4>
        <div class="related-grid">
          <div class="related-card" onclick="navigateTo('natural-language-coding')">
            <span class="icon">💬</span>
            <div class="title">Natural Language</div>
          </div>
          <div class="related-card" onclick="navigateTo('claude-commands')">
            <span class="icon">⌨️</span>
            <div class="title">Commands</div>
          </div>
          <div class="related-card" onclick="navigateTo('code-examples')">
            <span class="icon">📝</span>
            <div class="title">Examples</div>
          </div>
          <div class="related-card" onclick="navigateTo('debugging-with-ai')">
            <span class="icon">🐛</span>
            <div class="title">Debugging</div>
          </div>
        </div>
      </div>
    `,
    keywords: ['claude', 'code', 'ai', 'assistant', 'generation', 'natural language'],
    related: ['natural-language-coding', 'claude-commands', 'code-examples', 'debugging-with-ai']
  },

  'apex-agent': {
    id: 'apex-agent',
    title: 'APEX - The Framework Coordinator',
    icon: '🎯',
    category: 'trinity-system',
    readTime: 3,
    content: `
      <div class="article-header">
        <span class="article-icon">🎯</span>
        <div class="article-meta">
          <h1 class="article-title">APEX - The Framework Coordinator</h1>
          <p class="article-subtitle">Your Trinity Framework orchestrator that ensures smooth, efficient development workflows</p>
        </div>
      </div>
      
      <div class="article-content">
        <p>APEX is the specialized agent that coordinates between Claude Code, the Trinity Framework, and your development environment. Think of APEX as your project manager, ensuring everything works together seamlessly.</p>
        
        <h2>What APEX Does</h2>
        
        <h3>Workflow Orchestration</h3>
        <p>APEX manages the entire development lifecycle:</p>
        <ul>
          <li>Coordinates file creation and organization</li>
          <li>Manages project structure and conventions</li>
          <li>Handles dependency installation and configuration</li>
          <li>Ensures consistent code style across your project</li>
          <li>Orchestrates multi-step development tasks</li>
        </ul>
        
        <h3>Trinity Framework Integration</h3>
        <p>As a Trinity Framework specialist, APEX provides:</p>
        <ul>
          <li><strong>Framework Patterns</strong>: Implements Trinity best practices</li>
          <li><strong>Agent Coordination</strong>: Manages interactions between AI agents</li>
          <li><strong>Protocol Compliance</strong>: Ensures framework standards are met</li>
          <li><strong>Enhanced Workflows</strong>: Provides Trinity-specific development patterns</li>
        </ul>
        
        <h2>APEX in Action</h2>
        
        <div class="code-block">
          <code>// Example: APEX coordinating a full-stack project
You: "@apex create a task management app"

APEX: "I'll coordinate the creation of your task management app:
1. Setting up project structure
2. Initializing frontend (React + TypeScript)
3. Creating backend API (Node.js + Express)
4. Setting up database (PostgreSQL)
5. Configuring development environment

Let me orchestrate this with Claude Code..."

[APEX coordinates multiple Claude Code sessions to build each component]</code>
        </div>
        
        <h3>Key Responsibilities</h3>
        
        <h4>1. Project Setup</h4>
        <ul>
          <li>Creates optimal folder structures</li>
          <li>Initializes version control (Git)</li>
          <li>Sets up development environments</li>
          <li>Configures build tools and scripts</li>
        </ul>
        
        <h4>2. Code Organization</h4>
        <ul>
          <li>Maintains clean architecture</li>
          <li>Enforces naming conventions</li>
          <li>Organizes imports and exports</li>
          <li>Manages configuration files</li>
        </ul>
        
        <h4>3. Quality Assurance</h4>
        <ul>
          <li>Runs automated tests</li>
          <li>Performs code quality checks</li>
          <li>Ensures security best practices</li>
          <li>Validates performance metrics</li>
        </ul>
        
        <h2>Working with APEX</h2>
        
        <h3>APEX Commands</h3>
        <p>Interact with APEX using these commands:</p>
        <ul>
          <li><code>@apex status</code> - Check project status and health</li>
          <li><code>@apex organize</code> - Restructure and clean up code</li>
          <li><code>@apex deploy</code> - Prepare project for deployment</li>
          <li><code>@apex optimize</code> - Improve performance and efficiency</li>
          <li><code>@apex integrate [service]</code> - Add external services</li>
        </ul>
        
        <h3>APEX Workflows</h3>
        <p>APEX excels at managing complex workflows:</p>
        <ol>
          <li><strong>Planning</strong>: Analyzes requirements and creates implementation plans</li>
          <li><strong>Coordination</strong>: Delegates tasks to appropriate AI agents</li>
          <li><strong>Integration</strong>: Ensures all components work together</li>
          <li><strong>Validation</strong>: Verifies the final result meets requirements</li>
        </ol>
        
        <h2>APEX vs Direct Claude Code</h2>
        <p>When to use APEX instead of Claude Code directly:</p>
        <ul>
          <li><strong>Use APEX for</strong>: Project setup, workflow coordination, Trinity-specific features</li>
          <li><strong>Use Claude Code for</strong>: Direct code generation, specific algorithms, isolated tasks</li>
        </ul>
        
        <h2>Advanced APEX Features</h2>
        <ul>
          <li><strong>Multi-Agent Coordination</strong>: Manages complex tasks across multiple AI sessions</li>
          <li><strong>State Management</strong>: Tracks project progress and context</li>
          <li><strong>Intelligent Suggestions</strong>: Recommends next steps based on project state</li>
          <li><strong>Framework Education</strong>: Teaches Trinity patterns and best practices</li>
        </ul>
      </div>
      
      <div class="related-topics">
        <h4>Related Topics</h4>
        <div class="related-grid">
          <div class="related-card" onclick="navigateTo('trinity-framework')">
            <span class="icon">🏗️</span>
            <div class="title">Trinity Framework</div>
          </div>
          <div class="related-card" onclick="navigateTo('apex-commands')">
            <span class="icon">⌨️</span>
            <div class="title">APEX Commands</div>
          </div>
          <div class="related-card" onclick="navigateTo('project-workflows')">
            <span class="icon">⚡</span>
            <div class="title">Workflows</div>
          </div>
          <div class="related-card" onclick="navigateTo('agent-coordination')">
            <span class="icon">🤝</span>
            <div class="title">Coordination</div>
          </div>
        </div>
      </div>
    `,
    keywords: ['apex', 'agent', 'coordinator', 'framework', 'workflow', 'orchestration'],
    related: ['trinity-framework', 'apex-commands', 'project-workflows', 'agent-coordination']
  },

  // Quick Start Guide
  'quick-start': {
    id: 'quick-start',
    title: 'Quick Start Guide',
    icon: '🚀',
    category: 'getting-started',
    readTime: 3,
    content: `
      <div class="article-header">
        <span class="article-icon">🚀</span>
        <div class="article-meta">
          <h1 class="article-title">Quick Start Guide</h1>
          <p class="article-subtitle">Get up and running with Trinity Gateway in under 5 minutes</p>
        </div>
      </div>
      
      <div class="article-content">
        <p>Welcome to Trinity Gateway! This guide will have you building AI-powered applications in just a few minutes.</p>
        
        <h2>Step 1: Access Trinity Gateway</h2>
        <p>Trinity Gateway runs entirely in your browser - no installation required!</p>
        <ol>
          <li>Visit <strong>demo.trinityapex.io</strong></li>
          <li>Click "Sign in with LinkedIn" (or Google/GitHub)</li>
          <li>Wait for your workspace to load (usually under 30 seconds)</li>
        </ol>
        
        <h2>Step 2: Understand the Interface</h2>
        <p>Your Trinity Gateway workspace has three main areas:</p>
        <ul>
          <li><strong>Terminal (Left)</strong>: Where Claude Code runs and you interact with AI</li>
          <li><strong>File Manager (Right)</strong>: Browse, upload, and download files</li>
          <li><strong>Instructions Panel (Top)</strong>: Quick tips and current status</li>
        </ul>
        
        <h2>Step 3: Your First AI Interaction</h2>
        <p>Let's create something simple to see Trinity in action:</p>
        
        <div class="code-block">
          <code>// In the terminal, type:
@apex help me create a simple web page

// Claude Code will respond and start generating code
// You'll see files appear in the file manager as they're created</code>
        </div>
        
        <h2>Step 4: Try a Real Project</h2>
        <p>Now let's build something more substantial. Try one of these:</p>
        
        <h3>Option A: Todo List App</h3>
        <div class="code-block">
          <code>@apex create a todo list app with React
- Should have add, delete, and mark complete features
- Use local storage to persist todos
- Make it look modern and clean</code>
        </div>
        
        <h3>Option B: REST API</h3>
        <div class="code-block">
          <code>@apex build a REST API for a blog
- Need endpoints for posts and comments  
- Use Node.js and Express
- Include basic authentication</code>
        </div>
        
        <h3>Option C: Data Analysis</h3>
        <div class="code-block">
          <code>@apex help me analyze some data
- I need to process CSV files
- Create visualizations with charts
- Generate a summary report</code>
        </div>
        
        <h2>Step 5: Iterate and Refine</h2>
        <p>The power of Trinity comes from natural conversation. After Claude Code generates initial code:</p>
        <ul>
          <li>Ask for changes: "Can you make the buttons blue instead?"</li>
          <li>Add features: "Now add user authentication"</li>
          <li>Fix issues: "There's an error when I click submit"</li>
          <li>Get explanations: "How does the authentication work?"</li>
        </ul>
        
        <h2>Essential Commands</h2>
        <p>Here are the most important commands to remember:</p>
        <ul>
          <li><code>@apex help</code> - Get help anytime</li>
          <li><code>@apex status</code> - Check your project status</li>
          <li><code>@apex create [project]</code> - Start a new project</li>
          <li><code>@apex run</code> - Run your application</li>
          <li><code>clear</code> - Clear the terminal</li>
        </ul>
        
        <h2>Tips for Success</h2>
        <ol>
          <li><strong>Be Descriptive</strong>: The more detail you provide, the better the results</li>
          <li><strong>Think in Features</strong>: Describe what you want, not how to code it</li>
          <li><strong>Iterate Naturally</strong>: Refine through conversation like with a colleague</li>
          <li><strong>Save Your Work</strong>: Download important files or push to Git</li>
          <li><strong>Experiment</strong>: Try different approaches and learn what works</li>
        </ol>
        
        <h2>Common First Projects</h2>
        <p>Great projects to start with:</p>
        <ul>
          <li><strong>Personal Website</strong>: Portfolio, blog, or resume site</li>
          <li><strong>Web Apps</strong>: Calculator, timer, note-taking app</li>
          <li><strong>APIs</strong>: Weather service, URL shortener, task manager</li>
          <li><strong>Data Tools</strong>: CSV processor, chart generator, report builder</li>
          <li><strong>Games</strong>: Tic-tac-toe, memory game, quiz app</li>
        </ul>
        
        <h2>Next Steps</h2>
        <p>Ready to dive deeper? Check out:</p>
        <ul>
          <li><span class="link" onclick="navigateTo('natural-language-coding')">Natural Language Coding</span> - Master AI communication</li>
          <li><span class="link" onclick="navigateTo('project-workflows')">Project Workflows</span> - Build complex applications</li>
          <li><span class="link" onclick="navigateTo('keyboard-shortcuts')">Keyboard Shortcuts</span> - Work faster</li>
          <li><span class="link" onclick="navigateTo('troubleshooting')">Troubleshooting</span> - Solve common issues</li>
        </ul>
        
        <p><strong>Remember:</strong> There's no wrong way to start. Just describe what you want to build and let Trinity help you create it!</p>
      </div>
      
      <div class="related-topics">
        <h4>Continue Learning</h4>
        <div class="related-grid">
          <div class="related-card" onclick="navigateTo('first-project')">
            <span class="icon">👶</span>
            <div class="title">First Project</div>
          </div>
          <div class="related-card" onclick="navigateTo('interface-guide')">
            <span class="icon">🖥️</span>
            <div class="title">Interface Guide</div>
          </div>
          <div class="related-card" onclick="navigateTo('commands-cheatsheet')">
            <span class="icon">📋</span>
            <div class="title">Commands</div>
          </div>
          <div class="related-card" onclick="navigateTo('tips-tricks')">
            <span class="icon">💡</span>
            <div class="title">Tips & Tricks</div>
          </div>
        </div>
      </div>
    `,
    keywords: ['quick', 'start', 'getting started', 'begin', 'tutorial', 'first', 'guide'],
    related: ['first-project', 'interface-guide', 'commands-cheatsheet', 'tips-tricks']
  }

  // Continue with more topics...
};

// Search index for quick lookups
const SearchIndex = {
  buildIndex: function() {
    const index = {};
    
    Object.entries(TrinityContent).forEach(([id, topic]) => {
      // Index by keywords
      if (topic.keywords) {
        topic.keywords.forEach(keyword => {
          if (!index[keyword]) index[keyword] = [];
          index[keyword].push(id);
        });
      }
      
      // Index by title words
      const titleWords = topic.title.toLowerCase().split(' ');
      titleWords.forEach(word => {
        if (word.length > 2) {
          if (!index[word]) index[word] = [];
          if (!index[word].includes(id)) index[word].push(id);
        }
      });
    });
    
    return index;
  }
};

// Initialize search index
const searchIndex = SearchIndex.buildIndex();