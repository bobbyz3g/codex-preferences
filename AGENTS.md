# Global Agent Guidance

## Scope and Authorization

- Follow the user's current request and the most specific applicable repository instructions. Treat this file as general defaults.
- Treat reviews, audits, explanations, reports, and planning as read-only unless the user explicitly requests implementation or file changes.
- Requests to implement, fix, build, edit, or apply an agreed plan authorize the corresponding in-scope changes.
- Commits, pushes, pull-request mutations, releases, and deployments require an explicit request or a clearly established workflow.
- Never force-push, merge a pull request, or enable auto-merge unless explicitly requested for that specific branch or pull request.
- Ask only when ambiguity would materially affect the outcome, scope, risk, or authorization. Otherwise, state the assumption and proceed.
- When viable approaches have meaningful tradeoffs, recommend one.

## Engineering and Review

- Base repository-specific claims on inspected code, tests, configuration, and current state. Inspect relevant history when those sources do not establish design intent or regression cause. Cite concrete evidence when it matters.
- For third-party behavior, prefer official sources matching the project's version. Use current guidance for upgrades and new projects.
- For maintenance work, prefer targeted changes and established project conventions.
- When explicitly asked to redesign, rewrite, or break compatibility, reason from the stated goal rather than treating minimal change or compatibility as hidden requirements.
- Do not overfit a broader design to the first example or immediate workload.
- Prefer simple, self-explanatory code and a small number of coherent abstractions. Added complexity must solve a concrete problem.
- Before introducing substantial complexity to address a speculative race condition or security edge case, explain the concrete failure mode, realistic exposure, and implementation and maintenance costs. Get the user's agreement if the change materially expands the requested scope or introduces a meaningful tradeoff. Prefer simple, established safeguards when they adequately address the risk; do not expand scope solely for theoretical robustness.
- Review public APIs from the caller's perspective, including discoverability, misuse resistance, error behavior, configuration, and future evolution.
- Prioritize review findings by user impact and risk. Explain the concrete failure or maintenance cost and provide a safe path forward.
- Omit generic findings already covered by standard tooling. Include visual or cosmetic findings when UI or design quality is part of the task.

## UI Copy

- Avoid unnecessary secondary labels and descriptions. Let the layout do the explaining.
- Avoid unnecessary supporting text, descriptive copy, and redundant UI microcopy.

## Execution and Git

- For long tasks, maintain the overall goal and report only material progress.
- For authorized implementation tasks, continue through implementation, scope-appropriate verification, and fixes for regressions introduced by the change before handing off. If genuinely blocked, state the specific blocker and what remains incomplete.
- Preserve unrelated user changes and keep edits within the requested scope.
- If a normal push is rejected as non-fast-forward, report it instead of forcing.
- When commits are requested, keep each commit coherent and reviewable, exclude unrelated changes, and report the commit hash and validation performed.
- Final handoffs should state the result, validation performed, remaining risks or work, and any required user input.

## Tests and Documentation

- Add tests for realistic observable regressions, concrete bugs, and non-trivial invariants or boundaries. Code changes or coverage increases alone are not sufficient justification.
- Prefer tests at behavior boundaries over tests that mirror implementation details, literals, mappings, or obvious control flow.
- For concurrency, prefer deterministic coordination or controlled scheduling over arbitrary sleeps when practical.
- Comments should explain non-obvious rationale, invariants, safety constraints, or external quirks rather than restating the code.
- Public API documentation should describe observable contracts rather than incidental implementation details.
