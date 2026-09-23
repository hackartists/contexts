# Pull Request Guide

How a change to Dataroom becomes a pull request and gets to green. The rules the change
itself must satisfy live in the project rules (`CLAUDE.md`); this guide says how to open the
PR with `gh`, how to work through the review comments it attracts, and how to drive CI to
green. How the PR is reviewed from the other side is in [CODE_REVIEW.md](CODE_REVIEW.md).

A PR is not finished when it is opened. It is finished when every review thread is either
resolved or answered as by design, and every CI check is green.

## Before opening

- Work through the checklist at the end of `CLAUDE.md` ("Pull requests"). Every box is a
  finding the reviewer will raise if it is not already true.
- Count the per-path diff and decide the primary SCS:

  ```bash
  git diff --numstat origin/dev...HEAD -- . ':!**/Cargo.lock' ':!pnpm-lock.yaml' | awk '{split($3,p,"/"); k=(p[1]=="services"||p[1]=="plugins"||p[1]=="packages")?p[1]"/"p[2]:p[1]; s[k]+=$1+$2} END {for (k in s) print s[k], k}' | sort -rn
  ```

- Run locally what CI runs, so the first CI round is not the first time the code is checked:

  | Check | Command | CI job |
  |---|---|---|
  | Rust | `cargo check --workspace --all-features --all-targets && cargo test --workspace --all-features` | `packages`, `service` |
  | Generated TS | `make gen-ts`, then confirm the tree is still clean | `gen-ts` |
  | Frontend | `pnpm lint && pnpm typecheck && pnpm build && pnpm test` | `web` |

  CI sets `RUSTFLAGS: -D warnings`. A warning that is fine locally fails the build there.
- Push the branch: `git push -u origin <branch>`.

## Opening the PR

Always open it with `gh`, never the web UI, so the body is scripted and reproducible.

```bash
gh pr create --base dev --head <branch> --title '<title>' --body-file <file>
```

- **Base** is always `dev`.
- **Title**: one line, imperative, in the language the commits use, naming what the change
  does — not the files it touches.
- **Body**: write it to a file first and pass `--body-file`. Never inline a multi-line body
  with `--body`; shell quoting mangles markdown. Never use `--fill`, which just pastes the
  commit log.
- Write the description in the same language as the commits. `review-pr.sh` detects the
  language from the PR body and answers in it, so an English body on a Korean branch gets an
  English review.

The body carries what the code cannot say, and nothing the code already says:

```markdown
## What this changes

<what a user can now do, or what stops being broken>

## Why

<the problem, and why this approach over the alternatives>

## How to verify

<the steps a reviewer follows, or the preview route to open>
```

Add sections only when the rules demand them:

- **Out-of-scope changes** — a secondary SCS over 20 lines. Use the exact template in the
  `CLAUDE.md` "SCS scope" section; the reviewer checks that both questions are answered.
- **New BFF code** — say why the browser needs a REST shape `core_rpc.rs` / `plugin_rpc.rs`
  cannot give it.
- **Version bumps** — list each plugin bundle bumped and the version it moved to.

Then capture the number for everything that follows:

```bash
PR=$(gh pr view --json number --jq .number)
```

## Review comments

Reviews arrive after the PR is open, from the automated reviewer and from people. Poll until
they land; do not declare the PR done because none have arrived yet.

Read them in two places — they are different APIs:

```bash
gh pr view "$PR" --json reviews,comments          # review summaries and top-level comments
```

```bash
gh api graphql -f query='
  query($owner:String!, $repo:String!, $number:Int!) {
    repository(owner: $owner, name: $repo) {
      pullRequest(number: $number) {
        reviewThreads(first: 100) {
          nodes {
            id
            isResolved
            path
            line
            comments(first: 20) { nodes { databaseId author { login } body } }
          }
        }
      }
    }
  }' -f owner=biyard -f repo=dataroom -F number="$PR"
```

Keep, per thread, its `id` (needed to resolve it) and the `databaseId` of its **first**
comment (needed to reply to it).

### Decide on each thread

Not every comment has to be acted on. Each thread ends in exactly one of two states:

| The comment is | Do | Thread ends |
|---|---|---|
| A real defect, or a rule violation | Fix it in code | **Resolved** |
| Something already considered and decided the other way | Reply saying it is by design, with the reason | **Left open**, answered |

By design is a claim about a decision that was actually made — a trade-off weighed before the
comment arrived, a constraint from elsewhere in the system, a deliberate scope boundary. It is
not a way to wave off a comment that is simply inconvenient. When the reviewer is right, fix
it. When the comment reveals the decision was wrong, fix it and say so.

Never resolve a thread answered as by design. Leaving it open is what lets the reviewer
disagree; resolving it hides the disagreement.

### Reply to a thread

```bash
gh api --method POST \
  "repos/biyard/dataroom/pulls/$PR/comments/<first comment databaseId>/replies" \
  -f body='<reply>'
```

Reply in the language the comment was written in.

- **By design**: open with `By design.` (or `의도된 동작입니다.`), then the reason in one or
  two sentences — what was considered, and why this way. No apology, no hedging.
- **Fixed**: name what changed and the commit that changed it, e.g. "Fixed in `<sha>`: the
  error is now a domain error variant instead of an inline string."

For a review's top-level summary body, reply with `gh pr comment "$PR" --body '<reply>'`.

### Push the fixes, then resolve

Fix the comments in code, commit and push as normal commits — never a force-push that rewrites
the reviewed history, which detaches every thread from its line.

```bash
git commit -am '<what changed>' && git push
```

Reply to each fixed thread with the commit, then resolve it:

```bash
gh api graphql -f query='
  mutation($id: ID!) {
    resolveReviewThread(input: { threadId: $id }) { thread { isResolved } }
  }' -f id='<thread id>'
```

Resolve only threads that were actually fixed, and only after the fix is pushed.

Then look again: a push draws a fresh review. Repeat the whole cycle — list threads, decide,
reply, fix, resolve — until every thread is resolved or answered as by design.

## CI

Every push runs `ci.yml`. A PR into `dev` runs `context`, `packages`, `service` (one job per
backend service and plugin), `gen-ts`, `web`, `plugin-bundle`, `helm`, `deploy-pr` and `e2e`.
Watch them to the end:

```bash
gh pr checks "$PR" --watch --interval 30
```

On a failure, read the failing job's log rather than guessing:

```bash
gh run list --branch "$(git branch --show-current)" --limit 5
gh run view <run id> --log-failed
```

Common failures and where the fix goes:

| Job | Usual cause | Fix |
|---|---|---|
| `packages` / `service` | A warning (`-D warnings`), or a test that needs the CI Postgres | Fix the warning or the test; never silence it with `#[allow]` |
| `gen-ts` | A route macro or `ts-rs` type changed without regenerating | Run `make gen-ts`; the fix is in the Rust source, never in the generated file |
| `web` | `pnpm lint` / `typecheck` / `test` | Fix in `ui/`; the eslint `ui-scales` rule is not negotiable |
| `plugin-bundle` | A bundle's contents changed without a version bump | Bump the SCS's `package.json` `version` past what `dev` published |
| `e2e` | A flow changed without its Playwright step | Update the persona journey in `playwright/tests/scenarios/*.spec.ts` |

Push the fix as a new commit and watch again. If a job fails for an obviously infrastructural
reason (a runner dropping, a registry timeout), `gh run rerun <run id> --failed` once; if it
fails the same way twice, it is not flaky — find the real cause and say so in the PR.

Keep this loop running until every check is green. A PR with a red check is not ready,
however good the review went.

## Done

The PR is finished when all of these hold:

- [ ] Every review thread is resolved (fixed) or answered as by design (left open).
- [ ] Every fix is pushed, and the reply on its thread names the commit.
- [ ] `gh pr checks "$PR"` reports every check green.
- [ ] The description still matches the code after the review round — the out-of-scope,
      BFF and version sections included.

Report to the user: the PR URL, what was fixed from review, what was answered as by design
and why, and the final state of CI. Do not merge unless asked.
