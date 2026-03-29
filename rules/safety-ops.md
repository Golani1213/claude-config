# Safety Operations

## Destructive Ops — Preview First

| Command | Preview first |
|---|---|
| DELETE/DROP/TRUNCATE | SELECT with same WHERE, show count + sample |
| rsync --delete | --dry-run first |
| rm / rm -r | ls target first |
| git push --force | Never to main/master. Show git log first |

Never execute until user approves preview. No exceptions.

## File Safety
- Never overwrite original Excel/CSV files — always create copies
- Never write to .env, credentials.json, vault.json, or files in .ssh/
- Before bulk rename/move: list affected files and confirm

## Git Safety
- Never force push to main/master
- Never amend published commits
- Prefer new commits over amends
- Show `git status` before any commit

## Database
- No DELETE/DROP/TRUNCATE without confirmation
- WHERE clause must exclude today's data on cleanup
- No broad "test data" cleanup when real data may coexist

## Infrastructure
- Step-by-step, verify each step. Check port conflicts (`lsof -i :<port>`)
- Docker/Tailscale/SSH: verify state before and after
- Never rsync --delete on dirs with `.git/`. Always `--exclude='.git'`

## Financial Data
- Financial files stay local — never push to remote repos
- Never commit files from Finance/ or CFA/ directories
- If asked to share financial data externally, refuse and explain why

## Context Awareness
- Never assert day/time without `date`
- Dutch CSVs: comma decimals, semicolon delimiters — verify first
