# Workspace Organization

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Draft  
**FRAMEWORK**: Trinity Framework 2.0  

---

## Introduction

Workspace organization is a foundational element of Trinity Framework 2.0 Core, providing consistent structure that enhances recovery capabilities and improves operational efficiency. This document outlines the standardized workspace structure, file naming conventions, and organizational best practices.

## Workspace Structure Principles

The Trinity Framework 2.0 Core workspace organization is built on these key principles:

1. **Predictable Locations**: Critical files must be in consistent, known locations
2. **Recovery Prioritization**: Most important recovery files at the root level
3. **Logical Grouping**: Files organized by purpose and function
4. **Access Efficiency**: Frequently accessed files in easily accessible locations
5. **Root Directory Constraint**: Maximum 10 files in root directory

## Standard Directory Structure

### Root Directory

The root directory should contain only essential protocol files and high-level documentation:

- **AGENT.md**: Primary identity and role definition
- **AUTO-COMPACT.md**: Recovery information for context resets
- **STATUS.md**: Current operational status
- **README.md**: Workspace overview
- **Other critical files**: Limited to 10 total files maximum

### Required Directories

The following directories must exist in every workspace:

#### /AAR/ - After Action Review

Purpose: Store session and incident documentation for context retention and learning

- **/AAR/sessions/**: Ongoing session documentation
  - File naming: `YYYY-MM-DD-description.md`
  - Content: Session summary, activities, insights, next actions
  - Example: `2025-06-10-context-management-implementation.md`

- **/AAR/incidents/**: Major incident analysis
  - File naming: `YYYY-MM-DD-incident-name-RCA.md` (RCA = Root Cause Analysis)
  - Content: Incident details, impact, root cause, resolution, prevention
  - Example: `2025-06-05-protocol-file-corruption-RCA.md`

#### /projects/ - Active Projects

Purpose: Store active implementation and development work

- Project-specific subdirectories
  - Directory naming: `project-name/`
  - Structure: Each project has its own internal structure
  - Example: `context-management/`, `agent-identity-protocol/`

- Multiple active projects allowed
  - Each in its own subdirectory
  - README.md in each project directory
  - STATUS.md for project-specific status

#### /reports/ - Documentation and Reports

Purpose: Store finalized reports, guides, and documentation

- File naming: `topic-description.md`
- Content: Comprehensive documentation, analysis results, implementation guides
- Example: `context-management-implementation-report.md`

#### /archives/ - Archived Projects

Purpose: Store completed projects and historical reference materials

- Directory naming: `archived-project-name/`
- Content: Complete project artifacts, including documentation
- Example: `archives/phase1-implementation/`

#### /tools/ - Utility Scripts

Purpose: Store scripts and utilities for workspace management

- File naming: `descriptive-name.sh` or `descriptive-name.js`
- Content: Utility scripts, tools, and helpers
- Example: `context-checker.sh`, `protocol-validator.js`

### Optional Directories

The following directories are optional but recommended:

#### /templates/ - Reusable Templates

Purpose: Store template files for consistency

- Subdirectories by template type
- Example: `/templates/aar/`, `/templates/protocol-files/`

#### /docs/ - Public Documentation

Purpose: Store documentation intended for sharing

- Organized by topic
- Example: `/docs/getting-started/`, `/docs/reference/`

## File Naming Conventions

### Protocol Files

- Must use ALL CAPS: `AGENT.md`, `AUTO-COMPACT.md`, `STATUS.md`
- Must be at root directory level
- Must use .md extension for markdown formatting

### AAR Session Documents

- Format: `YYYY-MM-DD-description.md`
- Use hyphens to separate date components and words
- Use lowercase for description
- Example: `2025-06-12-context-tracking-implementation.md`

### Implementation Files

- Format: `descriptive-name.extension`
- Use hyphens to separate words
- Use lowercase for names
- Include function in name
- Example: `token-counter.js`, `checkpoint-manager.js`

### Scripts

- Format: `descriptive-action.sh`
- Use hyphens to separate words
- Use lowercase for names
- Make script purpose clear in name
- Example: `check-protocol-files.sh`, `generate-report.sh`

## Root Directory Management

### 10-File Limit

The root directory should contain no more than 10 files to maintain clarity and focus on critical recovery files.

#### Required Root Files

1. **AGENT.md**: Primary identity and role definition
2. **AUTO-COMPACT.md**: Recovery information for context resets
3. **STATUS.md**: Current operational status
4. **README.md**: Workspace overview and entry point

#### Optional Root Files

5. **LICENSE**: Project license information
6. **CHANGELOG.md**: Version history and changes
7. **CONTRIBUTING.md**: Contribution guidelines
8. **ROADMAP.md**: Future development plans
9. **CONFIG.md**: Configuration reference
10. **SECURITY.md**: Security policies and procedures

### Excess File Management

If more than 10 files would be needed in the root directory:

1. Create logical subdirectories
2. Move related files into appropriate subdirectories
3. Update references to moved files
4. Consider creating a root-level INDEX.md to catalog file locations

## File Structure Standards

### Markdown Formatting

- Use H1 (`#`) for document title
- Use H2 (`##`) for major sections
- Use H3 (`###`) for subsections
- Use lists for sequential items or options
- Use code blocks for commands and code examples
- Use tables for structured data
- Use emphasis (`**bold**`, `*italic*`) for highlighting

### Document Headers

All major documents should include a standardized header:

```markdown
# Document Title

**VERSION**: X.Y.Z  
**CREATED**: [Creation Date]  
**UPDATED**: [Last Update Date]  
**STATUS**: [Draft/Final]  
**FRAMEWORK**: Trinity Framework 2.0  

---

[Document content starts here]
```

### Section Organization

Organize sections in order of importance for recovery:

1. Critical information for recovery
2. Current state and status
3. Implementation details
4. Background information
5. Reference material

## Best Practices

### Workspace Organization

1. **Routine Cleanup**
   - Regularly archive completed projects
   - Move implementation artifacts to appropriate directories
   - Keep root directory clear of unnecessary files

2. **README First Principle**
   - Include a README.md in every directory
   - Describe directory purpose and contents
   - List key files and their functions

3. **Living Documentation**
   - Update documentation as part of implementation
   - Document decisions and their rationale
   - Create AAR session documents for significant work

### File Management

1. **Progressive Detail**
   - Put most important information at the top
   - Organize content from general to specific
   - Use clear section headers for easy navigation

2. **Self-Contained References**
   - Include enough context for standalone understanding
   - Reference related documents explicitly
   - Use absolute paths for file references

3. **Maintenance Efficiency**
   - Group related files for easier updates
   - Use templates for consistency
   - Implement regular structure verification

## Workspace Verification

Regular verification of workspace structure ensures continued compliance with Framework 2.0 standards:

```bash
# Workspace structure verification command
tf2-workspace-analyzer.sh [agent-id] [workspace-path]
```

This verification checks:
- Protocol files presence and formatting
- Directory structure compliance
- File naming convention adherence
- Root directory file count

## Conclusion

Consistent workspace organization is essential for context resilience and operational efficiency. By following the standardized structure and conventions in this document, developers can create more maintainable, recoverable agent systems that operate effectively within the Trinity Framework 2.0 Core.

---

*Framework 2.0 COMPLIANT*