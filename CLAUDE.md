# claude-config — rules the OS doesn't already give you

Shared Claude Code configuration for House of Anders. `@README.md` is the contract — what each
hook and rule does, and how `setup.sh` wires them. This file carries only what an agent needs
on top of it.

## ⛔ This repo is shared, and it executes on someone else's machine

Two people run this config. A hook committed here reaches Alex's machine through `sync.sh` and
Vlad's through `setup.sh`, and hooks are **PreToolUse guards** — a broken one does not fail
quietly, it blocks tool use for whoever pulled it.

So the bar for a change here is higher than for a normal repo: **run the hook you are editing
before you commit it**, against both a case it should block and a case it must let through. A
guard that cannot say "no" is decoration; a guard that cannot say "yes" stops the other person
working and they will not know why.

Discuss protocol changes with the other owner rather than landing them unilaterally.

## `setup.sh` and `sync.sh` are not interchangeable

- **`setup.sh <project>`** is the portable one. It symlinks hooks into `~/.claude/hooks/` and
  rules into the project's `.claude/rules/`, and **never overwrites** — it skips an existing
  file and flags it for manual review. That non-destructive property is the invariant; keep it.
- **`sync.sh` is Alex's machine only.** It hardcodes `/Users/alex/claude-config` and
  `/Users/alex/.claude`. It is not a general-purpose sync and will not do anything useful
  elsewhere. Do not "fix" it into a shared script without asking — the two owners wire their
  machines differently on purpose.

## There is no CI

No `.github/` directory, so nothing validates a hook or rule before it reaches a machine. The
person committing is the only gate. That is the reason for the run-it-first rule above, not a
gap to be papered over with a green badge.

## Machine-local customisation is expected

`guard-sensitive-paths.sh` ships common patterns (`Finance/`, `.env`, credentials, `.ssh/`).
Each machine adds its own paths **locally**. Do not commit one person's private directory
layout into the shared file.

## Known drift

`rules/cfa.md` exists in the tree but is absent from the README's rules table, which lists five
of the six. Either document it or retire it — an undocumented rule still loads.
