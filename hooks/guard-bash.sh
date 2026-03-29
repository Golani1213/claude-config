#!/bin/bash
# PreToolUse guard: block destructive bash commands

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Block git push --force / git reset --hard / git clean -f
if echo "$COMMAND" | grep -qE 'git\s+(push\s+.*--force|reset\s+--hard|clean\s+-[fd])'; then
  echo "🚨 Destructive git command blocked: $COMMAND"
  echo "Approve manually if intentional."
  exit 2
fi

# Block rm -rf on project directories (allow /tmp/)
if echo "$COMMAND" | grep -qE 'rm\s+-r'; then
  if echo "$COMMAND" | grep -qvE '/tmp/'; then
    TARGET=$(echo "$COMMAND" | grep -oE 'rm\s+-rf?\s+\S+')
    echo "⚠️ Recursive delete detected: $TARGET"
    exit 2
  fi
fi

# Block destructive SQL commands (DELETE, DROP, TRUNCATE)
if echo "$COMMAND" | grep -qiE 'DELETE\s+FROM|DROP\s+(TABLE|DATABASE|INDEX)|TRUNCATE'; then
  echo "🚨 Destructive SQL command detected. Run a SELECT first to confirm affected rows, then request approval."
  exit 2
fi

# Block rsync --delete (defense-in-depth, also blocked at user level)
if echo "$COMMAND" | grep -qE 'rsync.*--delete'; then
  echo "🚨 rsync --delete blocked. Use rsync without --delete, or manage deletions manually."
  exit 1
fi

# Block writing .env files via redirection
if echo "$COMMAND" | grep -qE '>\s*\.env|>\s*\S+\.env'; then
  echo "🚨 Writing to .env file via Bash blocked."
  exit 2
fi
