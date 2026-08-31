---
name: develop-web-game
description: Develop and verify browser games through a tight loop of implement, run, act, pause/observe, screenshot/state inspection, console/error checks, bug fixing and regression testing. Use this Skill for browser-game QA and iterative validation.
---

# Develop Web Game

This is the browser-game verification specialist. The core loop is:

**implement → run → act → pause/observe → inspect → fix → rerun → regress**

## Start

- Identify the project's real start command.
- Start the game with the project's existing toolchain.
- Use a real browser automation tool when available.
- Never claim a browser test ran if the environment prevented it.

## Critical-path test

For each feature, define the shortest meaningful player journey. Example:

new game → move → interact → perform feature → observe state change → save → reload → verify persistence

## Evidence

Collect when available:
- screenshots at key states
- visible UI/state text
- console errors/warnings
- page errors
- network/resource failures
- deterministic game-state output

## Bug loop

When a test fails:
1. reproduce it;
2. identify the smallest root cause;
3. fix it;
4. rerun the failing step;
5. rerun the critical path;
6. run a focused regression suite.

## Browser-specific checks

- relative asset URLs
- refresh/reload behavior
- viewport resize
- mobile touch controls
- audio restrictions
- localStorage/indexedDB persistence
- no uncaught page errors
- no missing resources

## Reporting

Separate actual test evidence from static reasoning. If browser automation is blocked by sandbox/policy, say so and report the last successful evidence instead of fabricating a pass.
