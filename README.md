# claude-config

Shared Claude Code configuration for House of Anders infrastructure.

## What's Here

### Hooks (`hooks/`)
| Script | Event | What |
|---|---|---|
| guard-bash.sh | PreToolUse: Bash | Blocks destructive commands (rm -rf, force push, destructive SQL, rsync --delete) |
| guard-sensitive-paths.sh | PreToolUse: Read/Write/Edit/Grep | Forces approval before accessing sensitive directories |
| guard-write.sh | PreToolUse: Write | Hard-blocks .env writes, gates sensitive directory writes |
| validate-file.sh | PostToolUse: Write/Edit | Validates Python/shell/JSON syntax + scans for leaked secrets |

### Rules (`rules/`)
| Rule | What |
|---|---|
| safety-ops.md | Destructive operation previews, database safety, deploy checks |
| context-economy.md | Minimum viable lookup — grep before read, read before agent |
| finance.md | Financial precision, Dutch tax context, IB data handling, CFA guidance |

## Setup

1. Clone this repo
2. Copy or symlink hooks into `~/.claude/hooks/`
3. Copy or symlink rules into `~/.claude/rules/`
4. Add hook references to your `~/.claude/settings.json`

## Contributors
- Alex (Golani1213) — finance rules, sensitive path guard
- Vlad — guard-bash, guard-write, validate-file, safety-ops, context-economy
