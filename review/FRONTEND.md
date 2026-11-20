# Frontend review checklist

Added to `COMMON.md` when the PR changes frontend files: `.ts` / `.tsx` / `.js` / `.jsx` / `.mjs`
/ `.cjs` / `.css` / `.astro` / `.html` / `.vue` / `.svelte`, a `ui/` directory, `package.json`,
pnpm files, or Vite/Astro/TypeScript/ESLint configuration. Report it as the frontend checklist
section of the summary (`COMMON.md`, "Review content").

## Which items apply

- **General items (F1–F4)** apply to any frontend change.
- **Biyard React items (F5–F13)** apply when the repository is `biyard/react-components` or
  depends on its packages (`@biyard/components`, `@biyard/bff-client`, `@biyard/plugin-host`,
  … as `git+ssh://git@github.com/biyard/react-components.git#<sha>&path:/packages/<name>`
  entries in `package.json`). `biyard/tracky` is the reference consumer.
- In other frontends (other products, landing pages), apply F5–F13 only where the repository's own
  rules or dependencies make them meaningful; say which you skipped. In F1 their own shared
  component library, if any, takes the place of `@biyard/components`.

## Already enforced by CI

Read `.github/workflows/ci.yml` first; what runs differs per repository.

- `biyard/frontend-ci` (`frontend.yml@v1`): `pnpm install --frozen-lockfile` with the pnpm pinned
  in `packageManager`, then `pnpm run typecheck`, `test` and `build` by default. `lint` is OFF
  unless the caller sets `lint: true` (tracky does not), so in such a repository lint-level rules
  below (F6 query keys, F9 scales) are yours to check.
- `biyard/react-components`: prettier + eslint (`pnpm lint`, including the query-key
  `no-restricted-syntax` rules on `packages/*/src` and `packages/*/ui`, and `biyard/ui-scales` on
  `auth-ui`, `plugin-dataroom`, `plugin-assessments` and the storybook), typecheck, tests,
  plugin-host contract tests, the Storybook build, and `generated-types` (`scripts/gen-types.sh
  --check`) when `DATAROOM_REV` or the generator changes. Do not report what these catch.

## Checklist

- [ ] **F1. UI reuse**
  - Check: list what the shared component library exports — in `react-components`,
    `packages/components/src/index.ts`; in a consumer, the same file at the pinned commit:
    `gh api "repos/biyard/react-components/contents/packages/components/src/index.ts?ref=<sha from
    package.json>" -H "Accept: application/vnd.github.raw"`. Compare every new or changed
    component, element and style block in the diff against it. Flag markup built by hand where a
    shared component already does the job (button, input, select, combobox, dialog, sheet, drawer,
    dropdown menu, tabs, tooltip, table, badge, empty state, spinner, skeleton, and so on), and a
    local component that copies or nearly copies a shared one.
  - A component that a second app needs belongs in `react-components`, in its own PR there (C2).
  - Report: inline, naming the component and its import path. Collapse repeats into one comment
    listing the sites.

- [ ] **F2. Well-known libraries**
  - Check: logic the diff writes itself when a maintained library does it — date/time formatting
    and arithmetic, debounce/throttle, deep clone/compare, form state and validation, data
    fetching and caching, virtualised lists, drag and drop, focus trapping, popover positioning,
    number/file-size formatting, class name merging (`cn()` from `@biyard/components/utils`).
    Look at the repository's `package.json` first: a library it already depends on is the
    strongest suggestion. Suggest a new dependency only when the hand-written code is non-trivial
    (more than a few lines, or it gets edge cases wrong or skips them); never for a one-line
    helper.
  - Report: inline, naming the library and the function or hook.

- [ ] **F3. Source layout**
  - Rules (the layout of `tracky/ui` and the `ui/` of `react-components` packages): `pages/` one
    screen per route, a component only one page uses lives in that page's folder; `components/`
    shared by two or more pages; `hooks/` every custom hook, one per file
    (`hooks/use-<name>.ts` exporting `use<Name>` and the interface it returns) — no
    `function useX` inside a component, page or util; `utils/` plain TypeScript without React,
    one topic per file, no `utils.ts` / `helpers.ts` catch-all; generated wire types only under
    `types/`, a hand-written UI type sits with the module that produces it. Files kebab-case,
    components PascalCase, tests next to the file as `<file>.test.ts(x)`. A component gets data
    from props or a hook and never calls the RPC layer in its render body. Components share one
    hook instance by lifting it to the nearest common parent.
  - Check: new or moved files against these rules. Existing files that predate the layout move
    into place when a PR touches them; moving a whole app is its own PR.
  - Report: inline, naming the target path.

- [ ] **F4. Server boundary (BFF)**
  - Check: the browser talks only to the product's BFF. In a frontend that is its own BFF (Astro
    server endpoints under `src/pages/api/`, per `biyard/template-astro-frontend`), an endpoint
    authenticates the session and calls backend services over gRPC through their generated sdk
    clients; it owns no tables, holds no feature logic and adds no DTOs or validation mirroring a
    gRPC contract. In a static frontend (tracky), every read goes through the BFF RPC
    (`@biyard/bff-client`); no hand-written `fetch` to a service.
  - Report: inline. Do not ask the author to add BFF-level DTOs or validation; that duplication is
    itself a finding.

- [ ] **F5. Shared package pins**
  - Check: every `@biyard/*` entry in `package.json` points at the same `react-components`
    commit, they move together, and `pnpm-lock.yaml` is refreshed with them. Every `@biyard/*`
    package reached, directly or through another `@biyard/*` package, is listed (they are peer
    dependencies). A Tailwind entry that renders a `@biyard/*` package lists its source as an
    `@source` (`ui/styles/*.css` in tracky); without it the components render unstyled while
    typecheck, tests and build stay green.
  - Report: inline on `package.json` or the stylesheet. Blocking.

- [ ] **F6. React Query keys and server state**
  - Rules (code of record: `react-components` `packages/bff-client/src/query-keys/`): every key
    comes from a factory in `@biyard/bff-client/query-keys` (or `coreQueryKey` /
    `pluginQueryKey`) — no inline `queryKey: [...]` array, no key built by `.slice()`, no key
    position read (`key[3]`) outside `assessmentKeyMatch`. A key starts with exactly one root
    (`me`, `workspaces`, `workspace`, `admin`, `public`, `reference`) followed by label/id pairs
    from the widest scope to the narrowest; a new root is added to `rootModules` with its
    `<root>Scope`, `<root>Keys` and `<root>Policy`. The ws, room and assessment ids in a key are
    exactly the ids its `queryFn` sends.
  - Check:
    - Data under the wrong root (workspace-scoped data without a ws id, admin or public data under
      `workspace`), a label in an id slot, an id the `queryFn` reads but the key omits or the
      reverse.
    - A mutation or realtime path that changes data without invalidating, updating or removing
      every key that shows it; an invalidation wider or narrower than the change (use the scope
      helpers; an assessment applied to several rooms is matched with `assessmentEverywhere`); a
      manual `refetch()` where an invalidation belongs.
    - Every new key has a `<root>Policy` entry; `staleTime: Infinity` only when every path that
      changes the data invalidates the key (not when another user's change arrives without a
      realtime frame). A change to the global `QueryClient` defaults.
    - A realtime frame that changes cached data is mapped in `invalidationsFor`, not handled in a
      screen.
    - A key added in `react-components` comes with its sample in `samples.fixture.ts`. A key a
      consumer app needs that `bff-client` lacks is added in `react-components` first (C2), not
      defined in the app.
    - A plugin UI uses react-query only through the shared `QueryClientProvider` of its bundle and
      the keys module; no second `QueryClient`, no key defined inside a plugin.
  - Report: repeats of one pattern once, with the sites. Blocking for a missing invalidation.

- [ ] **F7. Errors in the UI**
  - Check: errors are shown only through `describeError(e, texts)` (or `describeRefusal` for an
    inline refusal) from `@biyard/plugin-host`, with a ko + en catalog typed so the two cannot
    drift (`Record<keyof typeof <en catalog>, string>`), keyed `"{service}.{code:06}"`. Never
    render `e.message`, never branch on a code, kind or message string to pick a text.
  - Report: inline. Blocking.

- [ ] **F8. Screen design** (Biyard product UI on the `@biyard/components` theme)
  - Rules: flat surfaces with no prominent borders — an edge comes from `shadow-e1` or a
    near-surface fill (`bg-muted`); a needed row divider is at most `border-border/50`; shadows
    stronger than `shadow-e1` only on floating layers (popover, dropdown, modal, sliding panel).
    No glassmorphism, neumorphism or gradients in product UI (gradients are for landing pages).
    Decoration that serves no function is removed; motion only explains a state change. Colour
    carries state only (status badges, priority, label chips, progress); a selection is a 4px
    left colour bar plus a light background, not a border highlight. Grades and levels use a
    sequential scale (one hue, lightness ramp — never red→amber→green) and always carry a text
    label; status colours differ in lightness, not only hue; a badge is a `-muted` background with
    a dark foreground and a label. Plugins use semantic tokens only, never primitives. WCAG 2.2
    AA is the floor. Information density is a requirement: what shrinks is the container around
    data, not the data. A claim links to its evidence in one click; no invented confidence
    numbers; missing evidence is drawn, and evidence and gaps rank above the verdict. Secondary
    information may be deferred, but never behind hover for irreversible, externally visible or
    destructive actions, and nothing opens by itself. Width: no global max-width on the page
    shell (tables fluid, prose and forms capped); components inside a resizable pane respond to
    container queries (`@md:`, `@lg:`), not viewport breakpoints; at most three panes. New screens
    work in both dark and light themes.
  - Report: inline, naming the rule. Design finding, not blocking.

- [ ] **F9. Type, spacing, radius and shadow scales**
  - Rules (`react-components` `eslint-rules/ui-scales.mjs`): named type roles (`text-caption`,
    `text-body-sm`, `text-base`, `text-heading-5`…`text-heading-1`, `text-display-2/1`) instead of
    arbitrary or Tailwind default sizes; font weight 400 or `font-semibold` only; radii
    `rounded-md` / `rounded-lg` / `rounded-full` only; shadows `shadow-e1`…`shadow-e5` only;
    spacing on the 4·8·12·16·24·32·48·64 scale.
  - Check only where CI does not run that rule (see "Already enforced by CI").
  - Report: one comment listing the classes and sites.

- [ ] **F10. User-facing flows**
  - Check a flow the PR adds or changes from three perspectives, in this order:
    - Information Scent (the user is acting): the next step is visible, and labels, buttons and
      titles say what is at the destination (no slogans or coined words).
    - Anticipatory Design (the system acts unasked): it can be ignored and undone; a wrong guess
      costs mild inconvenience at most; non-urgent interruptions become ordering or grouping, not
      more notifications.
    - Delegation (the user handed over a bounded task): the user sees the level (execute /
      decide / autonomous) as a dial, and has range, review and undo; confirmation is asked only
      for irreversible, externally visible or costly actions.
  - Report: a next step with no legible cue, an unasked-for action the user cannot ignore, a
    delegated action without range, review or undo. Design findings, not blocking — except an
    unasked-for action the user cannot undo, which blocks.

- [ ] **F11. Mobile web**
  - Rules: a mobile change never alters the desktop render. It is either Tailwind `max-md:`
    variants on the element (mobile is `width < 48rem`), or two complete components picked by one
    branch at the highest point they differ (`isMobile ? <FooMobile /> : <FooDesktop />`, the
    mobile one next to it as `foo-mobile.tsx`, data and logic shared).
  - Check (blocking for any change to the desktop render):
    - [ ] No unprefixed class on an existing desktop element changed or removed; no existing
      desktop component rewritten mobile-first.
    - [ ] Elements added for mobile only start `hidden` and are shown with `max-md:`.
    - [ ] A JS branch uses the app's `useIsMobile()` (`ui/hooks/use-is-mobile.ts`) with the query
      `(width < 48rem)` (not `(max-width: 768px)`), branches once, and renders two complete
      components; no `isMobile` checks inside a shared component; no new `matchMedia` call; no
      mobile-only side effect before the hook reports mobile.
    - [ ] No new `@media` rule in a stylesheet (an `@utility` applied as `max-md:<utility>`
      instead); no user-agent, `navigator`, touch or screen-size detection.
    - [ ] Touch targets ≥ 44px (`max-md:min-h-11`), text inputs ≥ 16px, no horizontal page scroll
      at 360px (wide content scrolls in its own `overflow-x-auto`), no hover-only action, safe
      areas respected on fixed bars; existing mobile primitives (`Sheet`, `Drawer` from
      `@biyard/components`) reused.
  - Report: inline, one comment per pattern.

- [ ] **F12. Generated types and versions**
  - Check: in `react-components`, the generated TypeScript paths listed in its README
    ("Generated types") change only together with `DATAROOM_REV` / `scripts/gen-types.sh`,
    never by hand. In a consumer, generated wire types are not hand-edited. Do not ask for a
    `package.json` `"version"` bump: images and bundles are versioned by CI from the commit, not by
    that field.
  - Report: inline on the hand-edited file, pointing at the generator.

- [ ] **F13. Frontend/backend naming**
  - Check: a UI file that is the counterpart of a backend type keeps the link obvious (exact name
    for a 1:1 counterpart — `FormulaSpec` ↔ `formula-spec.tsx`; enough of the name for a partial
    one — `field_schema.rs` ↔ `field-widget.tsx`, not `simple-input.tsx`). This is a naming rule,
    not a requirement to mirror backend directories.
  - Report: inline, naming the backend type to align with. Recommendation.
