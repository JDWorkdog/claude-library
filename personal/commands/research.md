# Research Command

Conduct comprehensive research on any topic with intelligent source selection and professional output.

## Usage
```
/research                  # Start interactive research session
/research <topic>          # Quick research on topic
/research --deep <topic>   # Deep multi-source research
```

## Quick vs Deep Research

- **`/research`** (this command): Quick, interactive research (5-30 min)
- **`research` agent**: Deep, multi-source research that benefits from parallel searches and background execution

For deep research, say "deep research on X" or "research X in the background" to use the agent.

## Process

**Ask me (format questions clearly - each on its own numbered line):**

1. What topic should I research? (Be as specific or broad as you'd like)
2. What depth level? (quick = 5-10 min, standard = 15-20 min, deep = 30+ min)
3. What output format? (default: executive summary + detailed report, or specify: bullets only, comparative analysis, Q&A format, etc.)
4. Is this time-sensitive? (current events, recent data, or general/historical topic)
5. Any specific angles or questions you want answered?
6. Any sources to prioritize or exclude?

Then:
- **Determine research approach**: Use web search for current events, recent developments, emerging topics. Use knowledge base for historical, conceptual, or established topics.
- **Gather information**: Search across multiple high-quality sources (academic papers, industry reports, authoritative news, expert blogs, official documentation)
- **Verify and cross-reference**: Check facts across multiple sources, note areas of consensus vs. debate
- **Organize intelligently**: Structure based on topic nature (chronological for trends, thematic for concepts, comparative for alternatives)
- **Create output**:
  - **Executive Summary**: 2-4 paragraphs with key findings, main insights, and actionable takeaways
  - **Detailed Report**: Organized sections with depth appropriate to research level
  - **Sources**: Properly cited with links (for web research) or references (for knowledge-based research)
  - **Key Insights**: Highlight most significant findings or emerging patterns
  - **Considerations**: Note limitations, areas of uncertainty, or topics needing further research
- **Save output**: Store in `research/` with descriptive dated filename
- **Provide summary**: Give a brief overview of what you found and where you saved it

## Research Quality Standards

- Prioritize authoritative, credible sources
- Include diverse perspectives when appropriate
- Distinguish between facts, expert opinions, and speculation
- Note publication dates for time-sensitive information
- Highlight gaps in available information

## Output Format

```markdown
# Research: [Topic]

**Date**: YYYY-MM-DD
**Depth**: Quick / Standard / Deep
**Query**: [Original user query]

## Executive Summary

[2-4 paragraphs with key findings, main insights, and actionable takeaways]

## Key Findings

### [Theme 1]
- Finding with citation
- Finding with citation

### [Theme 2]
- Finding with citation

## Areas of Consensus

[What most sources agree on]

## Debates & Contradictions

[Where sources disagree, with both perspectives]

## Considerations

[Limitations, areas of uncertainty, topics needing further research]

## Sources

1. [Full citation with URL]
2. [Full citation with URL]
```
