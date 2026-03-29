# Context Economy — Minimum Viable Lookup

Before any information lookup, follow this escalation ladder. Never skip to a heavier step when a lighter one works.

## Escalation Ladder

1. **Grep** — you know a keyword → `Grep pattern path`
2. **Read with offset/limit** — you know the file + approximate location → `Read file offset limit`
3. **Read full file** — file is <100 lines, or you genuinely need all content
4. **Agent (Explore)** — you don't know which files contain the answer

## Decision Rule

Ask before every lookup:
- "Do I know which file?" → start at step 2
- "Do I know a keyword?" → start at step 1
- Neither → step 4, but tell the agent to return **file paths + line numbers only**, not full content

## Agent Output Control

When launching Explore/research agents, always include in the prompt:
- "Return file paths and relevant line numbers. Do not return full file contents."
- "Keep response under 500 words."

## Avoid
- Reading entire large files when you only need a few lines
- Spawning Agent for searches that Glob + Grep can handle
- Reading files you've already read in this conversation
- Using Bash for cat/head/tail/grep when Read/Grep tools exist
