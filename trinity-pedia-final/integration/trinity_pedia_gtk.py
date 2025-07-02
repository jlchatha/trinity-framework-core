#!/usr/bin/env python3
"""
Trinity-pedia GTK Integration
Drop-in component for Trinity Gateway GTK application
"""

import gi
gi.require_version('Gtk', '3.0')
gi.require_version('WebKit2', '4.0')

from gi.repository import Gtk, Gdk, WebKit2, GLib
import os
import json

class TrinityPediaWindow(Gtk.Window):
    """Floating Trinity-pedia help window for GTK applications"""
    
    def __init__(self, parent=None, help_path=None):
        super().__init__(title="Trinity-pedia")
        
        # Configuration
        self.parent_window = parent
        self.help_path = help_path or os.path.join(
            os.path.dirname(os.path.abspath(__file__)), 
            '..', 
            'index.html'
        )
        
        # Window setup
        self.setup_window()
        
        # Create WebView
        self.setup_webview()
        
        # Apply styling
        self.apply_css()
        
        # Connect signals
        self.connect("delete-event", self.on_close)
        self.connect("key-press-event", self.on_key_press)
        
        # Show window
        self.show_all()
    
    def setup_window(self):
        """Configure window properties"""
        # Window properties
        self.set_default_size(700, 600)
        self.set_decorated(True)  # Use system decorations for now
        self.set_type_hint(Gdk.WindowTypeHint.DIALOG)
        self.set_skip_taskbar_hint(True)
        self.set_keep_above(True)
        
        # Set parent if provided
        if self.parent_window:
            self.set_transient_for(self.parent_window)
            self.set_position(Gtk.WindowPosition.CENTER_ON_PARENT)
        else:
            self.set_position(Gtk.WindowPosition.CENTER)
        
        # Enable transparency if supported
        screen = self.get_screen()
        visual = screen.get_rgba_visual()
        if visual and screen.is_composited():
            self.set_visual(visual)
    
    def setup_webview(self):
        """Create and configure WebKit WebView"""
        # Create WebView
        self.webview = WebKit2.WebView()
        
        # WebView settings
        settings = self.webview.get_settings()
        settings.set_enable_developer_extras(True)  # For debugging
        settings.set_enable_javascript(True)
        settings.set_enable_write_console_messages_to_stdout(True)
        settings.set_allow_file_access_from_file_urls(True)
        settings.set_allow_universal_access_from_file_urls(True)
        
        # Load Trinity-pedia
        if os.path.exists(self.help_path):
            self.webview.load_uri(f"file://{os.path.abspath(self.help_path)}")
        else:
            self.show_error("Trinity-pedia files not found")
        
        # Handle navigation
        self.webview.connect("decide-policy", self.on_navigation_policy)
        
        # Add JavaScript interface for GTK integration
        self.webview.connect("load-changed", self.on_load_changed)
        
        # Add to window
        self.add(self.webview)
    
    def on_load_changed(self, webview, load_event):
        """Inject JavaScript for GTK integration when page loads"""
        if load_event == WebKit2.LoadEvent.FINISHED:
            # Inject close function
            js_code = """
            window.trinityPediaClose = function() {
                window.webkit.messageHandlers.gtk.postMessage('close');
            };
            
            // Override window controls if needed
            document.addEventListener('DOMContentLoaded', function() {
                const closeBtn = document.getElementById('closeBtn');
                if (closeBtn) {
                    closeBtn.onclick = function() {
                        window.trinityPediaClose();
                    };
                }
            });
            """
            webview.run_javascript(js_code, None, None)
    
    def on_navigation_policy(self, webview, decision, decision_type):
        """Handle navigation decisions"""
        if decision_type == WebKit2.PolicyDecisionType.NAVIGATION_ACTION:
            navigation_action = decision.get_navigation_action()
            request = navigation_action.get_request()
            uri = request.get_uri()
            
            # Allow file:// and about: URIs
            if uri.startswith('file://') or uri.startswith('about:'):
                decision.use()
            else:
                # Open external links in system browser
                Gtk.show_uri_on_window(self, uri, Gdk.CURRENT_TIME)
                decision.ignore()
                return True
        
        return False
    
    def on_key_press(self, widget, event):
        """Handle keyboard shortcuts"""
        # Escape closes window
        if event.keyval == Gdk.KEY_Escape:
            self.close()
            return True
        
        # F1 goes home
        if event.keyval == Gdk.KEY_F1:
            self.webview.run_javascript("navigation.navigateTo('home')", None, None)
            return True
        
        return False
    
    def on_close(self, widget, event):
        """Handle window close"""
        self.hide()
        return True  # Prevent destruction, just hide
    
    def apply_css(self):
        """Apply GTK CSS for window styling"""
        css_provider = Gtk.CssProvider()
        css_provider.load_from_data(b"""
            /* Trinity-pedia GTK Styles */
            window {
                background-color: rgba(3, 7, 18, 0.95);
            }
        """)
        
        Gtk.StyleContext.add_provider_for_screen(
            Gdk.Screen.get_default(),
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )
    
    def show_error(self, message):
        """Show error message in WebView"""
        html = f"""
        <html>
        <head>
            <style>
                body {{
                    background: #030712;
                    color: #e2e8f0;
                    font-family: system-ui, sans-serif;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    height: 100vh;
                    margin: 0;
                }}
                .error {{
                    text-align: center;
                    padding: 40px;
                }}
                h1 {{
                    color: #0891b2;
                    margin-bottom: 16px;
                }}
            </style>
        </head>
        <body>
            <div class="error">
                <h1>Error Loading Trinity-pedia</h1>
                <p>{message}</p>
                <p>Please check the installation.</p>
            </div>
        </body>
        </html>
        """
        self.webview.load_html(html, "about:error")
    
    def load_topic(self, topic_id):
        """Load a specific topic"""
        if hasattr(self, 'webview'):
            self.webview.run_javascript(
                f"navigation.navigateTo('{topic_id}')", 
                None, 
                None
            )
            self.present()
    
    def search(self, query):
        """Open search with pre-filled query"""
        if hasattr(self, 'webview'):
            js = f"""
            search.openSearch();
            search.searchInput.value = '{query}';
            search.performSearch('{query}');
            """
            self.webview.run_javascript(js, None, None)
            self.present()


class TrinityPediaButton(Gtk.Button):
    """Help button that opens Trinity-pedia"""
    
    def __init__(self, parent_window=None):
        super().__init__()
        
        # Button setup
        self.set_image(Gtk.Image.new_from_icon_name("help-browser", Gtk.IconSize.BUTTON))
        self.set_tooltip_text("Open Trinity-pedia (F1)")
        self.get_style_context().add_class("trinity-help-button")
        
        # Track parent window
        self.parent_window = parent_window
        self.help_window = None
        
        # Connect click
        self.connect("clicked", self.on_clicked)
    
    def on_clicked(self, button):
        """Open or focus Trinity-pedia window"""
        if not self.help_window:
            self.help_window = TrinityPediaWindow(self.parent_window)
            
            # Keep reference but allow closing
            self.help_window.connect("delete-event", self.on_help_closed)
        else:
            self.help_window.present()
    
    def on_help_closed(self, window, event):
        """Clean up when help window is closed"""
        self.help_window = None
        return False
    
    def show_topic(self, topic_id):
        """Show a specific topic"""
        if not self.help_window:
            self.help_window = TrinityPediaWindow(self.parent_window)
        
        self.help_window.load_topic(topic_id)


# Integration helper for Trinity Gateway
class TrinityPediaIntegration:
    """Helper class for integrating Trinity-pedia into Trinity Gateway"""
    
    @staticmethod
    def add_to_window(window, help_path=None):
        """Add help button to window header bar"""
        header_bar = window.get_titlebar()
        
        if isinstance(header_bar, Gtk.HeaderBar):
            # Create help button
            help_button = TrinityPediaButton(window)
            
            # Add to header bar
            header_bar.pack_end(help_button)
            
            # Store reference
            window.trinity_help_button = help_button
            
            return help_button
        else:
            print("Warning: Window doesn't use HeaderBar, cannot add help button")
            return None
    
    @staticmethod
    def add_help_menu_item(app_menu):
        """Add Trinity-pedia to application menu"""
        help_item = Gtk.MenuItem(label="Trinity-pedia")
        help_item.connect("activate", lambda x: TrinityPediaWindow().show())
        app_menu.append(help_item)
        return help_item
    
    @staticmethod
    def setup_accelerators(window, accel_group):
        """Setup keyboard accelerators for help"""
        # F1 for help
        key, mod = Gtk.accelerator_parse("F1")
        accel_group.connect(key, mod, 0, lambda: window.trinity_help_button.clicked())
        
        # Ctrl+H for help  
        key, mod = Gtk.accelerator_parse("<Control>h")
        accel_group.connect(key, mod, 0, lambda: window.trinity_help_button.clicked())


# Example usage
if __name__ == "__main__":
    # Test window
    class TestWindow(Gtk.Window):
        def __init__(self):
            super().__init__(title="Trinity Gateway")
            self.set_default_size(800, 600)
            
            # Use HeaderBar
            header = Gtk.HeaderBar()
            header.set_show_close_button(True)
            header.props.title = "Trinity Gateway"
            self.set_titlebar(header)
            
            # Add help button
            TrinityPediaIntegration.add_to_window(self)
            
            # Main content
            label = Gtk.Label(label="Trinity Gateway Main Window\n\nPress F1 or click help button for Trinity-pedia")
            label.set_line_wrap(True)
            self.add(label)
            
            # Setup accelerators
            accel_group = Gtk.AccelGroup()
            self.add_accel_group(accel_group)
            TrinityPediaIntegration.setup_accelerators(self, accel_group)
            
            self.connect("destroy", Gtk.main_quit)
            self.show_all()
    
    # Run test
    win = TestWindow()
    Gtk.main()