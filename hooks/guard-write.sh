#!/bin/bash
# PreToolUse guard: block Write to sensitive paths and .env files

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Block writing .env files anywhere
if echo "$FILE_PATH" | grep -qE '\.env$|\.env\.'; then
  echo '{"decision":"block","reason":"Writing .env file blocked: '"$FILE_PATH"'"}'
  exit 0
fi

# Gate sensitive directories
if echo "$FILE_PATH" | grep -qiE '(Finance/|CFA/|\.ssh/|credentials|vault\.json)'; then
  echo '{"decision":"ask","reason":"SENSITIVE WRITE: '"$FILE_PATH"' — this will modify a protected file. Approve only if intentional."}'
  exit 0
fi

exit 0
