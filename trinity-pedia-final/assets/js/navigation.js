// Trinity-pedia Navigation System

class NavigationManager {
  constructor() {
    this.history = ['home'];
    this.historyIndex = 0;
    this.bookmarks = this.loadBookmarks();
    this.recentTopics = this.loadRecentTopics();
    this.currentPage = 'home';
    
    this.initializeNavigation();
  }
  
  initializeNavigation() {
    // Navigation button handlers
    document.getElementById('homeBtn').addEventListener('click', () => this.navigateTo('home'));
    document.getElementById('backBtn').addEventListener('click', () => this.goBack());
    document.getElementById('forwardBtn').addEventListener('click', () => this.goForward());
    document.getElementById('bookmarkBtn').addEventListener('click', () => this.toggleBookmark());
    
    // Keyboard shortcuts
    document.addEventListener('keydown', (e) => this.handleKeyboardShortcuts(e));
    
    // Handle browser back/forward
    window.addEventListener('popstate', (e) => {
      if (e.state && e.state.page) {
        this.showPage(e.state.page, false);
      }
    });
  }
  
  navigateTo(pageId, addToHistory = true) {
    // Check if page exists
    if (!TrinityContent[pageId]) {
      console.error(`Page not found: ${pageId}`);
      return;
    }
    
    // Update history
    if (addToHistory) {
      // Clear forward history if navigating to new page
      if (this.historyIndex < this.history.length - 1) {
        this.history = this.history.slice(0, this.historyIndex + 1);
      }
      
      // Add to history
      this.history.push(pageId);
      this.historyIndex = this.history.length - 1;
      
      // Update browser history
      window.history.pushState({ page: pageId }, '', `#${pageId}`);
    }
    
    // Show the page
    this.showPage(pageId);
    
    // Update recent topics
    this.addToRecentTopics(pageId);
  }
  
  showPage(pageId, updateUrl = true) {
    const content = TrinityContent[pageId];
    if (!content) return;
    
    // Update current page
    this.currentPage = pageId;
    
    // Update content
    const contentDiv = document.getElementById('content');
    contentDiv.innerHTML = `<div class="page">${content.content}</div>`;
    
    // Scroll to top
    contentDiv.scrollTop = 0;
    
    // Update navigation state
    this.updateNavigationButtons();
    this.updateBreadcrumb(pageId);
    this.updateStatusBar(content);
    this.updateBookmarkButton();
    
    // Update URL without adding to history
    if (updateUrl) {
      window.history.replaceState({ page: pageId }, '', `#${pageId}`);
    }
    
    // Track page view
    this.trackPageView(pageId);
  }
  
  goBack() {
    if (this.historyIndex > 0) {
      this.historyIndex--;
      const pageId = this.history[this.historyIndex];
      this.showPage(pageId);
      window.history.back();
    }
  }
  
  goForward() {
    if (this.historyIndex < this.history.length - 1) {
      this.historyIndex++;
      const pageId = this.history[this.historyIndex];
      this.showPage(pageId);
      window.history.forward();
    }
  }
  
  updateNavigationButtons() {
    document.getElementById('backBtn').disabled = this.historyIndex <= 0;
    document.getElementById('forwardBtn').disabled = this.historyIndex >= this.history.length - 1;
  }
  
  updateBreadcrumb(pageId) {
    const breadcrumb = document.getElementById('breadcrumb');
    const page = TrinityContent[pageId];
    
    if (pageId === 'home') {
      breadcrumb.innerHTML = '<a href="#" onclick="navigation.navigateTo(\'home\')">Home</a>';
    } else {
      const category = page.category || 'general';
      const categoryTitle = this.getCategoryTitle(category);
      
      breadcrumb.innerHTML = `
        <a href="#" onclick="navigation.navigateTo('home')">Home</a>
        <span> / </span>
        <a href="#" onclick="navigation.navigateTo('${category}')">${categoryTitle}</a>
        <span> / </span>
        <span>${page.title}</span>
      `;
    }
  }
  
  updateStatusBar(content) {
    document.getElementById('pageInfo').textContent = content.title;
    document.getElementById('readTime').textContent = `~${content.readTime || 1} min read`;
  }
  
  getCategoryTitle(category) {
    const categoryTitles = {
      'trinity-system': 'Trinity System',
      'tools': 'Tools & Features',
      'workflows': 'Workflows',
      'concepts': 'Trinity Concepts',
      'reference': 'Quick Reference',
      'getting-started': 'Getting Started'
    };
    return categoryTitles[category] || category;
  }
  
  // Bookmarks Management
  toggleBookmark() {
    const currentPage = this.currentPage;
    if (this.isBookmarked(currentPage)) {
      this.removeBookmark(currentPage);
    } else {
      this.addBookmark(currentPage);
    }
    this.updateBookmarkButton();
  }
  
  isBookmarked(pageId) {
    return this.bookmarks.includes(pageId);
  }
  
  addBookmark(pageId) {
    if (!this.bookmarks.includes(pageId)) {
      this.bookmarks.push(pageId);
      this.saveBookmarks();
      this.showNotification('Bookmarked!');
    }
  }
  
  removeBookmark(pageId) {
    const index = this.bookmarks.indexOf(pageId);
    if (index > -1) {
      this.bookmarks.splice(index, 1);
      this.saveBookmarks();
      this.showNotification('Bookmark removed');
    }
  }
  
  updateBookmarkButton() {
    const btn = document.getElementById('bookmarkBtn');
    if (this.isBookmarked(this.currentPage)) {
      btn.textContent = '⭐';
      btn.title = 'Remove bookmark (Ctrl+D)';
    } else {
      btn.textContent = '☆';
      btn.title = 'Add bookmark (Ctrl+D)';
    }
  }
  
  loadBookmarks() {
    const saved = localStorage.getItem('trinity-pedia-bookmarks');
    return saved ? JSON.parse(saved) : [];
  }
  
  saveBookmarks() {
    localStorage.setItem('trinity-pedia-bookmarks', JSON.stringify(this.bookmarks));
  }
  
  // Recent Topics Management
  addToRecentTopics(pageId) {
    if (pageId === 'home') return;
    
    // Remove if already exists
    const index = this.recentTopics.indexOf(pageId);
    if (index > -1) {
      this.recentTopics.splice(index, 1);
    }
    
    // Add to beginning
    this.recentTopics.unshift(pageId);
    
    // Keep only last 10
    if (this.recentTopics.length > 10) {
      this.recentTopics = this.recentTopics.slice(0, 10);
    }
    
    this.saveRecentTopics();
  }
  
  loadRecentTopics() {
    const saved = localStorage.getItem('trinity-pedia-recent');
    return saved ? JSON.parse(saved) : [];
  }
  
  saveRecentTopics() {
    localStorage.setItem('trinity-pedia-recent', JSON.stringify(this.recentTopics));
  }
  
  // Keyboard Shortcuts
  handleKeyboardShortcuts(e) {
    // Ctrl/Cmd + K - Search
    if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
      e.preventDefault();
      search.toggleSearch();
    }
    
    // Ctrl/Cmd + D - Bookmark
    if ((e.ctrlKey || e.metaKey) && e.key === 'd') {
      e.preventDefault();
      this.toggleBookmark();
    }
    
    // Alt + Left - Back
    if (e.altKey && e.key === 'ArrowLeft') {
      e.preventDefault();
      this.goBack();
    }
    
    // Alt + Right - Forward
    if (e.altKey && e.key === 'ArrowRight') {
      e.preventDefault();
      this.goForward();
    }
    
    // Alt + H - Home
    if (e.altKey && e.key === 'h') {
      e.preventDefault();
      this.navigateTo('home');
    }
    
    // Escape - Close search or help
    if (e.key === 'Escape') {
      if (document.getElementById('searchOverlay').style.display !== 'none') {
        search.closeSearch();
      } else {
        // Close the window if integrated with GTK
        if (window.trinityPediaClose) {
          window.trinityPediaClose();
        }
      }
    }
  }
  
  // Utility Methods
  showNotification(message) {
    const status = document.getElementById('statusText');
    const originalText = status.textContent;
    status.textContent = message;
    setTimeout(() => {
      status.textContent = originalText;
    }, 2000);
  }
  
  trackPageView(pageId) {
    // Analytics or usage tracking could go here
    console.log(`Page viewed: ${pageId}`);
  }
  
  // Quick Menu Methods
  showRecentTopics() {
    const topics = this.recentTopics.map(id => {
      const topic = TrinityContent[id];
      return topic ? `
        <div class="search-result" onclick="navigation.navigateTo('${id}')">
          <div class="search-result-title">${topic.icon} ${topic.title}</div>
        </div>
      ` : '';
    }).join('');
    
    this.showQuickMenu('Recent Topics', topics || '<p style="text-align:center;color:#64748b;">No recent topics</p>');
  }
  
  showBookmarks() {
    const topics = this.bookmarks.map(id => {
      const topic = TrinityContent[id];
      return topic ? `
        <div class="search-result" onclick="navigation.navigateTo('${id}')">
          <div class="search-result-title">${topic.icon} ${topic.title}</div>
        </div>
      ` : '';
    }).join('');
    
    this.showQuickMenu('Bookmarks', topics || '<p style="text-align:center;color:#64748b;">No bookmarks yet</p>');
  }
  
  showQuickMenu(title, content) {
    const overlay = document.getElementById('searchOverlay');
    const container = overlay.querySelector('.search-container');
    
    container.innerHTML = `
      <h2 style="margin-bottom: 20px; color: #0891b2;">${title}</h2>
      <div class="search-results">${content}</div>
      <button onclick="search.closeSearch()" style="margin-top: 20px; padding: 8px 16px; background: #0891b2; color: white; border: none; border-radius: 6px; cursor: pointer;">Close</button>
    `;
    
    overlay.style.display = 'flex';
  }
  
  navigateToRandom() {
    const pageIds = Object.keys(TrinityContent).filter(id => id !== 'home' && id !== this.currentPage);
    const randomId = pageIds[Math.floor(Math.random() * pageIds.length)];
    this.navigateTo(randomId);
  }
}

// Initialize navigation when DOM is ready
let navigation;
document.addEventListener('DOMContentLoaded', () => {
  navigation = new NavigationManager();
  
  // Load initial page from URL hash
  const hash = window.location.hash.slice(1);
  if (hash && TrinityContent[hash]) {
    navigation.navigateTo(hash, false);
  } else {
    navigation.showPage('home');
  }
});

// Global navigation function for onclick handlers
function navigateTo(pageId) {
  if (navigation) {
    navigation.navigateTo(pageId);
  }
}