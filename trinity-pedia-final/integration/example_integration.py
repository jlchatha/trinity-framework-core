#!/usr/bin/env python3
"""
Example integration of Trinity-pedia into Trinity Gateway
This shows IRA exactly how to add the help system to the main app
"""

import gi
gi.require_version('Gtk', '3.0')
gi.require_version('Vte', '2.91')

from gi.repository import Gtk, Gdk, Vte, GLib
import os
import sys

# Add Trinity-pedia to path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from trinity_pedia_gtk import TrinityPediaIntegration, TrinityPediaButton


class TrinityGatewayWindow(Gtk.Window):
    """Example Trinity Gateway main window with integrated help"""
    
    def __init__(self):
        super().__init__(title="Trinity Gateway")
        
        # Window setup
        self.set_default_size(1200, 800)
        self.set_position(Gtk.WindowPosition.CENTER)
        
        # Create header bar
        self.setup_header_bar()
        
        # Create main layout
        self.setup_main_layout()
        
        # Setup keyboard shortcuts
        self.setup_accelerators()
        
        # Connect signals
        self.connect("destroy", Gtk.main_quit)
        
        # Show everything
        self.show_all()
    
    def setup_header_bar(self):
        """Create header bar with integrated help button"""
        header = Gtk.HeaderBar()
        header.set_show_close_button(True)
        header.props.title = "Trinity Gateway"
        header.props.subtitle = "AI Development Environment"
        
        # Left side - menu button
        menu_button = Gtk.Button()
        menu_button.set_image(Gtk.Image.new_from_icon_name("open-menu-symbolic", Gtk.IconSize.BUTTON))
        header.pack_start(menu_button)
        
        # Right side - Trinity-pedia help button (automatically added)
        # This is the key integration point!
        TrinityPediaIntegration.add_to_window(self)
        
        self.set_titlebar(header)
    
    def setup_main_layout(self):
        """Create the main Trinity Gateway layout"""
        # Main container
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        self.add(main_box)
        
        # Instructions panel (collapsible)
        self.setup_instructions_panel(main_box)
        
        # Main content area
        content_paned = Gtk.Paned(orientation=Gtk.Orientation.HORIZONTAL)
        main_box.pack_start(content_paned, True, True, 0)
        
        # Terminal (left side, 60%)
        terminal_frame = self.create_terminal_panel()
        content_paned.pack1(terminal_frame, resize=True, shrink=False)
        
        # File manager (right side, 40%)
        file_frame = self.create_file_panel()
        content_paned.pack2(file_frame, resize=True, shrink=False)
        
        # Set initial position (60/40 split)
        content_paned.set_position(720)  # 60% of 1200
        
        # Status bar
        self.setup_status_bar(main_box)
    
    def setup_instructions_panel(self, parent):
        """Create collapsible instructions panel"""
        # Revealer for smooth show/hide
        self.instructions_revealer = Gtk.Revealer()
        self.instructions_revealer.set_reveal_child(True)
        self.instructions_revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_DOWN)
        
        # Instructions box
        instructions_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        instructions_box.set_margin_top(8)
        instructions_box.set_margin_bottom(8)
        instructions_box.set_margin_start(16)
        instructions_box.set_margin_end(16)
        
        # Instructions text
        instructions = Gtk.Label()
        instructions.set_markup(
            "<b>Trinity Gateway Instructions</b>\n"
            "🚀 Quick Start: Claude Code is running • Use Ctrl+Alt+Shift for files • "
            "Type '@apex' for AI help • Press <b>F1</b> for Trinity-pedia help"
        )
        instructions.set_line_wrap(True)
        instructions.set_xalign(0)
        instructions_box.pack_start(instructions, True, True, 0)
        
        # Hide button
        hide_btn = Gtk.Button(label="▼ Hide")
        hide_btn.connect("clicked", self.toggle_instructions)
        instructions_box.pack_end(hide_btn, False, False, 0)
        
        self.instructions_revealer.add(instructions_box)
        parent.pack_start(self.instructions_revealer, False, False, 0)
    
    def create_terminal_panel(self):
        """Create terminal panel with VTE"""
        frame = Gtk.Frame()
        frame.set_label("Terminal - Claude Code Active")
        
        # Terminal
        self.terminal = Vte.Terminal()
        self.terminal.spawn_async(
            Vte.PtyFlags.DEFAULT,
            os.environ['HOME'],
            ['/bin/bash'],
            [],
            GLib.SpawnFlags.DEFAULT,
            None, None,
            -1,
            None,
            None
        )
        
        # Scrolled window for terminal
        scroll = Gtk.ScrolledWindow()
        scroll.add(self.terminal)
        frame.add(scroll)
        
        return frame
    
    def create_file_panel(self):
        """Create file manager panel"""
        frame = Gtk.Frame()
        frame.set_label("File Manager")
        
        # Placeholder for file manager
        # In real implementation, this would be a proper file tree
        file_list = Gtk.TreeView()
        
        # Create list store
        store = Gtk.ListStore(str, str)
        store.append(["📁", "projects/"])
        store.append(["📁", "workspace/"])
        store.append(["📄", "README.md"])
        store.append(["📄", "config.json"])
        
        file_list.set_model(store)
        
        # Add columns
        renderer = Gtk.CellRendererText()
        column = Gtk.TreeViewColumn("Files", renderer, text=1)
        file_list.append_column(column)
        
        # Add to scrolled window
        scroll = Gtk.ScrolledWindow()
        scroll.add(file_list)
        frame.add(scroll)
        
        return frame
    
    def setup_status_bar(self, parent):
        """Create status bar"""
        status_bar = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        status_bar.set_margin_top(4)
        status_bar.set_margin_bottom(4)
        status_bar.set_margin_start(16)
        status_bar.set_margin_end(16)
        
        # Status items
        self.status_label = Gtk.Label(label="Status: APEX Online")
        status_bar.pack_start(self.status_label, False, False, 0)
        
        status_bar.pack_start(Gtk.Label(label=" | "), False, False, 8)
        
        user_label = Gtk.Label(label="User: demo")
        status_bar.pack_start(user_label, False, False, 0)
        
        status_bar.pack_start(Gtk.Label(label=" | "), False, False, 8)
        
        session_label = Gtk.Label(label="Session: trinity-gateway-001")
        status_bar.pack_start(session_label, False, False, 0)
        
        # Help hint on the right
        help_hint = Gtk.Label()
        help_hint.set_markup("<i>Press F1 for help</i>")
        status_bar.pack_end(help_hint, False, False, 0)
        
        parent.pack_end(status_bar, False, False, 0)
    
    def setup_accelerators(self):
        """Setup keyboard shortcuts including help"""
        accel_group = Gtk.AccelGroup()
        self.add_accel_group(accel_group)
        
        # Trinity-pedia shortcuts (F1, Ctrl+H)
        TrinityPediaIntegration.setup_accelerators(self, accel_group)
        
        # Other shortcuts
        # F12 - Toggle file manager
        key, mod = Gtk.accelerator_parse("F12")
        accel_group.connect(key, mod, 0, self.toggle_file_manager)
        
        # Ctrl+W - Close (with confirmation)
        key, mod = Gtk.accelerator_parse("<Control>w")
        accel_group.connect(key, mod, 0, self.confirm_close)
    
    def toggle_instructions(self, button):
        """Toggle instructions panel visibility"""
        revealed = self.instructions_revealer.get_reveal_child()
        self.instructions_revealer.set_reveal_child(not revealed)
        button.set_label("▲ Show" if revealed else "▼ Hide")
    
    def toggle_file_manager(self, *args):
        """Toggle file manager panel (placeholder)"""
        # In real implementation, would show/hide file panel
        self.status_label.set_text("Status: File manager toggled")
    
    def confirm_close(self, *args):
        """Show close confirmation (placeholder)"""
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.QUESTION,
            buttons=Gtk.ButtonsType.YES_NO,
            text="Close Trinity Gateway?"
        )
        dialog.format_secondary_text("Any unsaved work will be lost.")
        
        response = dialog.run()
        if response == Gtk.ResponseType.YES:
            self.destroy()
        
        dialog.destroy()
    
    # Context-aware help examples
    def show_help_for_current_context(self):
        """Example: Show help based on current tool/context"""
        # Determine current context
        if self.terminal.has_focus():
            # Terminal has focus - show terminal help
            self.trinity_help_button.show_topic('terminal-environment')
        else:
            # Show general help
            self.trinity_help_button.show_topic('interface-guide')
    
    def show_help_for_error(self, error_type):
        """Example: Show specific help for an error"""
        error_topics = {
            'connection': 'troubleshooting-connection',
            'syntax': 'debugging-with-ai',
            'permission': 'file-permissions',
            'not_found': 'file-not-found'
        }
        
        topic = error_topics.get(error_type, 'troubleshooting')
        self.trinity_help_button.show_topic(topic)


def main():
    """Run the example application"""
    # Apply CSS theme
    css_provider = Gtk.CssProvider()
    css_provider.load_from_data(b"""
        /* Trinity Gateway Theme */
        window {
            background-color: #0f172a;
        }
        
        headerbar {
            background-color: #1e293b;
            color: #e2e8f0;
        }
        
        headerbar button {
            color: #e2e8f0;
        }
        
        frame {
            margin: 8px;
        }
        
        frame label {
            color: #0891b2;
            font-weight: bold;
        }
        
        label {
            color: #e2e8f0;
        }
        
        .trinity-help-button {
            color: #0891b2;
        }
        
        .trinity-help-button:hover {
            background-color: rgba(8, 145, 178, 0.1);
        }
    """)
    
    Gtk.StyleContext.add_provider_for_screen(
        Gdk.Screen.get_default(),
        css_provider,
        Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )
    
    # Create and run
    app = TrinityGatewayWindow()
    Gtk.main()


if __name__ == "__main__":
    main()