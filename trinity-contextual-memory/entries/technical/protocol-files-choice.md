## Protocol Files vs Database

**Q: "Why use markdown files instead of a database for agent state?"**

**A:** During April 2025 auto-compact recovery tests, file-based state survived process crashes while database connections failed. Files are human-readable for debugging, git provides natural versioning, and there's no dependency on running services for recovery.

**Evidence:**
- Test date: April 2025 (auto-compact recovery trials)
- File survival rate: 100% after process crashes
- Database connection survival: 0% (lost on restart)
- Recovery success rate with files: 100%
- Additional benefits: Git versioning, human readability, zero dependencies

**Key Insight:** Simple files beat complex databases when reliability matters most.

---