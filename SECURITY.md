# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

We take the security of Trinity Framework 2.0 Core seriously. If you believe you've found a security vulnerability, please follow these steps:

1. **Do Not Disclose Publicly**: Please do not disclose the vulnerability publicly until it has been addressed.

2. **Create a Security Report**: Send a detailed description of the vulnerability to the project maintainers.

3. **Include Details**: Please include:
   - A clear description of the vulnerability
   - Steps to reproduce the issue
   - Potential impact
   - Any potential mitigations you've identified

4. **Response Timeline**: You should expect an initial response within 48 hours acknowledging receipt of your report. We will provide updates as the vulnerability is investigated and addressed.

5. **Resolution Process**: Once validated, we will:
   - Develop and test a fix
   - Release a patched version
   - Acknowledge your contribution (unless you prefer to remain anonymous)

## Security Best Practices for Framework Users

When using Trinity Framework 2.0 Core:

1. **Keep Updated**: Always use the latest version of the framework, which includes security patches.

2. **Secure Checkpoints**: Be mindful of what is stored in context checkpoints, as these contain serialized state.

3. **Workspace Permissions**: Set appropriate filesystem permissions on workspace directories.

4. **Protocol File Content**: Avoid storing sensitive information in protocol files.

5. **Customization Security**: When customizing the framework, maintain the security aspects of the original design.

## Security Considerations for Framework Extensions

If you're extending the framework:

1. **Sanitize Inputs**: Validate and sanitize all inputs to custom components.

2. **Secure State Management**: Be careful with how you store and manage state in custom extensions.

3. **Documentation**: Document security considerations for your extensions.

4. **Code Review**: Have security-focused code reviews for all extensions.

Thank you for helping keep Trinity Framework 2.0 Core and its community safe!