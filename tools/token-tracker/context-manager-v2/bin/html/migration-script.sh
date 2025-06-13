#!/bin/bash
# HTML File Migration Script for Trinity Framework 2.0 Core Documentation

# Base directories
SOURCE_DIR="/home/alreadyinuse/git/trinity-historian-workspace/tools/token-tracker/context-manager-v2/bin"
TARGET_DIR="${SOURCE_DIR}/html"

# Function to create directories
create_directories() {
    echo "Creating directory structure..."
    mkdir -p "${TARGET_DIR}/assets/css"
    mkdir -p "${TARGET_DIR}/assets/js"
    mkdir -p "${TARGET_DIR}/assets/images"
    mkdir -p "${TARGET_DIR}/reference"
    mkdir -p "${TARGET_DIR}/principles"
    mkdir -p "${TARGET_DIR}/guides"
    mkdir -p "${TARGET_DIR}/templates"
    
    # Create .nojekyll for GitHub Pages
    touch "${TARGET_DIR}/.nojekyll"
    echo "Directory structure created."
}

# Function to move existing HTML files
move_files() {
    echo "Moving existing HTML files..."
    
    # Check and move quick-start.html
    if [ -f "${SOURCE_DIR}/quick-start.html" ]; then
        cp "${SOURCE_DIR}/quick-start.html" "${TARGET_DIR}/"
        echo "Moved quick-start.html"
    else
        echo "quick-start.html not found in source directory"
    fi
    
    # Check and move agent-roles.html
    if [ -f "${SOURCE_DIR}/agent-roles.html" ]; then
        cp "${SOURCE_DIR}/agent-roles.html" "${TARGET_DIR}/reference/"
        echo "Moved agent-roles.html to reference/"
    else
        echo "agent-roles.html not found in source directory"
    fi
    
    echo "File migration completed."
}

# Function to update CSS references
update_css() {
    echo "Extracting and updating CSS references..."
    
    # Create styles.css
    cat > "${TARGET_DIR}/assets/css/styles.css" << 'EOL'
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    background-color: #f8f9fa;
}
.container {
    background-color: #ffffff;
    border-radius: 8px;
    padding: 30px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
h1 {
    color: #0366d6;
    border-bottom: 1px solid #eaecef;
    padding-bottom: 10px;
    margin-top: 0;
}
h2 {
    margin-top: 24px;
    margin-bottom: 16px;
    font-weight: 600;
    color: #24292e;
    border-bottom: 1px solid #eaecef;
    padding-bottom: 5px;
}
h3 {
    margin-top: 20px;
    color: #24292e;
}
a {
    color: #0366d6;
    text-decoration: none;
}
a:hover {
    text-decoration: underline;
}
code {
    font-family: SFMono-Regular, Consolas, "Liberation Mono", Menlo, monospace;
    background-color: #f6f8fa;
    padding: 2px 5px;
    border-radius: 3px;
    font-size: 85%;
}
pre {
    background-color: #f6f8fa;
    border-radius: 3px;
    padding: 16px;
    overflow: auto;
    font-family: SFMono-Regular, Consolas, "Liberation Mono", Menlo, monospace;
}
blockquote {
    border-left: 4px solid #dfe2e5;
    color: #6a737d;
    margin: 0;
    padding: 0 16px;
}
.home-link {
    margin-top: 30px;
    display: block;
}
footer {
    margin-top: 40px;
    padding-top: 20px;
    border-top: 1px solid #eaecef;
    color: #6a737d;
    font-size: 14px;
    text-align: center;
}
.metadata {
    background-color: #f6f8fa;
    border-radius: 3px;
    padding: 10px;
    margin-bottom: 20px;
    font-size: 14px;
}
.note {
    background-color: #f1f8ff;
    border-left: 4px solid #0366d6;
    padding: 12px;
    margin: 16px 0;
    border-radius: 3px;
}
.warning {
    background-color: #fff5f7;
    border-left: 4px solid #d73a49;
    padding: 12px;
    margin: 16px 0;
    border-radius: 3px;
}
table {
    border-collapse: collapse;
    width: 100%;
    margin: 20px 0;
}
th, td {
    border: 1px solid #dfe2e5;
    padding: 8px 12px;
    text-align: left;
}
th {
    background-color: #f6f8fa;
}
.role-card {
    border: 1px solid #dfe2e5;
    border-radius: 6px;
    padding: 16px;
    margin: 24px 0;
    background-color: #f8f9fa;
}
.role-header {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
}
.role-icon {
    font-size: 24px;
    margin-right: 12px;
}
.role-name {
    font-size: 20px;
    font-weight: bold;
    margin: 0;
    color: #0366d6;
}
EOL
    
    echo "CSS file created at ${TARGET_DIR}/assets/css/styles.css"
    
    # Update quick-start.html to use external CSS
    if [ -f "${TARGET_DIR}/quick-start.html" ]; then
        sed -i 's/<style>.*<\/style>/<link rel="stylesheet" href="assets\/css\/styles.css">/' "${TARGET_DIR}/quick-start.html"
        echo "Updated CSS reference in quick-start.html"
    fi
    
    # Update agent-roles.html to use external CSS
    if [ -f "${TARGET_DIR}/reference/agent-roles.html" ]; then
        sed -i 's/<style>.*<\/style>/<link rel="stylesheet" href="..\/assets\/css\/styles.css">/' "${TARGET_DIR}/reference/agent-roles.html"
        echo "Updated CSS reference in reference/agent-roles.html"
    fi
    
    echo "CSS updates completed."
}

# Function to update internal links
update_links() {
    echo "Updating internal links..."
    
    # Update links in quick-start.html
    if [ -f "${TARGET_DIR}/quick-start.html" ]; then
        sed -i 's/href="\.\.\/reference\/agent-roles\.html"/href="reference\/agent-roles.html"/' "${TARGET_DIR}/quick-start.html"
        sed -i 's/href="\.\.\/principles\/context-resilience\.html"/href="principles\/context-resilience.html"/' "${TARGET_DIR}/quick-start.html"
        sed -i 's/href="\.\.\/guides\/aar-system\.html"/href="guides\/aar-system.html"/' "${TARGET_DIR}/quick-start.html"
        sed -i 's/href="\.\.\/guides\/context-management\.html"/href="guides\/context-management.html"/' "${TARGET_DIR}/quick-start.html"
        sed -i 's/href="\.\.\/"/href="index.html"/' "${TARGET_DIR}/quick-start.html"
        echo "Updated links in quick-start.html"
    fi
    
    # Update links in agent-roles.html
    if [ -f "${TARGET_DIR}/reference/agent-roles.html" ]; then
        sed -i 's/href="\.\.\/"/href="\.\.\/index.html"/' "${TARGET_DIR}/reference/agent-roles.html"
        echo "Updated links in reference/agent-roles.html"
    fi
    
    echo "Link updates completed."
}

# Function to create placeholder files
create_placeholders() {
    echo "Creating placeholder files..."
    
    # Create principles/context-resilience.html
    mkdir -p "${TARGET_DIR}/principles"
    cat > "${TARGET_DIR}/principles/context-resilience.html" << 'EOL'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Context Resilience - Trinity Framework 2.0 Core</title>
    <link rel="stylesheet" href="../assets/css/styles.css">
</head>
<body>
    <div class="container">
        <div class="metadata">
            <strong>VERSION</strong>: 1.0.0 | 
            <strong>CREATED</strong>: June 13, 2025 | 
            <strong>STATUS</strong>: Draft | 
            <strong>FRAMEWORK</strong>: Trinity Framework 2.0
        </div>

        <h1>Context Resilience</h1>
        
        <p>This page will contain documentation on Context Resilience principles in Trinity Framework 2.0.</p>

        <div class="note">
            <p><strong>Note</strong>: This page is currently under development.</p>
        </div>

        <a href="../index.html" class="home-link">← Back to Documentation Home</a>
    </div>
    
    <footer>
        <p>Trinity Framework 2.0 Core &copy; 2025 | Licensed under Apache 2.0</p>
        <p><em>Framework 2.0 COMPLIANT</em></p>
    </footer>
</body>
</html>
EOL
    echo "Created principles/context-resilience.html"
    
    # Create guides/aar-system.html
    mkdir -p "${TARGET_DIR}/guides"
    cat > "${TARGET_DIR}/guides/aar-system.html" << 'EOL'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AAR System - Trinity Framework 2.0 Core</title>
    <link rel="stylesheet" href="../assets/css/styles.css">
</head>
<body>
    <div class="container">
        <div class="metadata">
            <strong>VERSION</strong>: 1.0.0 | 
            <strong>CREATED</strong>: June 13, 2025 | 
            <strong>STATUS</strong>: Draft | 
            <strong>FRAMEWORK</strong>: Trinity Framework 2.0
        </div>

        <h1>AAR System</h1>
        
        <p>This page will contain documentation on the After Action Review (AAR) system for knowledge preservation in Trinity Framework 2.0.</p>

        <div class="note">
            <p><strong>Note</strong>: This page is currently under development.</p>
        </div>

        <a href="../index.html" class="home-link">← Back to Documentation Home</a>
    </div>
    
    <footer>
        <p>Trinity Framework 2.0 Core &copy; 2025 | Licensed under Apache 2.0</p>
        <p><em>Framework 2.0 COMPLIANT</em></p>
    </footer>
</body>
</html>
EOL
    echo "Created guides/aar-system.html"
    
    # Create guides/context-management.html
    cat > "${TARGET_DIR}/guides/context-management.html" << 'EOL'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Context Management - Trinity Framework 2.0 Core</title>
    <link rel="stylesheet" href="../assets/css/styles.css">
</head>
<body>
    <div class="container">
        <div class="metadata">
            <strong>VERSION</strong>: 1.0.0 | 
            <strong>CREATED</strong>: June 13, 2025 | 
            <strong>STATUS</strong>: Draft | 
            <strong>FRAMEWORK</strong>: Trinity Framework 2.0
        </div>

        <h1>Context Management</h1>
        
        <p>This page will contain documentation on context management techniques and tools in Trinity Framework 2.0.</p>

        <div class="note">
            <p><strong>Note</strong>: This page is currently under development.</p>
        </div>

        <a href="../index.html" class="home-link">← Back to Documentation Home</a>
    </div>
    
    <footer>
        <p>Trinity Framework 2.0 Core &copy; 2025 | Licensed under Apache 2.0</p>
        <p><em>Framework 2.0 COMPLIANT</em></p>
    </footer>
</body>
</html>
EOL
    echo "Created guides/context-management.html"
    
    echo "Placeholder creation completed."
}

# Function to create index.html
create_index() {
    echo "Creating index.html..."
    
    cat > "${TARGET_DIR}/index.html" << 'EOL'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trinity Framework 2.0 Core Documentation</title>
    <link rel="stylesheet" href="assets/css/styles.css">
    <style>
        .sidebar {
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            background-color: #f1f8ff;
            padding: 20px;
            overflow-y: auto;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .nav-section {
            margin-bottom: 20px;
        }
        .nav-section-title {
            font-weight: bold;
            color: #0366d6;
            margin-bottom: 10px;
            border-bottom: 1px solid #e1e4e8;
            padding-bottom: 5px;
        }
        .nav-list {
            list-style-type: none;
            padding-left: 10px;
        }
        .nav-list li {
            margin-bottom: 8px;
        }
        .nav-list a {
            display: block;
            padding: 5px;
            border-radius: 3px;
        }
        .nav-list a:hover {
            background-color: #e1e4e8;
            text-decoration: none;
        }
        .nav-list a.active {
            background-color: #0366d6;
            color: white;
            text-decoration: none;
        }
        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }
            .main-content {
                margin-left: 0;
            }
        }
        .featured-section {
            display: flex;
            justify-content: space-between;
            margin: 30px 0;
            flex-wrap: wrap;
        }
        .featured-card {
            width: 48%;
            background-color: #ffffff;
            border-radius: 6px;
            padding: 16px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
        }
        .featured-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }
        .doc-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        .doc-card {
            background-color: #ffffff;
            border-radius: 6px;
            padding: 16px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
        }
        .doc-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }
        .doc-card h3 {
            margin-top: 0;
            color: #0366d6;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="nav-section">
            <div class="nav-section-title">Getting Started</div>
            <ul class="nav-list">
                <li><a href="index.html" class="active">Home</a></li>
                <li><a href="quick-start.html">Quick Start Guide</a></li>
            </ul>
        </div>
        <div class="nav-section">
            <div class="nav-section-title">Reference</div>
            <ul class="nav-list">
                <li><a href="reference/agent-roles.html">Agent Roles</a></li>
            </ul>
        </div>
        <div class="nav-section">
            <div class="nav-section-title">Principles</div>
            <ul class="nav-list">
                <li><a href="principles/context-resilience.html">Context Resilience</a></li>
            </ul>
        </div>
        <div class="nav-section">
            <div class="nav-section-title">Guides</div>
            <ul class="nav-list">
                <li><a href="guides/context-management.html">Context Management</a></li>
                <li><a href="guides/aar-system.html">AAR System</a></li>
            </ul>
        </div>
    </div>

    <div class="main-content">
        <div class="container">
            <div class="metadata">
                <strong>VERSION</strong>: 1.0.0 | 
                <strong>CREATED</strong>: June 13, 2025 | 
                <strong>STATUS</strong>: Release Candidate | 
                <strong>FRAMEWORK</strong>: Trinity Framework 2.0
            </div>

            <h1>Trinity Framework 2.0 Core Documentation</h1>
            
            <p>Welcome to the official documentation for Trinity Framework 2.0 Core, a comprehensive system for managing agent-based workspaces with specialized roles and capabilities.</p>

            <div class="note">
                <p><strong>Note</strong>: This documentation is for Trinity Framework 2.0 Core. For previous versions, please refer to the archived documentation.</p>
            </div>

            <h2>Featured Documentation</h2>
            
            <div class="featured-section">
                <div class="featured-card">
                    <h3>Quick Start Guide</h3>
                    <p>Get up and running quickly with Trinity Framework 2.0 Core. Learn how to set up agent workspaces, configure your environment, and start building with the framework.</p>
                    <p><a href="quick-start.html">Read Quick Start Guide →</a></p>
                </div>
                <div class="featured-card">
                    <h3>Agent Roles</h3>
                    <p>Understand the three specialized agent roles in Trinity Framework 2.0: APEX, ANALYST, and HISTORIAN. Learn about their responsibilities, capabilities, and how they work together.</p>
                    <p><a href="reference/agent-roles.html">Explore Agent Roles →</a></p>
                </div>
            </div>

            <h2>Documentation Sections</h2>
            
            <div class="doc-grid">
                <div class="doc-card">
                    <h3>Getting Started</h3>
                    <p>Quick start guides, installation instructions, and basic setup information.</p>
                    <p><a href="quick-start.html">Quick Start Guide</a></p>
                </div>
                <div class="doc-card">
                    <h3>Reference</h3>
                    <p>Detailed reference documentation for all components of Trinity Framework 2.0 Core.</p>
                    <p><a href="reference/agent-roles.html">Agent Roles</a></p>
                </div>
                <div class="doc-card">
                    <h3>Principles</h3>
                    <p>Core architectural principles and design philosophies of Trinity Framework 2.0.</p>
                    <p><a href="principles/context-resilience.html">Context Resilience</a></p>
                </div>
                <div class="doc-card">
                    <h3>Guides</h3>
                    <p>How-to guides and tutorials for common tasks and workflows.</p>
                    <p><a href="guides/context-management.html">Context Management</a></p>
                    <p><a href="guides/aar-system.html">AAR System</a></p>
                </div>
            </div>
        </div>
        
        <footer>
            <p>Trinity Framework 2.0 Core &copy; 2025 | Licensed under Apache 2.0</p>
            <p><em>Framework 2.0 COMPLIANT</em></p>
        </footer>
    </div>
</body>
</html>
EOL
    echo "Created index.html"
}

# Main execution
echo "Starting HTML file migration..."
create_directories
move_files
update_css
update_links
create_placeholders
create_index
echo "HTML file migration completed successfully!"