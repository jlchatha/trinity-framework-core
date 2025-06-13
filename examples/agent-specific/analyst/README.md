# ANALYST Agent Examples

This directory contains example protocol files for the ANALYST agent role in the Trinity Framework 2.0. These examples demonstrate proper implementation of the core protocol files required for Framework 2.0 compliance.

## Protocol Files

1. **AGENT-example.md**: Example AGENT protocol file demonstrating proper identity, mission, and recovery instructions
2. **STATUS-example.md**: Example STATUS protocol file showing proper status tracking, priorities, and metrics
3. **AUTO-COMPACT-example.md**: Example AUTO-COMPACT protocol file with context management implementation

## ANALYST Role Overview

The ANALYST agent serves as the Trinity System Improvement Specialist, focusing on code quality, bug resolution, and feature implementation. Key responsibilities include:

- **Code Quality**: Improve and maintain high code standards
- **Bug Resolution**: Identify and fix system issues
- **Feature Implementation**: Build new capabilities
- **Performance Optimization**: Enhance system speed and efficiency
- **Technical Documentation**: Document code, APIs, and architecture
- **Testing**: Ensure system reliability and correctness
- **Technical Debt Management**: Reduce complexity and maintenance burden

## Implementation Notes

These examples are templates only and should be customized when creating an actual ANALYST agent workspace. The setup scripts in the `tools/setup/` directory will generate fully functional protocol files based on these examples.

### Customization Guidelines

When implementing an ANALYST agent:

1. Update all timestamps and version information
2. Customize priorities based on specific implementation needs
3. Adjust workspace paths to match actual deployment
4. Modify tools and scripts section to reflect available utilities
5. Update context management settings if implementing optional tracking

## Related Documentation

For more information on implementing an ANALYST agent, see the following documentation:

- `/docs/getting-started/agent-setup-guide.md`: Comprehensive guide for agent setup
- `/docs/getting-started/verification-checklist.md`: Verification steps for Framework 2.0 compliance
- `/docs/reference/analyst-agent-specification.md`: Detailed specification of the ANALYST role

## Usage

To create a functional ANALYST workspace using these examples:

```bash
# From the root of the trinity-framework-core repository
./tools/setup/create-analyst-workspace.sh /path/to/parent/directory
```

This will generate a complete ANALYST workspace with protocol files based on these examples.

---

*Framework 2.0 COMPLIANT*