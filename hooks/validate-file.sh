#!/bin/bash
# PostToolUse: validate file syntax after Edit/Write

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

[ -z "$FILE_PATH" ] && exit 0
[ ! -f "$FILE_PATH" ] && exit 0

case "$FILE_PATH" in
  *.py)
    python3 -m py_compile "$FILE_PATH" 2>&1 && echo "✓ Python syntax OK"
    ;;
  *.sh)
    bash -n "$FILE_PATH" 2>&1 && echo "✓ Shell syntax OK"
    ;;
  *.json)
    python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$FILE_PATH" 2>&1 && echo "✓ JSON valid"
    ;;
  *.html)
    echo "Remember: test in browser before deploying to Cloudflare Pages"
    ;;
esac

# Secret scan: check for common API key patterns in the file
if grep -qE '(sk-[a-zA-Z0-9]{20,}|sk-ant-[a-zA-Z0-9]{20,}|AKIA[A-Z0-9]{16}|ghp_[a-zA-Z0-9]{36}|gho_[a-zA-Z0-9]{36}|re_[a-zA-Z0-9]{20,}|xox[bpsa]-[a-zA-Z0-9-]{20,}|Bearer [a-zA-Z0-9_\-\.]{20,}|API_KEY=[a-zA-Z0-9_\-]{16,}|SECRET_KEY=[a-zA-Z0-9_\-]{16,}|sb-[a-zA-Z0-9]{20,}|eyJ[a-zA-Z0-9_-]{50,}\.[a-zA-Z0-9_-]{50,}|PRIVATE.KEY|client_secret\s*[:=])' "$FILE_PATH" 2>/dev/null; then
  echo "🚨 Possible API key/secret detected in $FILE_PATH"
  echo "Review before committing."
fi
