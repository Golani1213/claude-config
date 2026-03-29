#!/bin/bash
# Guard: warn before Claude accesses sensitive directories
# Runs as PreToolUse hook on Read, Grep, Edit, Write
# These tools send file contents to Anthropic's API

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')

# Extract the file path depending on tool type
case "$TOOL" in
  Read|Write|Edit)
    TARGET=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
    ;;
  Grep)
    TARGET=$(echo "$INPUT" | jq -r '.tool_input.path // empty')
    ;;
  *)
    exit 0
    ;;
esac

# Check if path touches sensitive directories
if echo "$TARGET" | grep -qiE '(Finance/|CFA/|\.env$|credentials|vault\.json|/\.ssh/)'; then
  echo '{"decision":"ask","reason":"SENSITIVE PATH: This file is in a protected directory. Its contents will be sent to Anthropic servers. Approve only if you need Claude to process this specific file."}'
  exit 0
fi

# Allow everything else
exit 0
