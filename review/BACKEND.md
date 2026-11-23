# Backend review checklist

Added to `COMMON.md` when the PR changes backend files: Rust sources, `Cargo.toml` / `Cargo.lock`,
`build.rs`, `.proto` / `buf.yaml`, `migrations/`, an `sdk/` crate or the top-level `types/` of a
service. Report it as the backend checklist section of the summary (`COMMON.md`, "Review content").

## Which items apply

- **Rust items (B1–B4)** apply to any Rust change.
- **Service items (B5–B12)** apply to a Biyard service repository: its `Cargo.toml` depends on
  `biyard/rbdk` crates and `.github/workflows/ci.yml` calls `biyard/rust-backend-ci`. Their
  layout is in `biyard/template-rust-backend` (`README.md`, "Layout"): `src/` server crate,
  `sdk/` the `<name>-sdk` contract crate, `sdk/proto/biyard/<name>/v<N>/`, `migrations/`,
  `.env.sample`, `deploy/values*.yaml`, `buf.yaml`, `table-access.allow`.
- **rbdk items (B13)** apply to `biyard/rbdk` itself.
- In any other Rust repository, the service items apply only where the repository's own rules or
  layout make them meaningful; say which you skipped.

## Already enforced by CI

`rust-backend-ci` runs these on every PR; do not report what they catch:

- `cargo fmt --all --check`, `make check` (`cargo check` + `cargo clippy -- -D warnings`, with
  `RUSTFLAGS=-D warnings`) and `make test`. `clippy.toml` bans constructing `tonic::Status`
  directly (`disallowed-methods`).
- `buf lint` (when `buf.yaml` has a `lint` section) and `buf breaking` against the base branch:
  proto wire compatibility and versioned package names.
- The `table-access.allow` ratchet: a new `#[postgres(.., skip_schema)]` mirror of a table not
  listed there fails CI.
- In `biyard/rbdk`: `cargo semver-checks` per crate against its last release tag.

Read the repository's `ci.yml` to confirm it calls the shared workflow and with which
`check-command`; a repository that overrides or skips these checks gets them reviewed by hand.

## Checklist

- [ ] **B1. Errors**
  - Rules: each service owns one error enum, in its sdk's `error` module (`sdk/src/error/mod.rs`
    or `sdk/src/error.rs`) when it has an sdk, else `src/error.rs`, shared by sdk and server —
    never a separate sdk error type, never one enum shared across services. It derives
    `thiserror::Error` and `service_error::ServiceError` (rbdk `service-error`); every variant has
    `#[service_error(code = N, status = S)]`, one variant per failure the caller or operator must
    tell apart. Codes are numbered per service from 1 and are never renumbered or reused (UI
    catalogs key on them). `#[error(..)]` is the public message. 5xx variants are unit variants
    with no fields; the cause is logged with `tracing::error!` where the error is created. A 4xx
    variant interpolates a field only when it is data the user can fix. Lower-level errors map in
    with `impl From<Lower> for DomainError` (logging inside when the target is 5xx); in an sdk such
    a `From` for a server-only error sits behind the feature that pulls that dependency. Sdk code
    that can fail returns that enum, never `String`, `anyhow` or a local error type.
  - Check: no hand-written `From<E> for tonic::Status`, `IntoResponse` or `AsStatusCode` on an
    error enum (the derive owns the wire shape); no inline string errors (`format!(..)`,
    `e.to_string()` as the error); no catch-all variant (`Failed(String)`, `Internal(String)`,
    `Other`); no renumbered code; no 5xx variant with fields.
  - Check: a new user-facing code needs a ko + en entry `"{service}.{code:06}"` in the UI catalog
    that shows it (`i18n-errors.ts` of the matching `@biyard/*` package in
    `biyard/react-components`, or of the app). That is another repository: report it as a
    follow-up PR to open, not a blocker of this one.
  - Report: when flagging an inline string error or a catch-all, name the variants (with the next
    free code and the status) that the diff's failure cases imply. Blocking, except the catalog
    follow-up.

- [ ] **B2. Shorthand**
  - Check: a longhand form with a shorter equivalent — a redundant `.map_err(X::from)?` before a
    `?` that already converts, forwarding closures (`.map(|x| f(x))`), an unwrap-or-return
    `match` that `let … else` or `?` expresses, `{ id: id }`.
  - Report: quote the shorthand. Repeats of one pattern: one comment listing the lines.
    Recommendation, not blocking.

- [ ] **B3. Conversions and reuse**
  - Check: conversions are `From` / `TryFrom` (used through `Into`), never `type1_from_type2` /
    `to_x` / `from_x` helper functions. Boilerplate that an existing macro or an rbdk crate already
    provides is not repeated (`postgres` entities and queries, `service-error`, `service-runtime`
    `CommonServer`, `runtime-config`, `event`, `common-api-routes`, `net-guard`,
    `canonical-json`, `shared`; list in `biyard/rbdk` `README.md`). Versioned stored JSON uses
    `postgres` `VersionedJson` / `Migrator`, not a hand-written `deserialize_with` conversion or a
    SQL `CASE WHEN` on a version.
  - Report: inline, naming the trait, macro or crate to use.

- [ ] **B4. Tests**
  - Check: unit tests live in a separate `tests.rs` registered with `#[cfg(test)] mod tests;`
    next to its module (`foo/mod.rs` + `foo/tests.rs`, never `foo.rs` beside a `foo/`
    directory). No inline `mod tests { .. }` block in a file the diff touches. New behaviour comes
    with tests that exercise it; tests that need PostgreSQL are `#[ignore]`d and matched by the
    workflow's `db-tests` filter when the repository uses one.
  - Report: inline test modules ONCE, listing the files. A missing test: inline on the untested
    branch, naming the case.

- [ ] **B5. Service ownership and layout**
  - Check: server code in `src/`, contract in `sdk/`, schema in this repository's
    `migrations/`. Modules are named after the domain aggregate, not the transport. Auth is
    checked per method in the service itself, even when a caller already checked it. Logic that
    belongs to another service's domain (`services.yaml`, the other README's "Not in this
    service") is flagged under C2.
  - Report: inline, naming the directory or the owning repository.

- [ ] **B6. SDK boundary**
  - Rules: another service is used only through its `<name>-sdk` (a git dependency on that
    service's repository), never its server crate. An sdk holds the whole public contract — domain
    types other services use, the events it produces, its proto with generated client and server,
    its error enum — and nothing else: no DB access, no tokio runtime, no Kafka publishing, no
    server logic; heavy parts sit behind features (`events`, `grpc-client`, `grpc-server`,
    `postgres`, `ts-bridge`). sdk→sdk dependencies form a DAG; a type shared by two services lives
    in the lower-layer sdk. Event structs and every type in their fields are defined in the
    producer's sdk, never with a consumer's or another service's type. Per-type behaviour
    (prompt, answer schema, value parsing and validation) is a trait impl in the owning sdk; a
    consumer calls it and never re-implements it from a type-label string. Events and gRPC
    messages carry sdk types, never JSON in a `String` or `serde_json::Value` when an sdk type
    exists (`payload: EvaluatedPayload`, not `payload_json: String`).
  - Check: each rule against the diff, including new `[dependencies]` in `Cargo.toml`.
  - Report: inline on the dependency or type. Blocking.

- [ ] **B7. Contract changes across repositories**
  - Check:
    - A change to this service's contract (sdk types, proto, events) is backward compatible:
      proto stays wire compatible (CI checks the wire; you check meaning — a field whose meaning
      changed, a value callers now must send); a breaking proto change goes into a new package
      version (`biyard.<name>.v2`) next to `v1`, which stays until its callers move; a Kafka
      payload stays backward compatible, or the breaking shape is a new event version
      (`#[event(version = N)]` / a `…V2` type, topic `{ENV}.{name}.v{N}`). CI does not check
      payloads; this is review only.
    - A consumer that needs a new contract bumps the owner's sdk to a merged ref. Flag a git
      dependency on a feature branch or an unmerged commit of another repository.
    - All rbdk crates are pinned to the same ref (mixed refs pull two copies of a crate whose types
      no longer match).
  - Report: inline on the proto, event type or `Cargo.toml` line. Blocking.

- [ ] **B8. Data modelling and migrations**
  - Rules: design relationally first — every relationship is a column or link table with a
    foreign key and an explicit `on_delete` (`CASCADE` when the child has no meaning without the
    parent, `RESTRICT` otherwise); no references inside JSON columns or as untyped `String` ids;
    no foreign key replaced by application-side or event-driven cleanup. A foreign key to a table
    another service owns references that table's primary key. Exactly one owning service migrates
    each table. No stored values derivable by aggregate queries (sum, count, avg). Indexes cover
    every query the diff introduces or changes. Old pods keep serving on the new schema during a
    rollout, so a schema change goes expand → switch → contract across releases (review only, no
    CI check).
  - Rules (stored data shape): changing the shape of stored data — JSON or payload columns,
    snapshots, derived rows — is done lazily by default, not by a bulk rewrite. The stored value
    carries an integer version under `data_version` inside the JSON (or the type's `key`; missing
    means version 1). The type derives `VersionedJson` with `#[data_version(current = N)]` and
    each version step is an `impl Migrator<N>` (rbdk `postgres::data_version`), applied when the
    column is decoded, so the reader always returns the current type. After the response, the
    converted value is written back with a compare-and-set on the old version (no `updated_at`
    change, no event, no audit entry); the next read then loads migrated data. Immutable data
    (published snapshots, audit, anything hashed, signed or anchored) is converted in memory and
    never written back; the type declares `#[data_version(immutable)]`. The release that raises
    `current` sets `write_back = false` and only reads; the next release removes it, after every
    pod runs the reader (old pods must not meet a version they cannot read). A higher version than
    the reader knows is `DataVersionError::Unsupported`, mapped to a 503 variant of the service's
    error enum, never ignored. A one-time bulk migration is acceptable only when lazy conversion cannot
    work — a new column, table or index; a column that is filtered, sorted or joined; a row-level
    data fix — and it stays backward compatible and is owned by the service itself.
  - Check: the model fits its storage type; relationships are appropriate; a migration that drops
    or renames a column or table still read by the running release; a new entry in
    `table-access.allow` (reading another service's table) — the PR must say why the owner's gRPC
    API cannot serve it; a stored-shape change with no version field or `Migrator` step; a
    one-shot `UPDATE` or SQL script that rewrites payloads a `Migrator` step could convert (the
    PR must say why it cannot be lazy); write-back on immutable data; a diff that raises `current`
    without `write_back = false`; a JSONB type whose stored shape changed but still derives
    `PostgresJson`; a `Migrator` step removed while `count_versions` shows rows still at that
    version.
  - Report: inline on the migration or model. Blocking for a missing foreign key, a destructive
    one-step schema change, an unjustified `table-access.allow` entry, a bulk payload rewrite
    where a `Migrator` step would do, and write-back on immutable data.

- [ ] **B9. Configuration and deployment**
  - Check: a new setting read by the service is listed with its default in `.env.sample`
    (rust-backend-ci renders it into the ConfigMap) or, when secret, wired in
    `deploy/values*.yaml` from a Secret; no secret value in `.env.sample` or values files. A new
    peer the service calls is in `deploy/values*.yaml` and the README.
  - Report: inline on the code that reads the setting. Blocking: without it the deployed service
    starts without the value.

- [ ] **B10. Generated TypeScript (ts-rs)**
  - Rules: ts-rs derives sit behind `cfg_attr(feature = "ts-bridge", ..)`;
    `#[ts(export, export_to = "types/")]` is correct (do not flag it). The output written by
    `make gen-ts` is gitignored (`types/*.ts` except a hand-written `types/methods.ts`, or the
    paths `.gitignore` lists) and never committed or hand-edited. A new crate that emits
    TypeScript needs a `gen-ts` Makefile target and a matching `.gitignore` entry.
  - Report: inline. A change to a ts-rs type that a frontend consumes means the frontend's types
    must be regenerated in its own repository (`react-components` `DATAROOM_REV` /
    `scripts/gen-types.sh`, or the app's prepare script): mention that follow-up in the summary.

- [ ] **B11. Frontend/backend naming**
  - Check: when the diff adds or renames a Rust type whose UI counterpart already exists, or the
    reverse, the names keep the link obvious (exact name for a 1:1 counterpart, e.g. `FormulaSpec`
    on both sides; enough of the name for a partial one, e.g. `field_schema.rs` ↔
    `field-widget.tsx`).
  - Report: inline, naming the counterpart to align with. Recommendation.

- [ ] **B12. README contract rows**
  - Check: the service README is updated in the same PR for every new or changed gRPC method,
    event (topic, payload type path in the sdk, delivery guarantees a consumer relies on), owned
    table, peer and setting. Behaviour a peer depends on is described (auth per method,
    idempotent consumers), not how it is implemented.
  - Report: under C6.

- [ ] **B13. rbdk crates** (only in `biyard/rbdk`)
  - Check: only domain-free code (domain code belongs in the owning service's sdk); a removed or
    changed public item comes with a major version bump of that crate; proc-macro crates, which
    `cargo semver-checks` cannot compare, are checked by hand for breaking changes. Doc comments
    on declarations are allowed (`COMMON.md` C4).
  - Report: inline. Blocking for an unbumped breaking change.
