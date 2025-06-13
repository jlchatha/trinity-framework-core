# Workspace Organization

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Active  
**FRAMEWORK**: Trinity Framework 2.0

---

## Overview

This document outlines the standardized workspace organization for Trinity Framework 2.0. Following these guidelines ensures consistency, improves navigation, and enhances context resilience.

## Root Directory

The workspace root directory contains these essential files:

```
/
├── AGENT.md                 # Agent identity and role
├── AUTO-COMPACT.md          # Context management and recovery
├── STATUS.md                # Current operational status
└── WORKSPACE-ORGANIZATION.md  # This file
```

## Standard Directories

### AAR - After Action Review

```
/AAR/
├── sessions/                # Regular session documentation
│   └── YYYY-MM-DD-description.md
└── incidents/              # Major incident analysis
    └── DESCRIPTIVE-NAME-RCA.md
```

**Purpose**: Documentation for learning and context recovery

### Projects

```
/projects/
└── project-name/           # One directory per project
    ├── README.md           # Project overview
    ├── implementation/     # Implementation files
    ├── docs/               # Project documentation
    └── tests/              # Project tests
```

**Purpose**: Active implementation files for current projects

### Reports

```
/reports/
├── report-name-YYYYMMDD.md  # Generated reports
└── metrics/                # Performance metrics
```

**Purpose**: Generated analysis and reporting documents

### Tools

```
/tools/
├── setup/                  # Setup and configuration
├── token-tracker/          # Context management (optional)
│   └── context-manager/
│       ├── bin/            # Executables
│       ├── state/          # State persistence
│       └── checkpoints/    # Context checkpoints
└── utilities/              # General utilities
```

**Purpose**: Scripts and utilities for workspace operations

### Checkpoints

```
/checkpoints/
└── checkpoint-YYYYMMDD-HHMMSS/  # Timestamped checkpoint directories
```

**Purpose**: Manual checkpoint creation for critical states

### Archives

```
/archives/
└── YYYY-MM-project-name/   # Archived project content
```

**Purpose**: Completed or deprecated content

## Naming Conventions

### Files

- **Protocol Files**: UPPERCASE-WITH-HYPHENS.md
- **Documentation**: lowercase-with-hyphens.md
- **Scripts**: action-description.sh or action-description.js
- **Session AARs**: YYYY-MM-DD-description.md
- **Incident AARs**: DESCRIPTIVE-NAME-RCA.md

### Directories

- **Root Directories**: lowercase-nouns/
- **Project Directories**: descriptive-project-name/
- **Archive Directories**: YYYY-MM-project-name/

## Best Practices

1. **Limit Root Files**: Keep the root directory clean with 10 or fewer files
2. **Consistent Paths**: Use consistent path structures for similar content
3. **Clear Naming**: Use descriptive names that indicate content purpose
4. **Documentation**: Document directory purposes in README.md files
5. **Categorization**: Group related files in meaningful subdirectories

---

*Framework 2.0 COMPLIANT*