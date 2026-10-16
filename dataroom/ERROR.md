# ERROR.md

How a dataroom error is defined, carried to the browser and shown. Code of record:
`packages/service-error` (trait, `ServiceStatus`, gRPC conversion), `packages/service-error-macros`
(the derive), `services/bff/src/features/core_gateway/types/rpc_error.rs` (gateway mapping),
`packages/plugin-host/src/contract.ts` (`describeError`).

## Definition

- Each SCS owns its error enum in `src/error.rs`, derived with
  `#[derive(thiserror::Error, service_error::ServiceError)]`. Never share an enum across SCSs.
- Every variant carries `#[service_error(code = N, status = S)]`. The derive refuses to compile on:
  missing attribute, missing `code` or `status`, the attribute repeated, `code = 0` (reserved for
  unknown), `code > 999_999`, a code used twice in one enum, `status` outside `400..=599`, any key
  other than `code` / `status`, a non-enum.
- Codes are numbered per SCS from 1. New variants take the next free number. Never renumber or
  reuse an existing code: the UI catalog keys on it.
- The public text is the `#[error(..)]` Display string and nothing else; it becomes
  `ServiceError::message()`.
- 5xx variants are unit variants with no fields. Log the cause where the error is created with
  `tracing::error!` (the subscriber prints file and line), then return the variant.
- 4xx variants may interpolate a field (`{0}`) only when it is data the user can fix. The UI shows
  it only where the catalog entry has `{{message}}`.
- Map a lower-level error into a variant with `impl From<LowerError> for DomainError`, logging
  inside it when the target is 5xx.

```rust
#[derive(Debug, Clone, thiserror::Error, service_error::ServiceError)]
pub enum EvaluationError {
    #[error("assessment is frozen")]
    #[service_error(code = 21, status = 409)]
    AssessmentFrozen,
    #[error("invalid params: {0}")]
    #[service_error(code = 29, status = 400)]
    InvalidParams(String),
    #[error("assessment storage failed")]
    #[service_error(code = 31, status = 500)]
    Database,
}
```

(`services/assessment/src/error.rs`.)

## Forbidden

- Constructing `tonic::Status` directly. Each SCS's `clippy.toml` lists in `disallowed-methods`:
  `tonic::Status::{new, with_details, with_metadata, with_details_and_metadata, ok, cancelled,
  unknown, invalid_argument, deadline_exceeded, not_found, already_exists, permission_denied,
  resource_exhausted, failed_precondition, aborted, out_of_range, unimplemented, internal,
  unavailable, data_loss, unauthenticated, from_error}`. A new SCS copies that `clippy.toml`.
- Hand-written `From<E> for tonic::Status`, `IntoResponse` or `AsStatusCode` impls for an error;
  the derive generates the `Status` conversion.
- Inline string errors (`format!(..)`, `e.to_string()` as the error).
- Catch-all variants (`Failed(String)`, `Internal(String)`, `Other`) that merge different causes.
  One variant per cause the caller or the operator must tell apart.

## Transport: service → BFF (gRPC)

The derived `From<E> for tonic::Status` sets:

| Field | Value |
|---|---|
| `message` | Display text |
| metadata `x-error-code` | `code` |
| metadata `x-http-status` | `status` |
| gRPC code | from `status` (`packages/service-error/src/grpc.rs`) |

| HTTP | gRPC |
|---|---|
| 400 | `InvalidArgument` |
| 401 | `Unauthenticated` |
| 403 | `PermissionDenied` |
| 404 | `NotFound` |
| 409 | `Aborted` |
| 412 | `FailedPrecondition` |
| 429 | `ResourceExhausted` |
| 501 | `Unimplemented` |
| 503 | `Unavailable` |
| other 5xx | `Internal` |
| other 4xx | `InvalidArgument` |

The BFF decodes with `ServiceStatus::try_from(&Status)`. A code outside `1..=999_999` counts as
missing; an `x-http-status` outside `400..=599` falls back to 502.

## Transport: BFF → browser

- Body is always `{service, code, message}` (`RpcError`) with the HTTP status the service declared.
- `service` is filled by the BFF from routing: the plugin id for `PluginCall`, the core service name
  for `CoreCall`. A service never writes it.
- A `Status` without a valid code becomes `code: 0` (key `000000`, unknown), HTTP status from the
  gRPC code:

| gRPC | HTTP | Message |
|---|---|---|
| `InvalidArgument`, `FailedPrecondition`, `OutOfRange`, `Unimplemented` | 400 | upstream message, or the code description when empty |
| `PermissionDenied`, `Unauthenticated` | 403 | `forbidden` |
| `NotFound` | 404 | `not found` |
| `AlreadyExists`, `Aborted` | 409 | upstream message, or the code description |
| `Unavailable` | 503 | code description |
| `DeadlineExceeded` | 504 | code description |
| other | 500 | code description |
| backend unreachable (`Unreachable`) | 502 | `service unavailable` |

- Errors raised by the BFF itself go out as `service: "bff"`. BFF enums share one key space and
  take separate ranges: `BffError` 1–13, `WorkspaceError` 101–107, `PublicationError` 201–205.
  `every_bff_error_code_is_unique_across_the_bff` (`services/bff/src/error_response/tests.rs`)
  guards against overlap. BFF handlers return `ErrorResponse`, which wraps any `ServiceError`.

## UI

- Catalog key: `"{service}.{code:06}"` (`errorKey`), e.g. `assessments.000021`, `bff.000006`.
- Each SCS UI owns a ko + en catalog in `ui/i18n-errors.ts`, keyed by its own service id. The ko
  catalog is typed `Record<keyof typeof <en catalog>, string>` so the two cannot drift.
  Current locations:
  - `services/<name>/ui/i18n-errors.ts`: assessment (`assessments.*`), auth, dataroom, publication.
  - `plugins/<name>/ui/i18n-errors.ts`: review, vc.
  - `services/bff/ui/src/i18n-errors.ts`, exported as `@biyard/bff-client/i18n-errors` (`bff.*`).
  - `services/workspace/ui/i18n/errors.ts`: workspace, plus the `search.*` catalog (search has no
    UI); it merges the bff, auth and publication catalogs for the host.
- 5xx codes are usually left out of the catalog; a missing key falls back to the unknown text.
- Display only through `describeError(e, texts)` from `@biyard/plugin-host`. Never render
  `e.message`, never branch on a code, kind or message string to pick a text.
- `describeError` order: not a `PluginRpcError` → unknown; status 0 → offline; 403 → forbidden;
  catalog hit (with `{{message}}` replaced by `e.message`); missing key or code 0 → unknown.
- `describeRefusal` returns the catalog text only for a non-403 4xx, else `null`; use it for inline
  refusals that should not show a generic error. `isForbiddenError` checks status 403.

## Known gaps in code

Do not copy these; they predate the convention.

- `services/evaluation/src/error.rs`: `Failed` (500) catch-all, `Serialize`, hand-written
  `AsStatusCode`.
- `services/search`: two enums (`SearchQueryError` 1– in `grpc/error.rs`, `SearchError` 101– in
  `error.rs`); `SearchError` serializes its own `service` field and `api/error_response.rs` has an
  `IntoResponse` impl.
- `services/storage`: the error enum is `grpc/error.rs`; the HTTP API still uses
  `StorageApiError` with string codes and `AsStatusCode`.
- `services/{document,onchain-source-connector,web-source-connector,nps-source-connector}`: no
  `ServiceError` enum; the last three implement `AsStatusCode`. Services without `clippy.toml`:
  document, landing, nps-source-connector, onchain-source-connector, web-source-connector,
  ws-gateway.

## Undecided

Not rules yet; follow current code.

- BFF code ranges per enum vs one BFF enum.
- A CI check that every code has a catalog entry.
- Structured params in catalog entries instead of `{{message}}`.
