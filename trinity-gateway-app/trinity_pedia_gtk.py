#!/usr/bin/env python3
"""
Trinity-pedia GTK Implementation
A floating help window for Trinity Gateway using GTK3 and WebKit2
"""

import gi
gi.require_version('Gtk', '3.0')
gi.require_version('WebKit2', '4.0')

from gi.repository import Gtk, Gdk, WebKit2, GLib
import os

class TrinityPediaWindow(Gtk.Window):
    """Floating help window with glassmorphism effect and Trinity theming"""
    
    def __init__(self, parent=None):
        super().__init__(title="Trinity-pedia")
        
        # Window properties
        self.set_default_size(600, 500)
        self.set_decorated(False)  # Custom window decorations
        self.set_keep_above(True)  # Float above main window
        self.set_position(Gtk.WindowPosition.CENTER)
        
        # Enable transparency
        screen = self.get_screen()
        visual = screen.get_rgba_visual()
        if visual and screen.is_composited():
            self.set_visual(visual)
            self.set_app_paintable(True)
        
        # Main container
        self.main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        self.add(self.main_box)
        
        # Custom title bar
        self.create_title_bar()
        
        # Navigation bar
        self.create_nav_bar()
        
        # WebView for content
        self.webview = WebKit2.WebView()
        self.webview.set_background_color(Gdk.RGBA(0.012, 0.027, 0.071, 0.92))
        
        # Scrolled window for WebView
        scrolled = Gtk.ScrolledWindow()
        scrolled.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        scrolled.add(self.webview)
        self.main_box.pack_start(scrolled, True, True, 0)
        
        # Load initial content
        self.load_home_page()
        
        # Apply CSS styling
        self.apply_styles()
        
        # Connect signals
        self.connect("draw", self.on_draw)
        self.connect("destroy", Gtk.main_quit)
        
        # Enable dragging
        self.enable_window_dragging()
        
        # Show all widgets
        self.show_all()
    
    def create_title_bar(self):
        """Create custom title bar with Trinity theming"""
        title_bar = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        title_bar.get_style_context().add_class("trinity-titlebar")
        title_bar.set_size_request(-1, 40)
        
        # Title with icon
        title_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        icon_label = Gtk.Label(label="📚")
        title_label = Gtk.Label(label="Trinity-pedia")
        title_label.get_style_context().add_class("title")
        title_box.pack_start(icon_label, False, False, 0)
        title_box.pack_start(title_label, False, False, 0)
        
        # Window controls
        controls_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        
        search_btn = Gtk.Button(label="🔍")
        search_btn.get_style_context().add_class("window-control")
        search_btn.set_relief(Gtk.ReliefStyle.NONE)
        
        pin_btn = Gtk.Button(label="📌")
        pin_btn.get_style_context().add_class("window-control")
        pin_btn.set_relief(Gtk.ReliefStyle.NONE)
        pin_btn.connect("clicked", self.toggle_pin)
        
        close_btn = Gtk.Button(label="✕")
        close_btn.get_style_context().add_class("window-control")
        close_btn.set_relief(Gtk.ReliefStyle.NONE)
        close_btn.connect("clicked", lambda w: self.destroy())
        
        controls_box.pack_start(search_btn, False, False, 0)
        controls_box.pack_start(pin_btn, False, False, 0)
        controls_box.pack_start(close_btn, False, False, 0)
        
        # Pack title bar
        title_bar.pack_start(title_box, False, False, 12)
        title_bar.pack_end(controls_box, False, False, 12)
        
        self.main_box.pack_start(title_bar, False, False, 0)
        self.title_bar = title_bar
    
    def create_nav_bar(self):
        """Create navigation bar with breadcrumbs and search"""
        nav_bar = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        nav_bar.get_style_context().add_class("trinity-navbar")
        nav_bar.set_size_request(-1, 44)
        
        # Navigation buttons
        nav_buttons = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=4)
        
        home_btn = self.create_nav_button("🏠", "Home")
        back_btn = self.create_nav_button("←", "Back")
        forward_btn = self.create_nav_button("→", "Forward")
        
        nav_buttons.pack_start(home_btn, False, False, 0)
        nav_buttons.pack_start(back_btn, False, False, 0)
        nav_buttons.pack_start(forward_btn, False, False, 0)
        
        # Breadcrumb
        self.breadcrumb = Gtk.Label(label="Home / Getting Started")
        self.breadcrumb.get_style_context().add_class("breadcrumb")
        self.breadcrumb.set_halign(Gtk.Align.START)
        
        # Search box
        search_box = Gtk.Entry()
        search_box.set_placeholder_text("Quick search...")
        search_box.get_style_context().add_class("search-entry")
        search_box.set_size_request(200, -1)
        
        # Pack nav bar
        nav_bar.pack_start(nav_buttons, False, False, 12)
        nav_bar.pack_start(self.breadcrumb, True, True, 0)
        nav_bar.pack_end(search_box, False, False, 12)
        
        self.main_box.pack_start(nav_bar, False, False, 0)
    
    def create_nav_button(self, label, tooltip):
        """Create a navigation button"""
        btn = Gtk.Button(label=label)
        btn.get_style_context().add_class("nav-button")
        btn.set_relief(Gtk.ReliefStyle.NONE)
        btn.set_tooltip_text(tooltip)
        if label == "🏠":
            btn.connect("clicked", lambda w: self.load_home_page())
        elif label == "←":
            btn.connect("clicked", lambda w: self.webview.go_back())
        elif label == "→":
            btn.connect("clicked", lambda w: self.webview.go_forward())
        return btn
    
    def load_home_page(self):
        """Load the home page content"""
        html_content = """
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <style>
                body {
                    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                    background: transparent;
                    color: #e2e8f0;
                    margin: 0;
                    padding: 24px;
                }
                
                .hero-section {
                    text-align: center;
                    margin-bottom: 32px;
                }
                
                .hero-title {
                    font-size: 24px;
                    font-weight: 700;
                    background: linear-gradient(135deg, #0891b2, #06b6d4);
                    -webkit-background-clip: text;
                    background-clip: text;
                    -webkit-text-fill-color: transparent;
                    margin-bottom: 8px;
                }
                
                .hero-subtitle {
                    font-size: 16px;
                    color: #94a3b8;
                }
                
                .topic-grid {
                    display: grid;
                    grid-template-columns: repeat(2, 1fr);
                    gap: 16px;
                    margin-bottom: 32px;
                }
                
                .topic-card {
                    background: rgba(255, 255, 255, 0.03);
                    border: 1px solid rgba(8, 145, 178, 0.1);
                    border-radius: 8px;
                    padding: 20px;
                    cursor: pointer;
                    transition: all 0.3s ease;
                }
                
                .topic-card:hover {
                    background: rgba(255, 255, 255, 0.05);
                    border-color: rgba(8, 145, 178, 0.3);
                    transform: translateY(-2px);
                }
                
                .topic-icon {
                    font-size: 32px;
                    margin-bottom: 12px;
                    display: block;
                }
                
                .topic-title {
                    font-size: 16px;
                    font-weight: 600;
                    color: #e2e8f0;
                    margin-bottom: 4px;
                }
                
                .topic-description {
                    font-size: 13px;
                    color: #94a3b8;
                    line-height: 1.5;
                }
            </style>
        </head>
        <body>
            <div class="hero-section">
                <h1 class="hero-title">🤖 Claude Code + APEX + You = BOOM! 🚀</h1>
                <p class="hero-subtitle">Welcome to the future of AI-powered development</p>
            </div>
            
            <div class="topic-grid">
                <div class="topic-card" onclick="loadTopic('trinity-system')">
                    <span class="topic-icon">🤖</span>
                    <h3 class="topic-title">The Trinity System</h3>
                    <p class="topic-description">Learn how AI agents collaborate with humans to amplify development</p>
                </div>
                
                <div class="topic-card" onclick="loadTopic('tools')">
                    <span class="topic-icon">🛠️</span>
                    <h3 class="topic-title">Tools & Features</h3>
                    <p class="topic-description">Master the Trinity Gateway interface and integrated development tools</p>
                </div>
                
                <div class="topic-card" onclick="loadTopic('workflows')">
                    <span class="topic-icon">⚡</span>
                    <h3 class="topic-title">Workflows</h3>
                    <p class="topic-description">Discover efficient patterns for AI-assisted development</p>
                </div>
                
                <div class="topic-card" onclick="loadTopic('concepts')">
                    <span class="topic-icon">🏗️</span>
                    <h3 class="topic-title">Trinity Concepts</h3>
                    <p class="topic-description">Understand the philosophy and architecture behind Trinity</p>
                </div>
            </div>
            
            <script>
                function loadTopic(topic) {
                    console.log('Loading topic:', topic);
                    // In real implementation, this would navigate to the topic
                }
            </script>
        </body>
        </html>
        """
        self.webview.load_html(html_content, "file:///")
    
    def apply_styles(self):
        """Apply Trinity-themed CSS styles"""
        css_provider = Gtk.CssProvider()
        css_provider.load_from_data(b"""
            /* Window background with glassmorphism effect */
            window {
                background-color: rgba(3, 7, 18, 0.92);
                border: 1px solid rgba(8, 145, 178, 0.3);
                border-radius: 12px;
            }
            
            /* Title bar styling */
            .trinity-titlebar {
                background-color: rgba(8, 145, 178, 0.1);
                border-bottom: 1px solid rgba(8, 145, 178, 0.2);
                min-height: 40px;
            }
            
            .trinity-titlebar .title {
                color: #0891b2;
                font-weight: 600;
                font-size: 14px;
            }
            
            /* Window control buttons */
            .window-control {
                min-width: 28px;
                min-height: 28px;
                padding: 4px;
                background-color: rgba(255, 255, 255, 0.05);
                color: #64748b;
                border-radius: 6px;
                font-size: 12px;
            }
            
            .window-control:hover {
                background-color: rgba(255, 255, 255, 0.1);
                color: #e2e8f0;
            }
            
            /* Navigation bar */
            .trinity-navbar {
                background-color: rgba(255, 255, 255, 0.02);
                border-bottom: 1px solid rgba(8, 145, 178, 0.1);
                padding: 6px;
            }
            
            /* Navigation buttons */
            .nav-button {
                min-width: 32px;
                min-height: 32px;
                padding: 4px;
                background-color: transparent;
                color: #64748b;
                border-radius: 6px;
                font-size: 14px;
            }
            
            .nav-button:hover {
                background-color: rgba(8, 145, 178, 0.1);
                color: #0891b2;
            }
            
            /* Breadcrumb */
            .breadcrumb {
                color: #94a3b8;
                font-size: 13px;
            }
            
            /* Search entry */
            .search-entry {
                background-color: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(8, 145, 178, 0.2);
                border-radius: 6px;
                padding: 6px 12px;
                color: #e2e8f0;
                font-size: 13px;
            }
            
            .search-entry:focus {
                border-color: #0891b2;
                background-color: rgba(8, 145, 178, 0.1);
            }
        """)
        
        Gtk.StyleContext.add_provider_for_screen(
            Gdk.Screen.get_default(),
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )
    
    def enable_window_dragging(self):
        """Enable window dragging from title bar"""
        self.title_bar.connect("button-press-event", self.on_title_bar_press)
        self.title_bar.connect("button-release-event", self.on_title_bar_release)
        self.title_bar.connect("motion-notify-event", self.on_title_bar_motion)
        
        self.dragging = False
        self.drag_start_x = 0
        self.drag_start_y = 0
    
    def on_title_bar_press(self, widget, event):
        if event.button == 1:  # Left click
            self.dragging = True
            self.drag_start_x = event.x_root
            self.drag_start_y = event.y_root
    
    def on_title_bar_release(self, widget, event):
        self.dragging = False
    
    def on_title_bar_motion(self, widget, event):
        if self.dragging:
            x, y = self.get_position()
            self.move(
                x + int(event.x_root - self.drag_start_x),
                y + int(event.y_root - self.drag_start_y)
            )
            self.drag_start_x = event.x_root
            self.drag_start_y = event.y_root
    
    def toggle_pin(self, button):
        """Toggle window keep-above state"""
        is_pinned = self.get_keep_above()
        self.set_keep_above(not is_pinned)
        button.set_label("📍" if not is_pinned else "📌")
    
    def on_draw(self, widget, cr):
        """Custom draw handler for transparency and effects"""
        # Draw semi-transparent background
        cr.set_source_rgba(0.012, 0.027, 0.071, 0.92)
        cr.set_operator(cairo.OPERATOR_SOURCE)
        cr.paint()
        cr.set_operator(cairo.OPERATOR_OVER)


# Example usage function for integration
def show_trinity_pedia(parent_window=None):
    """Show the Trinity-pedia floating help window"""
    help_window = TrinityPediaWindow(parent_window)
    return help_window


if __name__ == "__main__":
    # Standalone test
    import cairo  # Import here for draw handler
    
    win = show_trinity_pedia()
    Gtk.main()