# Project rules (Biyard repositories)

The rules a Biyard repository follows when it has no rules file of its own in the shared context
repository. They apply to every service repository split out of `biyard/dataroom`, to the shared
repositories (`rbdk`, `react-components`, `rust-backend-ci`, `frontend-ci`, the templates) and,
as far as they fit, to every other Biyard repository. A repository's own `README.md` adds to them;
where the README is stricter, it wins. Code review enforces every rule below; how each one is
checked is in `COMMON.md`, `BACKEND.md` and `FRONTEND.md`.

## Repositories

- Each repository owns one thing: one service (its tables, its backend, its contract), one
  frontend, or one shared library. The one-line purpose of every repository is in the repository
  map (`services.yaml`); the repository's `README.md` is the authority on what it owns.
- Shared code: domain-free Rust in `biyard/rbdk`; domain types, events, proto and the error enum in
  the owning service's `sdk/` (`<name>-sdk`); React UI used by more than one app in
  `biyard/react-components`; CI in `biyard/rust-backend-ci` / `biyard/frontend-ci`.
- `biyard/dataroom` is the monorepo being split up. No new development goes there.
- Internal stack is Rust and Go. Go is acceptable where Rust compile cost is a burden; keep its
  memory low by managing GC deliberately (`GOMEMLIMIT`, no allocation churn on hot paths).

## Branches

`dev` is the default branch and the base of every PR; a merge into `dev` deploys to the dev
namespace. `main` is the production branch. Repositories whose default branch is `main` (rbdk, the
CI repositories, older products) take PRs against `main`.

## PR scope

A PR is scoped to one **user scenario** (something a user can now do end to end) or one **task**
(a bug fix, refactor or chore with a single goal).

- Inside one repository, a scenario is never split by layer: backend, wiring, UI and tests of that
  repository go in one PR.
- A scenario that needs several repositories gets one PR per repository, each naming the same
  scenario and linking the others. Each one must be safe to merge on its own: the owner's contract
  change (sdk types, proto, events) merges first and stays backward compatible, and consumers
  follow with a bump to the merged ref. For PR deployments, a line `peer: <ENV_NAME>=<release>`
  in a backend PR description points it at a sibling PR's release (`biyard/rust-backend-ci`).
- A contract is changed only in the repository that owns it, never copied or redefined by a
  consumer.
- Anything the scenario does not need (an unrelated refactor, a drive-by fix, a second scenario)
  goes in its own PR. A scenario too large to review is cut into smaller scenarios that each work
  on their own.

The PR description carries this section:

```markdown
## Scenario

- **Scenario / task:** <who does what, or the single goal>
- **Repositories:**
  - `biyard/<this repo>`: <its role in the scenario>
  - `biyard/<other repo>#<n>`: <its role> (one line per sibling PR)
```

Changed lines per top-level path of the current branch:

```bash
git diff --numstat origin/dev...HEAD -- . ':!**/Cargo.lock' ':!**/pnpm-lock.yaml' | awk '{split($3,p,"/"); s[p[1]]+=$1+$2} END {for (k in s) print s[k], k}' | sort -rn
```

## Software design

- **Scope-visible layout**: a file's directory shows its scope on its own. A concept that grows
  past one file gets its own directory holding everything scoped to it (its `mod.rs`, its
  `tests.rs`, submodules only it uses). A helper with one consumer lives inside that consumer
  until a second one needs it.
- **Minimal-change extension points**: a feature that is one concept with several interchangeable
  kinds gets a trait or enum-of-structs with one file per kind and one registration point at its
  first implementation, so a new kind is a new file, not edits to a shared `match` across files.
  The kind's behaviour lives in its trait impl in the owning sdk; a consumer calls it. In the UI, a
  single-choice control whose option changes the downstream flow is the same signal. A fixed,
  closed set of cases stays a plain `match`/`if`.
- **Typed values across boundaries**: events and gRPC messages carry sdk types, never JSON in a
  `String` or `serde_json::Value`.
- **Frontend/backend naming**: a UI file that is the counterpart of a backend type keeps the link
  obvious from its name.

## Comments

- All biyard repositories, services and libraries alike: only doc comments that a documentation
  tool renders (rustdoc, TSDoc/TypeDoc, dartdoc) on declarations, written as purpose, usage
  context and usage examples. No `//`, `/* */` or `#` comments, no comments inside function
  bodies (`///` and `/** */` included), no step-by-step or implementation detail, history or
  TODO. When you edit a file that still has such comments, delete them too.
- Generated files keep their generator's header.

## Rust

- Conversions are `From` / `TryFrom`; no `x_to_y` / `from_x` helpers.
- Reuse rbdk crates and existing macros instead of repeating boilerplate.
- Errors: one `ServiceError` enum per service in its sdk (rules in `BACKEND.md` B1). Never
  construct `tonic::Status`, never hand-write its conversion, never build an error from a string,
  never add a catch-all variant.
- Unit tests in a separate `tests.rs` beside the module (`foo/mod.rs` + `foo/tests.rs`); no
  inline `mod tests { .. }`; move any you find in a file you touch.
- Another service is used only through its `<name>-sdk`. An sdk is contract only, with heavy parts
  behind features.
- Proto packages are versioned (`biyard.<name>.v1`); breaking changes go into a new version. Kafka
  payloads stay backward compatible or become a new event version.
- All rbdk crates are pinned to one ref.

## Data modelling

- Design relationally first: every relationship is a column or link table with a foreign key and
  an explicit `on_delete`; no ids inside JSON or as untyped strings; no event-driven cleanup in
  place of a foreign key.
- Exactly one service migrates each table, in its own `migrations/`. Other services call its gRPC
  API; a `skip_schema` mirror of another service's table is the exception, listed in
  `table-access.allow` with the reason in the PR.
- No stored values derivable by aggregates. Indexes cover every query you add or change.
- Schema changes go expand → switch → contract across releases.
- Changing the shape of stored data is lazy by default: the stored value has an integer version
  under `data_version` in the JSON (missing = 1), the type derives `VersionedJson`, each version
  step is an `impl Migrator<N>` applied when the column is decoded, and the converted value is
  written back after the response (compare-and-set on the value read, no `updated_at` or event).
  Immutable (published, hashed, signed) data is `#[data_version(immutable)]` and converted in
  memory only. The release that raises `current` sets `write_back = false` (read only) and the
  next release removes it. Bulk rewrites are the
  exception: new columns, tables and indexes, filtered or joined columns, row-level data fixes.

## UI

- Shared components come from `@biyard/components` (`biyard/react-components`); a component a
  second app needs moves there. Screens follow the Biyard design rules (`FRONTEND.md` F8–F11):
  flat surfaces, colour for state only, sequential grade scales with labels, container queries
  inside panes, legible next steps, ignorable and reversible system actions, and mobile changes
  that never alter the desktop render.
- Server state goes through `@biyard/bff-client` hooks and query-key factories; errors are shown
  only through `describeError`.

## Generated code

- ts-rs output comes from `make gen-ts`; it is gitignored in service repositories and never
  hand-edited. ts-rs derives sit behind the `ts-bridge` feature.
- `react-components` commits the generated types its consumers need, regenerated only through
  `DATAROOM_REV` and `scripts/gen-types.sh`.

## Documentation

- No specs, plans, design documents or AI context files in a repository.
- `README.md` and `docs/**` explain how to use the repository and the big picture of what it
  offers: no code walkthroughs, changelogs, "previously X, now Y" notes or decision records (those
  belong in the PR description and commits).
- A service README lists what a peer relies on — methods, events (with the sdk payload type),
  owned tables, peers, settings — and a PR that adds or changes one of them updates the row in the
  same PR. A new user-visible capability gets one entry at the document's existing level of
  abstraction.
