/**
 * ShadowRun theme animations for Trinity Framework 2.0 Core Documentation
 * Created: June 13, 2025
 * Agent: HISTORIAN
 */

document.addEventListener('DOMContentLoaded', function() {
    // Terminal text animation
    animateTerminals();
    
    // Glow effect for headings
    setupGlowEffects();
    
    // Card hover effects
    setupCardHoverEffects();
});

/**
 * Animates terminal content by revealing lines sequentially
 */
function animateTerminals() {
    const terminalElements = document.querySelectorAll('.terminal-content');
    
    terminalElements.forEach(terminal => {
        const lines = terminal.querySelectorAll('br');
        
        // Hide all lines initially except the first one
        for (let i = 0; i < lines.length; i++) {
            const nextSibling = lines[i].nextSibling;
            if (nextSibling && nextSibling.nodeType === Node.TEXT_NODE) {
                nextSibling.style.display = 'none';
            }
        }
        
        // Show lines one by one
        let currentLine = 0;
        function showNextLine() {
            if (currentLine < lines.length) {
                const nextSibling = lines[currentLine].nextSibling;
                if (nextSibling && nextSibling.nodeType === Node.TEXT_NODE) {
                    nextSibling.style.display = 'inline';
                }
                currentLine++;
                setTimeout(showNextLine, 500);
            }
        }
        
        setTimeout(showNextLine, 1000);
    });
}

/**
 * Sets up glow effects for headings and special elements
 */
function setupGlowEffects() {
    // Apply glow effect to main headings
    const mainHeadings = document.querySelectorAll('h1');
    mainHeadings.forEach(heading => {
        heading.classList.add('glow-text');
    });
    
    // Apply pulse effect to framework badges
    const badges = document.querySelectorAll('.framework-badge, .framework-float-badge');
    badges.forEach(badge => {
        badge.addEventListener('mouseover', function() {
            this.style.boxShadow = 'var(--glow-lg)';
        });
        
        badge.addEventListener('mouseout', function() {
            this.style.boxShadow = 'var(--glow-sm)';
        });
    });
}

/**
 * Sets up hover effects for cards
 */
function setupCardHoverEffects() {
    const cards = document.querySelectorAll('.card, .role-card');
    
    cards.forEach(card => {
        card.addEventListener('mouseover', function() {
            this.style.transform = 'translateY(-5px)';
        });
        
        card.addEventListener('mouseout', function() {
            this.style.transform = 'translateY(0)';
        });
    });
}

/**
 * Handles search functionality
 * @param {Event} e - The key event
 */
function handleSearch(e) {
    if (e.key === 'Enter') {
        const searchTerm = e.target.value.toLowerCase();
        
        // Placeholder for actual search implementation
        alert('Search functionality would search for: ' + searchTerm);
        
        e.preventDefault();
    }
}

// Add event listener to search input if it exists
const searchInput = document.querySelector('.search-input');
if (searchInput) {
    searchInput.addEventListener('keypress', handleSearch);
}