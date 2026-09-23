# CLAUDE.md

Dataroom is a monorepo of self-contained systems (SCS). Each SCS owns its tables, its backend
and, where it has one, its UI, and talks to the others only over gRPC and typed Kafka events.
Code review enforces every rule below; write code that already satisfies them. How a PR is
opened and carried to green is in [PULL_REQUEST.md](PULL_REQUEST.md); how it is reviewed
against these rules is in [CODE_REVIEW.md](CODE_REVIEW.md).

## Before you start

- Read `docs/architecture.md` and every file under `docs/conventions/`. They are mandatory: a
  violation is a review finding even when the code otherwise works.
- Read the `README.md` of each `services/<name>` or `plugins/<name>` you will touch.

## Repository layout

| Path | What it holds |
|---|---|
| `services/<name>` | Core systems: features every workspace gets |
| `plugins/<name>` | Plugin systems: features a space opts into |
| `packages/<name>` | Shared code that belongs to no single SCS |

Inside one SCS, frontend and backend live side by side:

- `<name>/ui`: frontend (React + Vite). UI code goes nowhere else.
- `<name>/src`: backend (Rust). Backend code goes nowhere else.
- The SCS root holds only build and contract files: `proto/`, `public/`, `Makefile`,
  `Cargo.toml`, `package.json`, `meta.ts` or `manifest.json`, vite/vitest configs, `README.md`.

Read [`SCS.md`](SCS.md) (next to this file) before adding or moving code in an SCS. It sets the
layout inside `src/` and `ui/`: `ui/` is split into `pages/`, `components/`, `hooks/`, `utils/`
and generated `types/`, and every custom React hook lives in `ui/hooks/`, one per file.

## SCS scope

Implement a feature inside one SCS whenever possible. A PR is scoped to one **primary SCS**,
the one the feature belongs to. Every other SCS the diff touches (`services/bff` included) is a
**secondary SCS**.

- Count changed lines (additions + deletions) per secondary SCS, ignoring generated files and
  lockfiles (`Cargo.lock`, `pnpm-lock.yaml`).
- **20 lines or fewer** per secondary SCS: allowed when genuinely needed.
- **More than 20 lines** in a secondary SCS: requires human sign-off. Prefer splitting it into
  its own PR that lands first, with the feature PR stacked on top. If it stays, the PR
  description must answer:
  - Why did the change to the other SCS have to exceed 20 lines?
  - Which options were considered, and why was this one chosen?
- **`packages/`**: changes to shared code go in their own PR (stacked below or separate) so they
  are reviewed on their own.
- **Repository wiring** (`infra/helm`, `docker-compose.yaml`, root `Cargo.toml`,
  `pnpm-workspace.yaml`, `scripts/`): expected when adding a new SCS; otherwise it counts like a
  secondary SCS.
- **`playwright/`** tests that exercise the primary SCS's feature count as the primary SCS.

Per-path line counts for the current branch:

```bash
git diff --numstat origin/dev...HEAD -- . ':!**/Cargo.lock' ':!pnpm-lock.yaml' | awk '{split($3,p,"/"); k=(p[1]=="services"||p[1]=="plugins"||p[1]=="packages")?p[1]"/"p[2]:p[1]; s[k]+=$1+$2} END {for (k in s) print s[k], k}' | sort -rn
```

If a secondary SCS exceeds 20 lines, tell the user and add this section to the PR description:

```markdown
## Out-of-scope changes (> 20 lines)

- **Primary SCS:** services/<name>
- **Secondary changes:** <path>: <changed lines>
- **Why more than 20 lines was necessary:** <reason>
- **Options considered:**
  1. <option>: <why rejected>
  2. <option>: <why chosen>
```

## No comments in source

No comments or doc comments in `.rs`, `.ts`, `.tsx`, `.css`, `.proto`, Makefile, YAML or shell
(`docs/architecture.md` "Comments", `docs/conventions/anti-patterns.md`). Names are the
documentation. When you edit a file that still has comments, delete them too. Generated files
keep their generator's header.

## UI

Read [`UI.md`](UI.md) (next to this file) before building or restyling a screen. It sets the
**design type** (Flat Design 2.0 plus Minimalism — flat surfaces, 1px borders, shadows only on
floating layers; no glassmorphism, no gradients in product UI), the **design principles** a
screen is checked against (**Information Density**, **Grounding**, **Progressive Disclosure**),
and the **colour and width rules** (colour carries state only, sequential scales for grades,
container queries inside panes). Apply it when reviewing a PR that adds or changes a screen.

## UX

Read [`UX.md`](UX.md) (next to this file) before designing a user-facing flow. It defines the
three perspectives a flow is checked against, and the order they apply in: **Information Scent**
(the user is already acting — make the next step legible), **Anticipatory Design** (the system
acts unasked — keep it ignorable and reversible) and **Delegation** (the user hands over a
bounded scope — give it range, review and undo). Apply it when reviewing a PR that adds
or changes a user-facing flow.

## Mobile web

Read [`MOBILE.md`](MOBILE.md) (next to this file) before any mobile web work, and apply it when
reviewing a PR that adds or changes a mobile layout. A mobile change must never alter the desktop
render: express it only as Tailwind `max-md:` variants, or split mobile and desktop into
separate components behind one clear branch.

## Rust

- **Conversions**: implement `From` / `TryFrom` (use `Into`); never write `type1_from_type2` /
  `type1_to_type2` / `from_x` / `to_x` helper functions.
- **Reuse**: use existing macros and `packages/*` instead of repeating boilerplate or
  reimplementing what already exists.
- **Errors** (`docs/conventions/error-handling.md`): never build an error inline from a string
  (`Status::internal(format!(..))`, `Status::unknown(e.to_string())`); the frontend cannot
  branch on it.
  - gRPC: a domain error enum in the crate's `error.rs` (reference:
    `services/dataroom/src/error.rs`) with one variant per failure the caller must distinguish,
    plus `From<DomainError> for tonic::Status` mapping each variant to a chosen code:
    `failed_precondition` for a refusal the user can act on, `permission_denied` only for
    callers who should not be there at all.
  - HTTP: an error enum with `Serialize + AsStatusCode`, never an `IntoResponse` impl.
  - Internal-detail payloads carry `#[serde(skip)]`.
- **Tests**: unit tests go in a separate `tests.rs`, registered with `#[cfg(test)] mod tests;`
  (`foo.rs` → `foo/tests.rs`, `dir/mod.rs` → `dir/tests.rs`). No inline
  `mod tests { .. }` blocks; move any you find in a file you touch. This is stricter than
  `docs/conventions/testing.md` and wins.

## Data modeling

- Exactly one owning service migrates each table. Any other service reads it only through a
  `#[postgres(skip_schema)]` mirror whose columns are a strict subset of the owner's.
- Cross-service foreign keys are limited to `workspaces(id)`.
- Do not store values derivable by aggregate queries (sum, count, avg); compute them on demand.
- Add indexes that cover every query you introduce or change.

## BFF

`services/bff` is the only process the browser talks to. It owns no tables and holds no feature
logic.

- Core traffic goes through `services/bff/src/api/core_rpc.rs` (`CoreCall` to workspace).
  Plugin traffic goes through `services/bff/src/api/plugin_rpc.rs` (`PluginCall` to dataroom,
  assessment, review). Adding a method to a service or plugin **never** adds a BFF route.
- Do not add feature routes or modules under `services/bff/src/api/`, feature code under
  `services/bff/src/features/`, or BFF DTOs or validation mirroring a gRPC contract.
  `search.rs` and `storages.rs` are legacy; do not add siblings next to them.
- New BFF code is justified only when the browser needs a REST shape the dispatchers cannot
  give it, and the PR description must say why.
- Frontend: host pages use hooks from `@biyard/bff-client`. Plugin UIs call through
  `host.call` from `@biyard/plugin-host` and never import react-query hooks. No hand-written
  `fetch` or direct handler calls.

## Generated TypeScript

- ts-rs output comes from `make gen-ts` and is gitignored; never commit or hand-edit it.
  (`services/workspace/types/methods.ts` is hand-written.)
- `#[ts(export, export_to = "types/")]` is correct; each Makefile points `TS_RS_EXPORT_DIR` at
  its SCS's `ui/`.
- ts-rs derives sit behind `cfg_attr(feature = "ts-bridge", ..)`. A new crate that emits
  TypeScript needs a `gen-ts` Makefile target and a matching `.gitignore` entry.
- Run `make gen-ts` after changing a route macro or a `ts-rs` type.

## Documentation

- Do not add specs, plans or design documents to the repository.
- `README.md` and `docs/**` explain how to use a service and give the big picture of what it
  offers. They do not walk through code (functions, structs, fields, control flow), and they
  hold no changelogs, "previously X, now Y" notes, or decision records; those belong in the PR
  description and commits.
- When adding a user-visible capability, add one entry at the existing level of abstraction
  (e.g. a new item in the list of assessment methods), not a walkthrough.

### SCS README

Every `services/<name>/README.md` and `plugins/<name>/README.md` follows the shape of
`services/dataroom/README.md`. Sections, in this order; drop one only when it would be empty:

| Section | Holds |
|---|---|
| `# <Name>` + intro | What the thing is in domain terms, what this SCS owns, and what it ships (plugin id, route) |
| `## Purpose` | Three or so bullets: why the SCS exists and what it is the single owner of |
| `## Features` | Table `Feature \| What a user can do`, one row per user-visible capability |
| `## Where it sits` | Table `Direction \| Peer \| How \| What for` for every gRPC, HTTP and Kafka peer, in and out |
| `## Plugin methods` / API | Table `Method(s) \| Does \| Who may call`; group related methods in one row |
| `## Events` | Table `Direction \| Topic \| Payload \| Consumer / producer`, plus delivery guarantees a caller relies on |
| `## Data it owns` | Table `Table \| Holds`, described in domain terms, then who else reads it and how |
| `## Not in this service` | Where neighbouring responsibilities live |
| `## Running it` | Table `Setting \| Meaning` for env vars, operational pitfalls, then the `make` / `pnpm` commands |

- Write for someone using or integrating with the SCS, not for someone reading its code. No
  function, struct, field, file-by-file or control-flow narration; name a type or path only when
  it is part of the contract (a proto service, an event payload, a table, a shared UI entry).
- Describe behaviour a peer depends on (auth per method, one run in flight, idempotent consumers),
  not how it is implemented.
- Keep it current: a PR that adds a method, event, table, peer or setting updates the matching row
  in the same PR.

## Versions

Only the SCSs that ship a plugin bundle (`meta.ts`) are versioned: `plugins/review` and
`plugins/vc`. A PR that changes what goes into one of those bundles (its `ui/`, `meta.ts`,
`public/`) bumps that SCS's `version` in its `package.json` (patch for fixes, minor for
features). Backend-only changes and changes to other SCSs do not bump. `services/dataroom` and
`services/assessment` are built-in plugins (`manifest.json`, version `"builtin"`): they ship with
the console build and are never bumped.

- The bundle is published to `{id}/{version}/`, and `scripts/publish-plugin-bundle.sh` refuses
  to overwrite a published version with a different bundle, so a missed bump fails the
  `plugin-bundle` CI job on `dev`.
- A change to shared UI code a bundle includes (`packages/components`, `packages/plugin-host`)
  also changes those bundles: bump every plugin that uses it. The same holds for
  `services/dataroom/ui` and `services/assessment/ui`: `plugins/review` (and `plugins/vc` when it
  imports them) compiles that code in, so a change there bumps them.
- Bump against the version on `dev` at merge time; if `dev` moved past your bump, bump again
  after merging it in.

## Pull requests

PRs target `dev`. Read [`PULL_REQUEST.md`](PULL_REQUEST.md) (next to this file) before opening
one, and follow it to the end: it covers creating the PR with `gh`, replying to and resolving
review comments (a comment that was already considered and intended gets a by-design reply and
stays open; only fixed comments get resolved), and watching CI until every check is green.

Before opening one, check:

- [ ] Scope: one primary SCS; each secondary SCS ≤ 20 lines, or split / justified as above.
- [ ] Version bumped for every versioned plugin bundle (`plugins/review`, `plugins/vc`) whose
      contents changed.
- [ ] No comments in touched source files.
- [ ] No inline test modules; no inline string errors.
- [ ] No new BFF feature routes; no generated TypeScript committed.
- [ ] No spec, plan or code-narrating docs added.
- [ ] New or moved UI code follows the `SCS.md` layout; custom hooks are in `ui/hooks/`.
- [ ] Screens follow `UI.md`: flat surfaces, shadows only on floating layers, colour for state only, no product-UI gradients.
- [ ] User-facing flows follow `UX.md`: next step legible; unasked-for actions ignorable and reversible; delegated actions have range, review and undo.
- [ ] Mobile changes follow `MOBILE.md`; desktop render unchanged.
