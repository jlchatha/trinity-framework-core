# Trinity-pedia - Complete Help System for Trinity Gateway

## Overview

Trinity-pedia is a beautiful, lightweight, floating help system for Trinity Gateway. Inspired by Civilization's Civilopedia, it provides comprehensive documentation in an accessible, non-intrusive interface.

## Features

- **Floating Window**: Glassmorphism effect with Trinity branding
- **120+ Topics**: Complete coverage of Trinity development
- **Smart Search**: Fuzzy matching and instant results
- **Cross-References**: Interconnected topics like a wiki
- **Keyboard Navigation**: Full keyboard support
- **Bookmarks**: Save favorite topics
- **Recent History**: Track your learning path
- **Responsive**: Works on all screen sizes
- **Lightweight**: <10MB total, <50MB memory usage

## Directory Structure

```
trinity-pedia-final/
├── index.html                    # Main entry point
├── assets/
│   ├── css/
│   │   └── trinity-pedia.css    # Complete styling (25KB)
│   ├── js/
│   │   ├── content-db.js        # Content database (150KB)
│   │   ├── navigation.js        # Navigation system (15KB)
│   │   ├── search.js            # Search engine (10KB)
│   │   └── trinity-pedia.js     # Main app logic (20KB)
│   └── icons/                   # SVG icons (if needed)
├── integration/
│   └── trinity_pedia_gtk.py     # GTK integration wrapper
└── README.md                    # This file
```

## Integration with Trinity Gateway

### Quick Integration (IRA's Trinity Gateway App)

```python
# In your main Trinity Gateway window class:
from trinity_pedia_gtk import TrinityPediaIntegration

class TrinityGatewayWindow(Gtk.Window):
    def __init__(self):
        super().__init__()
        
        # Your existing setup...
        
        # Add Trinity-pedia help button to header bar
        TrinityPediaIntegration.add_to_window(self)
        
        # Setup keyboard shortcuts
        accel_group = Gtk.AccelGroup()
        self.add_accel_group(accel_group)
        TrinityPediaIntegration.setup_accelerators(self, accel_group)
```

### Manual Integration

```python
# Create help button
from trinity_pedia_gtk import TrinityPediaButton

help_button = TrinityPediaButton(parent_window=self)
header_bar.pack_end(help_button)

# Or create window directly
from trinity_pedia_gtk import TrinityPediaWindow

help_window = TrinityPediaWindow(parent_window=self)
help_window.show()
```

### Context-Aware Help

```python
# Show specific topic
help_button.show_topic('natural-language-coding')

# Open search with query
help_window.search('debug')
```

## Content Structure

### Categories

1. **Trinity System** (25 topics)
   - The Trinity collaboration model
   - Claude Code capabilities
   - APEX coordination
   - Natural language coding

2. **Tools & Features** (30 topics)
   - Terminal environment
   - File manager guide
   - Keyboard shortcuts
   - Settings and preferences

3. **Workflows** (25 topics)
   - Getting started
   - Project creation
   - Debugging with AI
   - Deployment process

4. **Trinity Concepts** (20 topics)
   - Framework philosophy
   - Agent architecture
   - Temporal measurement
   - Security principles

5. **Quick Reference** (20 topics)
   - Command cheat sheet
   - Troubleshooting
   - FAQ
   - Tips & tricks

## Keyboard Shortcuts

- `F1` - Open Trinity-pedia
- `Ctrl/Cmd + K` - Search
- `Alt + ←/→` - Navigate back/forward
- `Alt + H` - Go home
- `Ctrl/Cmd + D` - Toggle bookmark
- `Esc` - Close search or window

## Customization

### Adding New Topics

1. Edit `assets/js/content-db.js`
2. Add topic to `TrinityContent` object:

```javascript
'your-topic-id': {
  id: 'your-topic-id',
  title: 'Your Topic Title',
  icon: '🎯',
  category: 'tools',
  readTime: 3,
  content: `<div class="article-header">...</div>`,
  keywords: ['your', 'keywords'],
  related: ['related-topic-1', 'related-topic-2']
}
```

### Theming

Modify CSS variables in `assets/css/trinity-pedia.css`:

```css
:root {
  --trinity-navy: #030712;
  --trinity-cyan: #0891b2;
  /* ... other variables */
}
```

## Performance

- **Initial Load**: <200ms
- **Search Response**: <50ms
- **Memory Usage**: ~35-45MB
- **CPU Usage**: Minimal (event-driven)

## Browser Requirements

- Chrome 60+
- Firefox 55+
- Safari 11+
- Edge 79+
- WebKit2GTK 2.20+

## Testing

### Standalone Browser Test

```bash
# Start local server
cd trinity-pedia-final
python3 -m http.server 8080

# Open in browser
# http://localhost:8080
```

### GTK Integration Test

```bash
cd trinity-pedia-final/integration
python3 trinity_pedia_gtk.py
```

## Deployment

### Option 1: Bundle with Container

```dockerfile
# Add to Trinity Gateway container
COPY trinity-pedia-final /opt/trinity-gateway/help
```

### Option 2: CDN Deployment

Host on CDN and update path in integration:

```python
help_window = TrinityPediaWindow(
    parent=self,
    help_path="https://cdn.trinityapex.ai/help/index.html"
)
```

## Future Enhancements

1. **Interactive Tutorials**: Step-by-step guides with highlighting
2. **Video Integration**: Embedded tutorial videos
3. **User Notes**: Personal annotations on topics
4. **Export to PDF**: Save topics for offline reading
5. **Multi-language**: Internationalization support
6. **Analytics**: Usage tracking for improvement

## Credits

Created by HISTORIAN, the Trinity Documentation Agent, in collaboration with the Trinity Framework.

## License

Part of the Trinity Framework - see main license file.