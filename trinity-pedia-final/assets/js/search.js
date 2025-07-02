// Trinity-pedia Search System

class SearchManager {
  constructor() {
    this.searchOverlay = document.getElementById('searchOverlay');
    this.searchInput = document.getElementById('searchInput');
    this.searchResults = document.getElementById('searchResults');
    this.searchBtn = document.getElementById('searchBtn');
    
    this.initializeSearch();
  }
  
  initializeSearch() {
    // Search button click
    this.searchBtn.addEventListener('click', () => this.toggleSearch());
    
    // Search input handling
    this.searchInput.addEventListener('input', (e) => this.performSearch(e.target.value));
    this.searchInput.addEventListener('keydown', (e) => this.handleSearchKeydown(e));
    
    // Close search when clicking overlay background
    this.searchOverlay.addEventListener('click', (e) => {
      if (e.target === this.searchOverlay) {
        this.closeSearch();
      }
    });
  }
  
  toggleSearch() {
    if (this.searchOverlay.style.display === 'none' || !this.searchOverlay.style.display) {
      this.openSearch();
    } else {
      this.closeSearch();
    }
  }
  
  openSearch() {
    this.searchOverlay.style.display = 'flex';
    this.searchInput.value = '';
    this.searchInput.focus();
    this.searchResults.innerHTML = this.getSearchPlaceholder();
  }
  
  closeSearch() {
    this.searchOverlay.style.display = 'none';
    this.searchInput.value = '';
    this.searchResults.innerHTML = '';
  }
  
  performSearch(query) {
    if (!query || query.length < 2) {
      this.searchResults.innerHTML = this.getSearchPlaceholder();
      return;
    }
    
    const results = this.searchContent(query.toLowerCase());
    this.displayResults(results, query);
  }
  
  searchContent(query) {
    const results = [];
    const searchTerms = query.split(' ').filter(term => term.length > 0);
    
    // Search through all content
    Object.entries(TrinityContent).forEach(([id, topic]) => {
      if (id === 'home') return; // Skip home page
      
      let score = 0;
      const titleLower = topic.title.toLowerCase();
      const hasContent = topic.content ? topic.content.toLowerCase() : '';
      
      // Title matches (highest priority)
      searchTerms.forEach(term => {
        if (titleLower.includes(term)) {
          score += 10;
          if (titleLower.startsWith(term)) {
            score += 5; // Bonus for start of title
          }
        }
      });
      
      // Keyword matches
      if (topic.keywords) {
        searchTerms.forEach(term => {
          topic.keywords.forEach(keyword => {
            if (keyword.includes(term)) {
              score += 5;
            }
          });
        });
      }
      
      // Content matches
      searchTerms.forEach(term => {
        const contentMatches = (hasContent.match(new RegExp(term, 'g')) || []).length;
        score += Math.min(contentMatches * 0.5, 5); // Cap content match score
      });
      
      // Fuzzy matching for typos
      searchTerms.forEach(term => {
        if (this.fuzzyMatch(term, titleLower)) {
          score += 3;
        }
      });
      
      if (score > 0) {
        results.push({
          id,
          topic,
          score,
          preview: this.generatePreview(topic, searchTerms)
        });
      }
    });
    
    // Sort by score (highest first)
    results.sort((a, b) => b.score - a.score);
    
    return results.slice(0, 20); // Limit to top 20 results
  }
  
  fuzzyMatch(term, text) {
    // Simple fuzzy matching - allows 1 character difference
    if (Math.abs(term.length - text.length) > 1) return false;
    
    let differences = 0;
    let i = 0, j = 0;
    
    while (i < term.length && j < text.length) {
      if (term[i] !== text[j]) {
        differences++;
        if (differences > 1) return false;
      }
      i++;
      j++;
    }
    
    return true;
  }
  
  generatePreview(topic, searchTerms) {
    const content = topic.content || '';
    const plainText = content.replace(/<[^>]*>/g, ' ').replace(/\s+/g, ' ').trim();
    
    // Find the first occurrence of any search term
    let firstIndex = plainText.length;
    let matchedTerm = '';
    
    searchTerms.forEach(term => {
      const index = plainText.toLowerCase().indexOf(term);
      if (index !== -1 && index < firstIndex) {
        firstIndex = index;
        matchedTerm = term;
      }
    });
    
    if (firstIndex === plainText.length) {
      // No match found, return beginning of content
      return plainText.substring(0, 150) + '...';
    }
    
    // Extract context around the match
    const start = Math.max(0, firstIndex - 50);
    const end = Math.min(plainText.length, firstIndex + 100);
    let preview = plainText.substring(start, end);
    
    // Add ellipsis if needed
    if (start > 0) preview = '...' + preview;
    if (end < plainText.length) preview = preview + '...';
    
    // Highlight search terms
    searchTerms.forEach(term => {
      const regex = new RegExp(`(${term})`, 'gi');
      preview = preview.replace(regex, '<span class="highlight">$1</span>');
    });
    
    return preview;
  }
  
  displayResults(results, query) {
    if (results.length === 0) {
      this.searchResults.innerHTML = `
        <div style="text-align: center; padding: 40px; color: #64748b;">
          <p style="font-size: 18px; margin-bottom: 8px;">No results found for "${query}"</p>
          <p style="font-size: 14px;">Try different keywords or check the spelling</p>
        </div>
      `;
      return;
    }
    
    const resultsHtml = results.map(result => `
      <div class="search-result" onclick="search.selectResult('${result.id}')">
        <div class="search-result-title">
          ${result.topic.icon} ${this.highlightTerms(result.topic.title, query)}
        </div>
        <div class="search-result-preview">${result.preview}</div>
        <div class="search-result-path">${this.getCategoryPath(result.topic)}</div>
      </div>
    `).join('');
    
    this.searchResults.innerHTML = resultsHtml;
  }
  
  highlightTerms(text, query) {
    let highlighted = text;
    const terms = query.split(' ').filter(term => term.length > 0);
    
    terms.forEach(term => {
      const regex = new RegExp(`(${term})`, 'gi');
      highlighted = highlighted.replace(regex, '<span class="highlight">$1</span>');
    });
    
    return highlighted;
  }
  
  getCategoryPath(topic) {
    const category = topic.category || 'general';
    const categoryTitle = navigation.getCategoryTitle(category);
    return `${categoryTitle} / ${topic.title}`;
  }
  
  selectResult(pageId) {
    this.closeSearch();
    navigation.navigateTo(pageId);
  }
  
  handleSearchKeydown(e) {
    if (e.key === 'Escape') {
      this.closeSearch();
    } else if (e.key === 'Enter') {
      // Select first result
      const firstResult = this.searchResults.querySelector('.search-result');
      if (firstResult) {
        firstResult.click();
      }
    }
  }
  
  getSearchPlaceholder() {
    return `
      <div style="text-align: center; padding: 40px; color: #64748b;">
        <p style="font-size: 16px; margin-bottom: 16px;">Search Trinity-pedia</p>
        <p style="font-size: 14px;">Type to search topics, commands, and guides</p>
        <div style="margin-top: 24px; text-align: left; max-width: 400px; margin-left: auto; margin-right: auto;">
          <p style="font-size: 12px; margin-bottom: 8px;">Try searching for:</p>
          <ul style="font-size: 12px; color: #94a3b8;">
            <li>Natural language coding</li>
            <li>Keyboard shortcuts</li>
            <li>Create REST API</li>
            <li>Debug with AI</li>
            <li>Trinity concepts</li>
          </ul>
        </div>
      </div>
    `;
  }
}

// Initialize search when DOM is ready
let search;
document.addEventListener('DOMContentLoaded', () => {
  search = new SearchManager();
});