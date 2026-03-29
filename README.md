# claude-config

Shared Claude Code configuration for House of Anders infrastructure.

## Quick Setup

```bash
git clone https://github.com/Golani1213/claude-config
cd claude-config
bash setup.sh /path/to/your/project
```

The setup script symlinks hooks and rules into your Claude Code config. It never overwrites existing files — if a file already exists, it skips and flags for manual review.

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
| safety-ops.md | Destructive operation previews, database safety, deploy checks, git safety |
| context-economy.md | Minimum viable lookup — grep before read, read before agent |
| finance.md | Financial precision, Dutch tax context, IB data handling, CFA guidance |
| prompt-reframe.md | Intent decoding — reads intent not syntax, fixes typos silently, nudges on ambiguity |
| bias-and-inclusion.md | Representation audit for writing, coaching, and persona work |

### Setup Script
| File | What |
|---|---|
| setup.sh | Symlinks hooks → `~/.claude/hooks/`, rules → project `.claude/rules/`. Safe: never deletes. |

## settings.json Hook Config

After running `setup.sh`, add these to your `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [{ "type": "command", "command": "bash ~/.claude/hooks/guard-bash.sh" }]
      },
      {
        "matcher": "Read|Write|Edit|Grep",
        "hooks": [{ "type": "command", "command": "bash ~/.claude/hooks/guard-sensitive-paths.sh" }]
      },
      {
        "matcher": "Write",
        "hooks": [{ "type": "command", "command": "bash ~/.claude/hooks/guard-write.sh" }]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [{ "type": "command", "command": "bash ~/.claude/hooks/validate-file.sh" }]
      }
    ]
  }
}
```

## Customization

Each machine should customize `guard-sensitive-paths.sh` for its own sensitive directories. The shared version covers common patterns (Finance/, .env, credentials, .ssh/). Add project-specific paths locally.

## Contributors
- Alex (Golani1213) — finance rules, sensitive path guard, GitHub setup
- Vlad (sterngold) — guard-bash, guard-write, validate-file, safety-ops, context-economy, prompt-reframe, bias-and-inclusion, setup script
