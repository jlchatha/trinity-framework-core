# Trinity Framework 2.0 Core Documentation

This directory contains the HTML documentation for Trinity Framework 2.0 Core.

## Directory Structure

- `/html/`: Root directory for all HTML documentation
  - `index.html`: Main landing page
  - `quick-start.html`: Quick start guide
  - `/assets/`: CSS, JS, and image assets
    - `/css/`: Stylesheet files
    - `/js/`: JavaScript files
    - `/images/`: Image assets
  - `/reference/`: Reference documentation
    - `agent-roles.html`: Agent roles documentation
  - `/principles/`: Framework principles
    - `context-resilience.html`: Context resilience documentation
  - `/guides/`: How-to guides
    - `context-management.html`: Context management guide
    - `aar-system.html`: AAR system guide
  - `/templates/`: Reusable template files

## GitHub Pages Configuration

This documentation is designed to be hosted on GitHub Pages. The `.nojekyll` file ensures that GitHub Pages will correctly serve the site without processing it as a Jekyll site.

## Local Development

To view the documentation locally, you can use any local HTTP server. For example:

```bash
# Using Python's built-in HTTP server
cd /path/to/html
python3 -m http.server 8000
```

Then visit `http://localhost:8000` in your web browser.

## Maintenance

When adding new HTML files to the documentation:

1. Update the sidebar navigation in `index.html` to include the new file
2. Ensure consistent styling by using the shared CSS in `assets/css/styles.css`
3. Update internal links in existing files if necessary
4. Follow the established template pattern for new files

## License

Trinity Framework 2.0 Core Documentation © 2025 | Licensed under Apache 2.0