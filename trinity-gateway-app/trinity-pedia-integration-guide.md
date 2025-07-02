# Trinity-pedia Integration Guide

## Overview
This guide explains how to integrate the lightweight, floating Trinity-pedia help system into the Trinity Gateway GTK3 application.

## Design Principles
1. **Lightweight**: Minimal resource usage, fast startup
2. **Good Looking**: Glassmorphism effect with Trinity branding
3. **Accessible but not Enveloping**: Floats over the app, doesn't dominate

## Implementation Options

### Option 1: Pure GTK3 with WebKit2 (Recommended)
**File**: `trinity_pedia_gtk.py`

**Pros**:
- Native GTK integration
- Smooth performance
- Full control over window behavior
- Can share GTK theme with main app

**Cons**:
- Requires WebKit2GTK dependency
- Slightly more complex

**Integration**:
```python
# In main Trinity Gateway app
from trinity_pedia_gtk import show_trinity_pedia

# Connect to help button
help_button.connect("clicked", lambda w: show_trinity_pedia(self.window))
```

### Option 2: HTML/CSS/JS in WebView (Simplest)
**File**: `trinity-pedia-poc.html`

**Pros**:
- Single HTML file
- Easy to update content
- Beautiful CSS animations
- No additional dependencies

**Cons**:
- Less native feel
- Requires embedding in GTK WebView

**Integration**:
```python
# Create a floating WebView window
help_window = Gtk.Window()
help_window.set_decorated(False)
help_window.set_keep_above(True)
webview = WebKit2.WebView()
webview.load_uri(f"file://{os.path.abspath('trinity-pedia-poc.html')}")
help_window.add(webview)
```

### Option 3: Hybrid Approach (Best of Both)
Combine GTK window chrome with HTML content:
- GTK for window management, dragging, transparency
- HTML/CSS for content rendering
- Pre-compiled static HTML for speed

## Key Features Implemented

### 1. Floating Behavior
- `set_keep_above(True)` - Always on top
- Custom dragging from title bar
- Pin/unpin functionality
- Smart positioning (remembers last position)

### 2. Visual Design
- **Glassmorphism**: `background: rgba(3, 7, 18, 0.92)`
- **Backdrop blur**: Creates depth effect
- **Trinity colors**: Navy (#030712) + Cyan (#0891b2)
- **Smooth animations**: CSS transitions on hover

### 3. Content Structure
- **Hero Section**: Eye-catching welcome message
- **Topic Cards**: 2x2 grid for main categories
- **Quick Links**: Sidebar for common tasks
- **Breadcrumbs**: Clear navigation path
- **Search**: Quick topic lookup

### 4. Performance Optimizations
- Static HTML (no server required)
- Lazy loading for images
- Minimal JavaScript
- CSS-only animations
- < 50MB memory footprint

## Size Modes

The window supports multiple sizes for different use cases:

```python
# Compact Mode (Quick Reference)
window.set_default_size(400, 300)

# Standard Mode (Normal Reading)
window.set_default_size(600, 500)

# Expanded Mode (Detailed Topics)
window.set_default_size(800, 600)

# Mini Mode (Search Only)
window.set_default_size(300, 200)
```

## Content Management

### Directory Structure
```
trinity-pedia-content/
├── index.html          # Home page
├── topics/
│   ├── trinity-system.html
│   ├── tools.html
│   ├── workflows.html
│   └── concepts.html
├── assets/
│   ├── icons/         # SVG icons
│   └── diagrams/      # Topic diagrams
└── css/
    └── trinity-theme.css
```

### Content Guidelines
1. Keep pages under 100KB
2. Use semantic HTML for accessibility
3. Include alt text for all images
4. Test with screen readers
5. Ensure keyboard navigation works

## Integration with Main App

### 1. Help Button in Title Bar
```python
# In Trinity Gateway main window
help_btn = Gtk.Button()
help_btn.set_image(Gtk.Image.new_from_icon_name("help-browser", Gtk.IconSize.BUTTON))
help_btn.connect("clicked", self.show_help)
```

### 2. Context-Aware Help
```python
def show_help(self, widget, topic=None):
    if not hasattr(self, 'help_window'):
        self.help_window = TrinityPediaWindow(self)
    
    if topic:
        self.help_window.load_topic(topic)
    
    self.help_window.present()
```

### 3. Keyboard Shortcut
```python
# F1 or Ctrl+H for help
accel_group = Gtk.AccelGroup()
accel_group.connect(Gdk.KEY_F1, 0, 0, self.show_help)
```

## Testing Checklist

- [ ] Window floats above main app
- [ ] Dragging works smoothly
- [ ] Transparency/blur effect renders correctly
- [ ] Content loads quickly (< 200ms)
- [ ] Navigation works (back/forward/home)
- [ ] Search functionality works
- [ ] Keyboard navigation functional
- [ ] Screen reader compatible
- [ ] Memory usage stays under 50MB
- [ ] Window remembers position
- [ ] Pin/unpin functionality works
- [ ] Resize handles work correctly

## Future Enhancements

1. **Offline Search Index**: Pre-built search index for instant results
2. **Keyboard Command Palette**: Ctrl+K for quick navigation
3. **Interactive Tutorials**: Step-by-step guides with highlighting
4. **Video Embeds**: Short tutorial videos for complex topics
5. **User Annotations**: Let users add their own notes
6. **Export to PDF**: Save help topics for offline reading

## Summary

The Trinity-pedia floating help system provides a beautiful, lightweight, and accessible way to deliver contextual help without overwhelming the user. By using a combination of GTK3 for window management and HTML/CSS for content, we achieve the best of both worlds: native performance with web flexibility.