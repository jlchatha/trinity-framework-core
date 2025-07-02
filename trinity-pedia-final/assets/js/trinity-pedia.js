// Trinity-pedia Main Application

class TrinityPedia {
  constructor() {
    this.isDragging = false;
    this.isResizing = false;
    this.isPinned = false;
    this.currentTheme = 'dark';
    this.fontSize = 'normal';
    
    this.dragOffset = { x: 0, y: 0 };
    this.windowSize = { width: 700, height: 600 };
    
    this.initializeApp();
  }
  
  initializeApp() {
    // Window controls
    this.setupWindowControls();
    
    // Dragging
    this.setupDragging();
    
    // Resizing
    this.setupResizing();
    
    // Theme and font controls
    this.setupThemeControls();
    
    // Quick menu
    this.setupQuickMenu();
    
    // Load saved preferences
    this.loadPreferences();
    
    // Set initial status
    this.updateStatus('Ready');
  }
  
  setupWindowControls() {
    // Close button
    document.getElementById('closeBtn').addEventListener('click', () => {
      this.closeWindow();
    });
    
    // Pin button
    document.getElementById('pinBtn').addEventListener('click', () => {
      this.togglePin();
    });
  }
  
  setupDragging() {
    const titleBar = document.getElementById('titleBar');
    const trinityPedia = document.getElementById('trinityPedia');
    
    titleBar.addEventListener('mousedown', (e) => {
      if (e.target === titleBar || e.target.parentElement === titleBar) {
        this.isDragging = true;
        
        const rect = trinityPedia.getBoundingClientRect();
        this.dragOffset.x = e.clientX - rect.left;
        this.dragOffset.y = e.clientY - rect.top;
        
        document.body.style.cursor = 'move';
        e.preventDefault();
      }
    });
    
    document.addEventListener('mousemove', (e) => {
      if (this.isDragging) {
        const x = e.clientX - this.dragOffset.x;
        const y = e.clientY - this.dragOffset.y;
        
        // Keep window in viewport
        const maxX = window.innerWidth - this.windowSize.width;
        const maxY = window.innerHeight - this.windowSize.height;
        
        const finalX = Math.max(0, Math.min(x, maxX));
        const finalY = Math.max(0, Math.min(y, maxY));
        
        trinityPedia.style.left = finalX + 'px';
        trinityPedia.style.top = finalY + 'px';
        trinityPedia.style.transform = 'none';
      }
    });
    
    document.addEventListener('mouseup', () => {
      if (this.isDragging) {
        this.isDragging = false;
        document.body.style.cursor = '';
        this.savePosition();
      }
    });
  }
  
  setupResizing() {
    const resizeHandle = document.getElementById('resizeHandle');
    const trinityPedia = document.getElementById('trinityPedia');
    
    resizeHandle.addEventListener('mousedown', (e) => {
      this.isResizing = true;
      this.resizeStart = {
        x: e.clientX,
        y: e.clientY,
        width: trinityPedia.offsetWidth,
        height: trinityPedia.offsetHeight
      };
      e.preventDefault();
    });
    
    document.addEventListener('mousemove', (e) => {
      if (this.isResizing) {
        const deltaX = e.clientX - this.resizeStart.x;
        const deltaY = e.clientY - this.resizeStart.y;
        
        const newWidth = Math.max(400, Math.min(1200, this.resizeStart.width + deltaX));
        const newHeight = Math.max(300, Math.min(900, this.resizeStart.height + deltaY));
        
        trinityPedia.style.width = newWidth + 'px';
        trinityPedia.style.height = newHeight + 'px';
        
        this.windowSize.width = newWidth;
        this.windowSize.height = newHeight;
      }
    });
    
    document.addEventListener('mouseup', () => {
      if (this.isResizing) {
        this.isResizing = false;
        this.saveSize();
      }
    });
  }
  
  setupThemeControls() {
    // Theme toggle
    document.getElementById('themeBtn').addEventListener('click', () => {
      this.toggleTheme();
    });
    
    // Font size control
    document.getElementById('fontSizeBtn').addEventListener('click', () => {
      this.cycleFontSize();
    });
  }
  
  setupQuickMenu() {
    const quickMenu = document.getElementById('quickMenu');
    
    // Right-click on title bar for quick menu
    document.getElementById('titleBar').addEventListener('contextmenu', (e) => {
      e.preventDefault();
      this.showQuickMenu(e.clientX, e.clientY);
    });
    
    // Quick menu items
    quickMenu.addEventListener('click', (e) => {
      const action = e.target.dataset.action;
      if (action) {
        this.handleQuickMenuAction(action);
        this.hideQuickMenu();
      }
    });
    
    // Hide menu when clicking elsewhere
    document.addEventListener('click', () => {
      this.hideQuickMenu();
    });
  }
  
  togglePin() {
    this.isPinned = !this.isPinned;
    const pinBtn = document.getElementById('pinBtn');
    
    if (this.isPinned) {
      pinBtn.textContent = '📍';
      pinBtn.title = 'Unpin window';
      document.getElementById('trinityPedia').classList.add('pinned');
    } else {
      pinBtn.textContent = '📌';
      pinBtn.title = 'Pin window';
      document.getElementById('trinityPedia').classList.remove('pinned');
    }
    
    this.updateStatus(this.isPinned ? 'Window pinned' : 'Window unpinned');
  }
  
  toggleTheme() {
    const body = document.body;
    
    if (this.currentTheme === 'dark') {
      body.classList.add('theme-light');
      this.currentTheme = 'light';
    } else {
      body.classList.remove('theme-light');
      this.currentTheme = 'dark';
    }
    
    this.savePreferences();
    this.updateStatus(`Theme: ${this.currentTheme}`);
  }
  
  cycleFontSize() {
    const content = document.getElementById('content');
    const sizes = ['small', 'normal', 'large'];
    const currentIndex = sizes.indexOf(this.fontSize);
    const nextIndex = (currentIndex + 1) % sizes.length;
    
    // Remove current size class
    content.classList.remove(`font-${this.fontSize}`);
    
    // Apply new size
    this.fontSize = sizes[nextIndex];
    content.classList.add(`font-${this.fontSize}`);
    
    // Update button text
    const fontSizeBtn = document.getElementById('fontSizeBtn');
    const sizeLabels = { small: 'Aa-', normal: 'Aa', large: 'Aa+' };
    fontSizeBtn.textContent = sizeLabels[this.fontSize];
    
    this.savePreferences();
    this.updateStatus(`Font size: ${this.fontSize}`);
  }
  
  showQuickMenu(x, y) {
    const menu = document.getElementById('quickMenu');
    menu.style.display = 'block';
    
    // Position menu
    const menuRect = menu.getBoundingClientRect();
    const maxX = window.innerWidth - menuRect.width;
    const maxY = window.innerHeight - menuRect.height;
    
    menu.style.left = Math.min(x, maxX) + 'px';
    menu.style.top = Math.min(y, maxY) + 'px';
  }
  
  hideQuickMenu() {
    document.getElementById('quickMenu').style.display = 'none';
  }
  
  handleQuickMenuAction(action) {
    switch (action) {
      case 'recent':
        navigation.showRecentTopics();
        break;
      case 'bookmarks':
        navigation.showBookmarks();
        break;
      case 'random':
        navigation.navigateToRandom();
        break;
      case 'shortcuts':
        this.showKeyboardShortcuts();
        break;
      case 'about':
        this.showAbout();
        break;
    }
  }
  
  showKeyboardShortcuts() {
    const content = `
      <div class="article-header">
        <span class="article-icon">⌨️</span>
        <div class="article-meta">
          <h1 class="article-title">Keyboard Shortcuts</h1>
          <p class="article-subtitle">Work faster with these handy shortcuts</p>
        </div>
      </div>
      
      <div class="article-content">
        <h3>Navigation</h3>
        <ul>
          <li><code>Ctrl/Cmd + K</code> - Open search</li>
          <li><code>Alt + ←</code> - Go back</li>
          <li><code>Alt + →</code> - Go forward</li>
          <li><code>Alt + H</code> - Go home</li>
          <li><code>Ctrl/Cmd + D</code> - Toggle bookmark</li>
        </ul>
        
        <h3>Window</h3>
        <ul>
          <li><code>Esc</code> - Close search or window</li>
          <li><code>F11</code> - Toggle fullscreen (if supported)</li>
        </ul>
        
        <h3>Display</h3>
        <ul>
          <li><code>Ctrl/Cmd + +</code> - Increase font size</li>
          <li><code>Ctrl/Cmd + -</code> - Decrease font size</li>
          <li><code>Ctrl/Cmd + 0</code> - Reset font size</li>
        </ul>
      </div>
    `;
    
    document.getElementById('content').innerHTML = `<div class="page">${content}</div>`;
  }
  
  showAbout() {
    const content = `
      <div class="article-header">
        <span class="article-icon">ℹ️</span>
        <div class="article-meta">
          <h1 class="article-title">About Trinity-pedia</h1>
          <p class="article-subtitle">Your AI development knowledge companion</p>
        </div>
      </div>
      
      <div class="article-content">
        <p>Trinity-pedia is the comprehensive help system for Trinity Gateway, designed to help you master AI-powered development.</p>
        
        <h3>Features</h3>
        <ul>
          <li>120+ topics covering all aspects of Trinity development</li>
          <li>Interactive, cross-referenced content</li>
          <li>Instant fuzzy search</li>
          <li>Bookmark your favorite topics</li>
          <li>Track your learning progress</li>
          <li>Keyboard navigation</li>
        </ul>
        
        <h3>Built with Trinity</h3>
        <p>This help system was created using the Trinity Framework itself, demonstrating the power of AI-assisted development.</p>
        
        <h3>Version</h3>
        <p>Trinity-pedia v1.0.0<br>
        Trinity Gateway v2.0<br>
        Trinity Framework v2.0</p>
        
        <h3>Credits</h3>
        <p>Created by the Trinity Team with assistance from Claude Code and the Trinity Framework agents.</p>
      </div>
    `;
    
    document.getElementById('content').innerHTML = `<div class="page">${content}</div>`;
  }
  
  updateStatus(message) {
    const statusText = document.getElementById('statusText');
    statusText.textContent = message;
  }
  
  closeWindow() {
    // If integrated with GTK, call the close function
    if (window.trinityPediaClose) {
      window.trinityPediaClose();
    } else {
      // Otherwise, just hide the window
      document.getElementById('trinityPedia').style.display = 'none';
    }
  }
  
  // Preferences Management
  savePreferences() {
    const prefs = {
      theme: this.currentTheme,
      fontSize: this.fontSize,
      isPinned: this.isPinned
    };
    localStorage.setItem('trinity-pedia-prefs', JSON.stringify(prefs));
  }
  
  loadPreferences() {
    const saved = localStorage.getItem('trinity-pedia-prefs');
    if (saved) {
      const prefs = JSON.parse(saved);
      
      // Apply theme
      if (prefs.theme === 'light') {
        document.body.classList.add('theme-light');
        this.currentTheme = 'light';
      }
      
      // Apply font size
      if (prefs.fontSize && prefs.fontSize !== 'normal') {
        this.fontSize = prefs.fontSize;
        document.getElementById('content').classList.add(`font-${this.fontSize}`);
      }
      
      // Apply pin state
      if (prefs.isPinned) {
        this.togglePin();
      }
    }
    
    // Load saved position
    this.loadPosition();
    
    // Load saved size
    this.loadSize();
  }
  
  savePosition() {
    const trinityPedia = document.getElementById('trinityPedia');
    const position = {
      left: trinityPedia.style.left,
      top: trinityPedia.style.top
    };
    localStorage.setItem('trinity-pedia-position', JSON.stringify(position));
  }
  
  loadPosition() {
    const saved = localStorage.getItem('trinity-pedia-position');
    if (saved) {
      const position = JSON.parse(saved);
      const trinityPedia = document.getElementById('trinityPedia');
      
      if (position.left && position.top) {
        trinityPedia.style.left = position.left;
        trinityPedia.style.top = position.top;
        trinityPedia.style.transform = 'none';
      }
    }
  }
  
  saveSize() {
    localStorage.setItem('trinity-pedia-size', JSON.stringify(this.windowSize));
  }
  
  loadSize() {
    const saved = localStorage.getItem('trinity-pedia-size');
    if (saved) {
      const size = JSON.parse(saved);
      const trinityPedia = document.getElementById('trinityPedia');
      
      trinityPedia.style.width = size.width + 'px';
      trinityPedia.style.height = size.height + 'px';
      
      this.windowSize = size;
    }
  }
}

// Initialize app when DOM is ready
let app;
document.addEventListener('DOMContentLoaded', () => {
  app = new TrinityPedia();
});

// Font size CSS classes
const fontSizeStyles = `
  <style>
    .font-small { font-size: 13px; }
    .font-small .article-title { font-size: 28px; }
    .font-small .article-content h2 { font-size: 20px; }
    .font-small .article-content h3 { font-size: 17px; }
    
    .font-large { font-size: 17px; }
    .font-large .article-title { font-size: 36px; }
    .font-large .article-content h2 { font-size: 28px; }
    .font-large .article-content h3 { font-size: 24px; }
    .font-large .code-block code { font-size: 16px; }
  </style>
`;

// Add font size styles to document
document.head.insertAdjacentHTML('beforeend', fontSizeStyles);