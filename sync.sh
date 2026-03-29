#!/bin/bash
# Sync claude-config repo into ~/.claude/
# Usage: ./sync.sh
# Run from anywhere — pulls latest and symlinks hooks + rules

set -e

REPO_DIR="/Users/alex/claude-config"
CLAUDE_DIR="/Users/alex/.claude"

echo "Pulling latest from GitHub..."
cd "$REPO_DIR"
git pull --ff-only

echo "Syncing hooks..."
for hook in "$REPO_DIR"/hooks/*.sh; do
  name=$(basename "$hook")
  target="$CLAUDE_DIR/hooks/$name"
  if [ -L "$target" ]; then
    echo "  ✓ $name (already linked)"
  elif [ -f "$target" ]; then
    echo "  ⚠ $name exists as file — skipping (remove manually to use symlink)"
  else
    ln -s "$hook" "$target"
    echo "  → $name linked"
  fi
done

echo "Syncing rules..."
for rule in "$REPO_DIR"/rules/*.md; do
  name=$(basename "$rule")
  target="$CLAUDE_DIR/rules/$name"
  if [ -L "$target" ]; then
    echo "  ✓ $name (already linked)"
  elif [ -f "$target" ]; then
    echo "  ⚠ $name exists as file — skipping (remove manually to use symlink)"
  else
    ln -s "$rule" "$target"
    echo "  → $name linked"
  fi
done

echo ""
echo "Done. Hooks and rules are synced from claude-config repo."
echo "Open /hooks in Claude Code or restart to reload."
