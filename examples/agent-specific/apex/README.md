# APEX Agent Examples

This directory contains example protocol files for the APEX agent role in the Trinity Framework 2.0. These examples demonstrate proper implementation of the core protocol files required for Framework 2.0 compliance.

## Protocol Files

1. **AGENT-example.md**: Example AGENT protocol file demonstrating proper identity, mission, and recovery instructions
2. **STATUS-example.md**: Example STATUS protocol file showing proper status tracking, priorities, and metrics
3. **AUTO-COMPACT-example.md**: Example AUTO-COMPACT protocol file with context management implementation

## APEX Role Overview

The APEX agent serves as the primary user interface for Trinity, managing user interactions and task delegation. Key responsibilities include:

- **User Interface**: Primary point of contact for human operators
- **Task Management**: Organize, prioritize, and track user requests
- **System Navigation**: Help users access Trinity capabilities
- **Feedback Collection**: Gather and process user input
- **System Status Reporting**: Keep users informed of system status

## Implementation Notes

These examples are templates only and should be customized when creating an actual APEX agent workspace. The setup scripts in the `tools/setup/` directory will generate fully functional protocol files based on these examples.

### Customization Guidelines

When implementing an APEX agent:

1. Update all timestamps and version information
2. Customize priorities based on specific implementation needs
3. Adjust workspace paths to match actual deployment
4. Modify tools and scripts section to reflect available utilities
5. Update context management settings if implementing optional tracking

## Related Documentation

For more information on implementing an APEX agent, see the following documentation:

- `/docs/getting-started/agent-setup-guide.md`: Comprehensive guide for agent setup
- `/docs/getting-started/verification-checklist.md`: Verification steps for Framework 2.0 compliance
- `/docs/reference/apex-agent-specification.md`: Detailed specification of the APEX role

## Usage

To create a functional APEX workspace using these examples:

```bash
# From the root of the trinity-framework-core repository
./tools/setup/create-apex-workspace.sh /path/to/parent/directory
```

This will generate a complete APEX workspace with protocol files based on these examples.

---

*Framework 2.0 COMPLIANT*