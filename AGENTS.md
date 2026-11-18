# Global Agent Guidance

## Scope and Authorization

- Follow the user's current request and the most specific applicable repository instructions. This file provides general defaults.
- Reviews, audits, explanations, reports, and plans are read-only unless the user requests changes. A request to implement, fix, build, edit, or apply an agreed plan authorizes the corresponding in-scope changes.
- Commits, pushes, pull-request changes, releases, and deployments require an explicit request or a clearly established workflow. Report non-fast-forward push rejections. Force-pushing, merging a pull request, or enabling auto-merge requires explicit authorization for that branch or pull request.
- Ask when ambiguity materially affects the outcome, scope, risk, or authorization. Otherwise, state any necessary assumption and proceed. Recommend one option when viable approaches involve meaningful tradeoffs.

## Engineering and Review

- Ground repository-specific claims in the current code, tests, and configuration. Check relevant history when design intent or the cause of a regression remains unclear. Cite evidence where it matters.
- For third-party behavior, prefer official sources for the version in use. Use current guidance for upgrades and new projects.
- Keep maintenance changes focused and follow project conventions. For an explicit redesign, rewrite, or compatibility break, design for the stated goal and range of use cases. Minimal change and backward compatibility are constraints only if required.
- Prefer simple code and established safeguards. Before adding substantial complexity for a possible race or security edge case, explain how the failure can occur, its realistic impact, and the cost to implement and maintain the fix. Get agreement if the change materially expands scope or introduces a meaningful tradeoff.
- Review public APIs from the caller's perspective, including discoverability, misuse, errors, configuration, and future evolution.
- Rank findings by user impact and risk. Describe the concrete failure or maintenance cost and a safe fix. Omit routine findings covered by standard tools. Include visual issues when UI or design quality is in scope.

## UI Copy

- Keep text that helps users understand, navigate, or act. Remove labels and descriptions that repeat what the layout already conveys.

## Execution and Git

- Keep edits within scope and preserve unrelated user changes. For long tasks, report material progress.
- Carry authorized implementation through verification and fix regressions introduced by the change. At handoff, report the result, checks performed, remaining risks or work, and any input needed. If blocked, identify the specific blocker.
- When commits are requested, keep each one focused and reviewable, exclude unrelated changes, and report its hash and validation.

## Tests and Documentation

- Test observable behavior where a concrete bug, realistic regression, or non-trivial boundary or invariant justifies it. Coverage gains alone do not justify tests that mirror implementation details, literals, mappings, or obvious control flow.
- For concurrency tests, prefer deterministic coordination or controlled scheduling over arbitrary sleeps when practical.
- Use comments for non-obvious rationale, invariants, safety constraints, and external quirks. Document public APIs in terms of behavior callers can rely on.
