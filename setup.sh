#!/bin/bash
# setup.sh — Symlink shared hooks/rules into Claude Code config
# Safe: creates symlinks only. Never deletes existing files.
#
# Usage: bash setup.sh [project_root]
#   project_root: your main working directory (default: current dir)

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
PROJECT_ROOT="${1:-.}"

echo "=== Claude Config Setup ==="
echo "  Repo:    $REPO_DIR"
echo "  Target:  $CLAUDE_DIR"
echo ""

# Ensure target dirs exist
mkdir -p "$CLAUDE_DIR/hooks"

# Project-level rules dir (if project root provided)
if [ -d "$PROJECT_ROOT/.claude/rules" ]; then
    RULES_DIR="$PROJECT_ROOT/.claude/rules"
else
    RULES_DIR="$CLAUDE_DIR/rules"
    mkdir -p "$RULES_DIR"
fi

echo "  Rules:   $RULES_DIR"
echo ""

# Symlink hooks
echo "--- Hooks ---"
for hook in "$REPO_DIR"/hooks/*.sh; do
    name=$(basename "$hook")
    target="$CLAUDE_DIR/hooks/$name"
    if [ -L "$target" ]; then
        echo "  ↻ $name (already linked)"
    elif [ -f "$target" ]; then
        echo "  ⚠ $name exists (not a symlink — skipping, review manually)"
    else
        ln -s "$hook" "$target"
        echo "  ✓ $name → linked"
    fi
done

# Symlink rules
echo ""
echo "--- Rules ---"
for rule in "$REPO_DIR"/rules/*.md; do
    name=$(basename "$rule")
    target="$RULES_DIR/$name"
    if [ -L "$target" ]; then
        echo "  ↻ $name (already linked)"
    elif [ -f "$target" ]; then
        echo "  ⚠ $name exists (not a symlink — skipping, review manually)"
    else
        ln -s "$rule" "$target"
        echo "  ✓ $name → linked"
    fi
done

echo ""
echo "Done. Existing files were NOT overwritten."
echo "Review any ⚠ items manually — your local version may be newer."
echo ""
echo "Next: add hook references to ~/.claude/settings.json"
echo "See README.md for the settings.json snippet."
