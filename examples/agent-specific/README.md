# Agent-Specific Examples

This directory contains examples of Framework 2.0 protocol files for each of the three core agent roles:

1. **APEX**: Primary user interface agent responsible for human interactions and task management
2. **ANALYST**: System improvement specialist focused on code quality, bug fixes, and feature implementation
3. **HISTORIAN**: Knowledge management specialist responsible for documentation and information preservation

## Purpose

These examples demonstrate proper implementation of the critical protocol files required by Framework 2.0:

- **AGENT.md**: Defines agent identity, mission, and recovery procedures
- **STATUS.md**: Tracks current operational status, priorities, and health metrics
- **AUTO-COMPACT.md**: Manages context information and recovery procedures

## Usage

These examples serve as templates for creating fully functional agent workspaces. They can be used in two ways:

1. **Reference**: Study these examples to understand Framework 2.0 requirements
2. **Templates**: Use the setup scripts in `tools/setup/` directory to generate functional workspaces based on these templates

```bash
# Create individual agent workspaces
./tools/setup/create-apex-workspace.sh /path/to/parent/directory
./tools/setup/create-analyst-workspace.sh /path/to/parent/directory
./tools/setup/create-historian-workspace.sh /path/to/parent/directory

# Or create all three workspaces with one command
./tools/setup/create-all-workspaces.sh /path/to/parent/directory
```

## Framework 2.0 Compliance

All examples in this directory demonstrate 100% compliance with Framework 2.0 standards, including:

1. **Protocol File Structure**: Required sections and formatting
2. **Identity Protocol**: Clear agent identity and response formats
3. **Recovery Procedures**: Standardized steps for context restoration
4. **Optional Context Management**: Configuration for context tracking if installed
5. **AAR System**: Implementation of the After Action Review learning system
6. **Workspace Organization**: Framework-compliant directory structure

## Customization

When implementing these examples in a real environment:

1. Update all placeholders (dates, times, version numbers)
2. Customize priorities based on specific implementation needs
3. Adjust workspace paths to match actual deployment
4. Modify tools and scripts sections to reflect available utilities
5. Update context management settings if implementing optional tracking

## Related Documentation

- `/docs/getting-started/agent-setup-guide.md`: Comprehensive guide for agent setup
- `/docs/getting-started/verification-checklist.md`: Verification steps for Framework 2.0 compliance
- `/docs/guides/auto-compact-recovery.md`: Detailed guide to recovery procedures
- `/docs/guides/context-management.md`: Documentation for optional context tracking

---

*Framework 2.0 COMPLIANT*