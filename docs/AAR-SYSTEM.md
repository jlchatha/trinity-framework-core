# After Action Review (AAR) System

**VERSION**: 1.0.0  
**CREATED**: June 12, 2025  
**STATUS**: Draft  
**FRAMEWORK**: Trinity Framework 2.0  

---

## Introduction

The After Action Review (AAR) System is a structured knowledge preservation mechanism within Trinity Framework 2.0 Core that enables continuous learning and context preservation. This document outlines the purpose, structure, and implementation of the AAR system.

## Purpose

The AAR System serves multiple critical functions:

1. **Context Preservation**: Retains implementation knowledge across context resets
2. **Continuous Learning**: Creates a framework for systematic improvement
3. **Recovery Enhancement**: Provides detailed recovery resources
4. **Knowledge Transfer**: Facilitates sharing insights between implementation sessions
5. **Progress Tracking**: Documents advancement through implementation stages

## System Structure

The AAR System is organized into a two-tier structure:

### 1. Session AARs

**Purpose**: Document regular work sessions and incremental progress
**Location**: `/AAR/sessions/` directory
**Naming**: `YYYY-MM-DD-description.md`
**Size**: 20-50 lines of content
**Creation Frequency**: After completing tasks, resolving issues, or before context resets

### 2. Incident AARs

**Purpose**: Document comprehensive analysis of significant issues
**Location**: `/AAR/incidents/` directory
**Naming**: `YYYY-MM-DD-incident-name-RCA.md` (RCA = Root Cause Analysis)
**Size**: 100+ lines of detailed technical documentation
**Creation Frequency**: After major system issues or implementation challenges

## Document Templates

### Session AAR Template

```markdown
# AAR Session: [Brief Descriptive Title]

**Date**: [YYYY-MM-DD]  
**Session Type**: [Implementation/Testing/Documentation/Analysis/Recovery]  
**Status**: [Complete/Partial/Ongoing]  
**Agent**: [AGENT NAME]

## Session Summary
[1-2 sentence overview of what was accomplished]

## Activities Completed
1. **[Activity Category 1]**
   - [Specific task completed]
   - [Specific task completed]
   - [Outcome or result]

2. **[Activity Category 2]**
   - [Specific task completed]
   - [Specific task completed]
   - [Outcome or result]

## Key Insights
1. [Important realization or finding]
2. [Important realization or finding]
3. [Important realization or finding]

## Challenges Encountered
1. **[Challenge 1]**: [Brief description]
   - [How it was addressed]
2. **[Challenge 2]**: [Brief description]
   - [How it was addressed]

## Next Actions
1. [Specific next task]
2. [Specific next task]
3. [Specific next task]

---
*Framework 2.0 COMPLIANT*
```

### Incident AAR Template

```markdown
# AAR Incident: [Incident Name] - Root Cause Analysis

**Date**: [YYYY-MM-DD]  
**Incident Type**: [System Issue/Implementation Challenge/Performance Problem/etc.]  
**Severity**: [Critical/High/Medium/Low]  
**Status**: [Resolved/Mitigated/Ongoing]  
**Agent**: [AGENT NAME]

## Incident Summary
[Concise description of the incident, its impact, and resolution status]

## Timeline
- **[Timestamp]**: [Initial detection]
- **[Timestamp]**: [Key event in incident progression]
- **[Timestamp]**: [Resolution step]
- **[Timestamp]**: [Verification]

## Impact Assessment
- **Functional Impact**: [Description of system functionality affected]
- **Performance Impact**: [Description of performance degradation]
- **Recovery Impact**: [Description of recovery capability affected]
- **User Experience**: [Description of user-facing impacts]

## Root Cause Analysis
### Primary Cause
[Detailed technical description of the root cause]

### Contributing Factors
1. **[Factor 1]**: [Description]
2. **[Factor 2]**: [Description]
3. **[Factor 3]**: [Description]

### Trigger Event
[What specifically triggered the incident]

## Resolution
### Immediate Action
[Steps taken to immediately address the issue]

### Short-term Fix
[Temporary solution implemented]

### Long-term Solution
[Permanent fix or architectural changes]

## Verification
### Testing Performed
- [Test 1 description and result]
- [Test 2 description and result]
- [Test 3 description and result]

### Metrics
- [Before/after metric 1]
- [Before/after metric 2]

## Lessons Learned
1. **[Area 1]**: [Learning]
2. **[Area 2]**: [Learning]
3. **[Area 3]**: [Learning]

## Prevention Measures
1. **Process Changes**
   - [Specific process change]
   - [Specific process change]

2. **Technical Improvements**
   - [Specific technical improvement]
   - [Specific technical improvement]

3. **Monitoring Enhancements**
   - [Specific monitoring enhancement]
   - [Specific monitoring enhancement]

## References
- [Link to related documentation]
- [Link to code changes]
- [Link to related incidents]

---
*Framework 2.0 COMPLIANT*
```

## Implementation Guidelines

### When to Create Session AARs

Create Session AARs in any of these situations:
- After completing a significant implementation task
- At the end of a productive work session
- Before anticipated context resets
- When discovering important insights
- After resolving non-critical issues
- When establishing a new approach or strategy

### When to Create Incident AARs

Create Incident AARs in any of these situations:
- After resolving a critical system issue
- When recovering from a significant failure
- After identifying and fixing a complex bug
- When resolving an architectural problem
- After performance optimization breakthroughs
- When addressing security vulnerabilities
- After major implementation challenges

### Content Quality Guidelines

#### Effective AAR Content

1. **Specificity**: Include specific file paths, function names, and implementation details
2. **Context**: Provide enough information for someone without prior knowledge
3. **Technical Depth**: Include code examples, error messages, and technical specifics
4. **Actionability**: Focus on concrete actions and decisions
5. **Reflection**: Include insights and lessons learned
6. **Forward-Looking**: End with specific next steps

#### Ineffective AAR Content (Avoid)

1. **Vagueness**: General statements without specifics
2. **Assumption of Knowledge**: References without explanation
3. **Shallow Description**: Surface-level summaries without detail
4. **Process Focus**: Emphasis on process over content
5. **Missing Context**: Details without explanation of importance
6. **No Forward Path**: Ending without clear next steps

## AAR Recovery Protocol

The AAR system plays a critical role in context recovery:

### Initial Recovery

1. After context reset, read protocol files first (AGENT.md, AUTO-COMPACT.md, STATUS.md)
2. Check most recent AAR session document for immediate context
3. Read any incident AARs referenced in recent session documents
4. Build recovery context from AAR content

### Comprehensive Recovery

For more detailed recovery after critical issues:
1. Review protocol files for basic orientation
2. Read most recent 3-5 session AARs for recent activities
3. Check for incident AARs relating to current work
4. Read referenced implementation documents from recent AARs
5. Recreate context by synthesizing all sources

## AAR System Management

### Organization

- Maintain chronological order in AAR directories
- Use clear, descriptive filenames
- Reference related AARs in each document
- Create an AAR index for navigating numerous documents

### Maintenance

- Review AAR directories periodically
- Archive older sessions that are no longer relevant
- Maintain incident AARs for longer reference periods
- Update references when files are moved or renamed

### Integration

- Reference AAR documents in AUTO-COMPACT.md
- Include links to relevant AARs in STATUS.md
- Reference AARs in project documentation
- Use AARs as source material for comprehensive reports

## Benefits

Effective implementation of the AAR System provides:

1. **Resilient Memory**: Critical knowledge preserved across context resets
2. **Efficient Recovery**: Faster restoration of operational context
3. **Continuous Improvement**: Systematic learning from experiences
4. **Knowledge Transfer**: Effective sharing between implementation sessions
5. **Progress Transparency**: Clear documentation of advancement
6. **Failure Prevention**: Learning from past issues to prevent recurrence

## Conclusion

The AAR System is a foundational element of Trinity Framework 2.0 Core that enables context resilience and continuous improvement. By implementing this system according to the guidelines in this document, developers can create more robust agent applications that maintain effectiveness across context limitations.

---

*Framework 2.0 COMPLIANT*