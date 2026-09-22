# Code Review Guide

How a pull request to Dataroom is reviewed. The rules themselves live in the project
rules (`CLAUDE.md`, shared with development); this guide says how to check them and how
to report what you find. Where this guide adds detail to a rule, both apply.

`review-pr.sh` injects the project rules and this guide into the reviewer prompt, and
supplies the PR URL, PR number, base repository and posting instructions.

## Scope and input

- Use `gh pr diff <PR number>` to get the full diff and read the surrounding code in this
  checkout for context.
- Focus on real problems, not style nits or praise.

## Review language

WRITE THE REVIEW IN THE AUTHOR'S LANGUAGE. Run `gh pr view <PR number> --json body,title`
and detect the language the author wrote the PR description in — Korean or English. Write
every inline comment and the summary body in that language. If the description is empty or
too short to tell, fall back to the language of the commit messages, and to English if that
is also inconclusive.

## Excluded files

DO NOT REVIEW GitHub Actions workflow files (`.github/workflows/**`). The diff shows only
the changed hunks of those files, which is not enough to judge whether the surrounding shell
or YAML is correct, and reviewing them has produced false positives. Skip them entirely — no
inline comments, no mention in the summary.

## Load the conventions first

Before reviewing anything:

- Read the project rules injected with this guide, including the context files they refer to
  (`SCS.md`, `MOBILE.md`, `UX.md`), which are injected alongside them.
- Read `docs/architecture.md` and every file under `docs/conventions/`.
- Read the `README.md` of every `services/<name>` or `plugins/<name>` directory the diff
  touches, for the abstracted picture of what that service offers.
- All of these are mandatory. A diff that violates them is a first-class finding, even when
  the code otherwise works. Where the project rules are stricter than `docs/`, the project
  rules win. When you flag a violation of `docs/`, cite the specific file (e.g.
  `docs/conventions/styling.md`) so the author can look it up.

## Checks

### 1. Correctness

Bugs, logic errors, security vulnerabilities, race conditions and performance issues.

### 2. Software design

Are appropriate software patterns applied? Is code duplication minimized? Does the code
reuse existing code in this repository (`packages/*`, existing macros) instead of
reimplementing it?

### 3. Project rules

Check every section of the project rules against the diff. The notes below are how to
review and report each one.

**SCS scope**

- Determine the primary SCS from `gh pr view <PR number> --json files` (per-file additions
  and deletions): the SCS the PR's feature belongs to, normally the one with the most
  changed lines.
- For each secondary SCS over 20 lines, check that the PR description answers both
  questions the rules require. If either is missing, flag it. Whether or not it is
  explained, recommend splitting the secondary change into its own PR that lands first.
- A secondary SCS within 20 lines is mentioned in the summary, not flagged as a defect.
- Within the primary SCS, flag feature code placed outside `<name>/ui` (UI) or
  `<name>/src` (backend) when the diff adds it.
- Report scope findings ONCE, at the top of the summary body, listing each secondary SCS
  or shared path with its changed-line count. No inline comments for them.

**SCS layout** (`SCS.md`)

- Flag new or moved code that breaks the layout inside `src/` or `ui/` — in particular a
  custom React hook defined anywhere but `ui/hooks/` (one per file).
- Check what a change carries: README rows for a new method, event, table, peer or setting,
  and a Playwright step in the persona journey (`playwright/tests/scenarios/*.spec.ts`)
  rather than a new per-feature spec.

**UX flow** (`UX.md`)

- For a PR that adds or changes a user-facing flow, check it against the three perspectives in
  `UX.md`. Flag a next step with no legible cue, an unasked-for action the user cannot ignore,
  and a delegated action without range, review or undo.
- These are design findings, not blocking ones — except an unasked-for action the user cannot
  undo, which blocks.

**Mobile web** (`MOBILE.md`)

- For a PR that adds or changes a mobile layout, apply the `MOBILE.md` "Code review
  checklist". Any change to the desktop render is a blocking finding.

**UI reuse**

For a PR that adds or changes UI code (`.tsx`, `.ts` and `.css` under an SCS's `ui/` or
under `packages/`):

- Shared components: list what `packages/components` exports, then check every new or
  changed component, element and style block in the diff against that list. Flag markup
  the diff builds by hand where a shared component already does the job (buttons, inputs,
  selects, modals and dialogs, dropdowns, tabs, tooltips, tables, badges, icons, loaders,
  empty states and so on). Name the component to use and its import path. Also flag a
  local component that copies or nearly copies a shared one.
- Well-known libraries: flag logic the diff writes itself when a well-known, maintained
  library does the same thing — date and time formatting or arithmetic, debounce and
  throttle, deep clone or compare, form state and validation, data fetching and caching,
  virtualised lists, drag and drop, focus trapping, positioning of popovers, file size or
  number formatting, class name merging, and similar. Check the SCS's and the root
  `package.json` first: a library the repository already depends on is the strongest
  suggestion. Name the library and the function or hook to use. Suggest a new dependency
  only when the hand-written code is non-trivial (more than a few lines, or has edge cases
  it gets wrong or skips); never for a one-line helper.
- Collapse repeated occurrences of the same pattern into one comment that lists the sites.

**No comments in source**

- Flag every comment the diff adds to a source file and ask the author to delete it.
- Whole-file scope: when the diff touches a source file that still carries comments, flag
  those too, even on lines the diff did not change. Files the diff does not touch stay as
  they are.
- The default is plain deletion. Suggest moving a comment's content into `README.md` or
  `docs/` ONLY when it describes an important concept or technique a reader must know to
  understand the service, and then only in the form the Documentation rules allow. Never
  suggest moving a comment that explains what the code does.
- Never ask the author to ADD a comment or doc comment.

**Rust**

- Errors: when you flag an inline string error, name the error variants the diff's failure
  cases imply so the author has a concrete starting point.
- Tests: report inline test modules once, listing the affected files, rather than one
  comment per file.

**Data modeling**

- Also judge whether the model fits its storage type and whether relationships between
  tables/collections are appropriate.

**BFF**

- When you flag a new BFF feature route, name the RPC entry point (`core_rpc.rs` or
  `plugin_rpc.rs`) the author should route through instead.
- Do NOT ask the author to add BFF-level DTOs or validation; that duplication is itself a
  finding.
- Do not demand migration of the legacy `search.rs` / `storages.rs` modules in an
  unrelated PR.
- A refactor that moves logic out of the BFF into its owning service is the desired
  direction, not a finding.

**Generated TypeScript**

- `export_to = "types/"` is correct; do not flag it.
- Recognise committed generated files by the ts-rs "do not edit this file manually" header
  or by paths `.gitignore` lists as generated.
- Never ask the author to edit a generated file; the fix is always in the Rust source or
  the build wiring.

**Documentation**

- Flag specs, plans and design documents, and AI context files (`CLAUDE.md`, `GEMINI.md`,
  `AGENTS.md`, anything under `.claude/`, `.gemini/`, `.cursor/` or similar). Report them
  ONCE in the summary body, naming the files to remove.
- In `README.md` and `docs/**`, flag any section the diff adds or modifies that walks
  through code or records history or decisions. Removal is the fix; do not ask for a
  rewrite. If the PR adds a user-visible capability, you may point out where it fits in the
  document's existing abstract structure. Short references to code are fine when they serve
  usage or the big picture (e.g. naming the entry point a user calls).
- Report one inline comment per document, on the first offending section, naming the
  others in the same comment.
- Do NOT demand that a PR add documentation.

**Versions**

- For each plugin bundle whose contents the diff changes (directly, or through shared UI
  code in `packages/` the bundle includes), check that the diff bumps that SCS's
  `package.json` `"version"`.
- Compare against the base branch (`gh pr view <PR number> --json baseRefName`, then read
  the base's `package.json`). The new version must be strictly greater than the base's.
- A missing bump is a blocking finding: it fails the `plugin-bundle` job on `dev` after
  merge. Put it inline on the SCS's `package.json` if that file is in the diff, otherwise in
  the summary body. Name the SCS, the current version and the version to use.
- Do not ask for a bump on backend-only changes or on SCSs without a plugin bundle, and do
  not ask for a matching `Cargo.toml` bump.

## Pruning before posting

A noisy review is worse than a short one. Draft your findings, then drop every comment that
is not worth the author's attention. Remove a comment if ANY of these is true:

- It is a pure style/formatting nit that a linter or formatter already enforces (rustfmt,
  prettier, eslint including the ui-scales rule, etc.).
- It is praise, a restatement of what the code does, or a "consider"/"you could" suggestion
  with no concrete defect behind it.
- It duplicates another comment or the overall summary, or repeats the same issue at
  multiple sites — collapse those into ONE comment that names the pattern.
- It is out of scope: it targets pre-existing code the diff does not touch, or asks for
  work beyond this PR's intent.
  - EXCEPTION: source-comment findings anywhere in a file the diff touches are in scope and
    survive pruning, even on lines the diff did not change.
  - SCS scope findings and missing version bumps also always survive pruning.
- It is speculative ("this might break if...") without a concrete, plausible failure path
  in this codebase.
- It restates a rule without an actual violation in the diff.

Keep a comment only when it is anchored to a real defect or a concrete rule violation at a
specific diff line. If after pruning there are no substantive inline comments, say so
plainly in the summary rather than manufacturing filler.

## Review content

- Each finding that maps to a specific location in the diff is an inline comment anchored
  to that file and line.
- The summary body is the overall assessment of the PR: what it does, whether the approach
  is sound, cross-cutting concerns (design, data modeling, duplication), and a
  severity-ordered summary of the inline findings.
- If there are no significant issues, the summary is a short body saying the changes look
  good, with no inline comments.
