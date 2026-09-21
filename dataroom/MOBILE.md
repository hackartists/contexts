# MOBILE.md

Conventions for mobile web work in Dataroom. Use this file when building a mobile layout and
when reviewing a PR that touches one. It adds to `docs/conventions/styling.md` and
`docs/conventions/ui-scales.md`; where they differ, this file wins for mobile work.

## The one rule: desktop does not change

A mobile change must leave the desktop render exactly as it was. Every mobile change uses one
of two approaches, and nothing else:

1. **Media-query variants**: the mobile difference is expressed only with Tailwind
   breakpoint variants on the element (`max-md:`).
2. **Separate components**: mobile and desktop render entirely different components, picked
   by one clear branch.

Anything that changes what a desktop viewport renders is a review finding, even if it
"looks the same".

## Breakpoint

- Mobile is `width < 48rem` (768px), which is Tailwind's `max-md:`. Desktop is `md:` and up.
- Use `max-md:` for mobile overrides. Use `max-sm:` or an arbitrary `max-[500px]:` only for
  narrower refinements inside an already mobile layout.
- A JS check must match the CSS breakpoint exactly. Use the SCS's `useIsMobile()`
  (`ui/hooks/use-is-mobile.ts`; landing and workspace still keep it in `ui/lib/`, move it
  when you touch it) and do not write a new `matchMedia` call. Its query must be
  `(width < 48rem)`. `(max-width: 768px)` also matches at exactly 768px, where Tailwind already
  renders desktop, so fix it to `(width < 48rem)` if you touch it.
- Do not detect mobile by user agent, `navigator`, touch support or screen size.

## Approach 1: media-query variants

Use this when the markup is the same and only the layout, spacing, sizing or visibility
changes.

- **Add `max-md:` classes; never edit unprefixed classes** on an existing desktop component.
  Unprefixed classes are the desktop styles. Changing, reordering the meaning of, or removing
  them changes desktop.
- Do not rewrite an existing desktop component "mobile-first" (move desktop styles behind
  `md:` and put mobile styles unprefixed). It is equivalent only in theory, and it rewrites
  every desktop class in the diff. `styling.md`'s mobile-first rule applies only to
  **new** components written for both from the start.
- Hide or show with `max-md:hidden` / `hidden max-md:flex` (or `max-md:block` and so on).
  An element added only for mobile starts `hidden` and is shown with `max-md:`, so desktop
  never renders it.
- Size values in `max-md:` still come from `ui-scales.md` (`biyard/ui-scales` applies).
- No new `@media` rules in stylesheets. If a variant cannot express it, add an `@utility`
  and apply it as `max-md:<utility>`.

```tsx
<div className="grid grid-cols-[1fr_2fr] gap-16 px-8 max-md:grid-cols-1 max-md:gap-8 max-md:px-4">
```

## Approach 2: separate components

Use this when mobile needs different markup or behaviour: a bottom sheet instead of a
dropdown, a drawer instead of a sidebar, cards instead of a table, a different flow.

- Branch **once**, at the highest point where the two differ, and render two complete
  components: `isMobile ? <FooMobile /> : <FooDesktop />`.
- The desktop component is the existing one, unchanged. Moving it into its own file or
  renaming it to `FooDesktop` is fine; changing what it renders is not.
- No `isMobile` checks sprinkled inside a shared component (`isMobile && ...`,
  `isMobile ? "a" : "b"` in `className`). That is a half-split: use variants or split fully.
- Put the mobile component next to the desktop one as `foo-mobile.tsx` (`FooMobile`), in the
  same feature module.
- Data and logic are shared, not duplicated: both components take the same props or call
  the same hook. Only presentation differs.
- `useIsMobile()` starts as `false`, so the first render is desktop. Do not run
  mobile-only side effects before the hook reports mobile.
- Reuse the existing mobile primitives (`BottomSheet` in `ui/components`) instead of building
  a new one.

```tsx
export function UserMenu(props: UserMenuProps) {
  const isMobile = useIsMobile();
  return isMobile ? <UserMenuMobile {...props} /> : <UserMenuDesktop {...props} />;
}
```

## Mobile UI rules

- Touch targets are at least 44px (`max-md:min-h-11`, `max-md:min-w-11`).
- Text inputs are at least 16px on mobile so iOS does not zoom on focus (the base styles in
  `app.css` already do this; do not override it).
- No horizontal page scroll at 360px width. Wide content (tables, code) scrolls inside its
  own `overflow-x-auto` container.
- Nothing depends on hover. Anything shown on hover on desktop has a tap equivalent on mobile.
- Respect safe areas for fixed bottom or top bars (`pb-[env(safe-area-inset-bottom)]`).
- Plugin bundles follow the same rules: a mobile change in `services/dataroom`,
  `services/assessment` or `plugins/review` UI bumps that plugin's version like any other UI
  change.

## Verifying

- Check the change at 375px (mobile) and at 1280px (desktop). The desktop view must be
  identical to `dev`.
- Playwright tests for a mobile layout set a mobile viewport explicitly and do not replace
  the existing desktop tests.

## Code review checklist

- [ ] Every mobile difference is either a `max-md:` variant or a full component split.
- [ ] No unprefixed class on an existing desktop element was changed or removed.
- [ ] No existing desktop component was rewritten mobile-first.
- [ ] Elements added for mobile only are `hidden` by default and shown with `max-md:`.
- [ ] Any JS branch uses `useIsMobile()` with `(width < 48rem)`, branches once, and renders
      two complete components; no `isMobile` checks inside a shared component.
- [ ] No new `@media` rules, no user-agent or touch detection.
- [ ] Touch targets ≥ 44px, no horizontal page scroll, no hover-only actions.
- [ ] Checked at mobile and desktop widths; desktop unchanged.
