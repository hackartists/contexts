# Data-dense enterprise design systems — 2026 reference

조사일: 2026-09-22. 캡처 방식: `npx playwright screenshot --viewport-size=1440,900 --full-page`
(내부 스크롤 컨테이너를 쓰는 사이트는 스크롤 컨테이너를 `overflow:visible`로 펼친 뒤 fullPage 캡처).
모든 PNG는 `file`로 검증됨. 실패/로그인 벽에 막힌 캡처(Tailwind Plus, Fluent 2 table)는 삭제했고 아래 "확인된 부재"에 기록.

---

## 1. Screenshots — 디자인 시스템

| Screenshot | System | URL | What it shows |
|---|---|---|---|
| `carbon_data-table-usage.png` | IBM Carbon | https://carbondesignsystem.com/components/data-table/usage/ | 5단계 row size, 정렬·배치액션·인라인 액션·zebra·확장행·AI presence 사용 규칙 |
| `carbon_data-table-style.png` | IBM Carbon | https://carbondesignsystem.com/components/data-table/style/ | row height / 타이포 토큰 / 패딩의 px+토큰 표 (가장 수치가 많은 페이지) |
| `carbon_typography.png` | IBM Carbon | https://carbondesignsystem.com/elements/typography/overview/ | productive vs expressive 타입셋, 12px 기반 스케일 공식 |
| `carbon_themes-elevation.png` | IBM Carbon | https://carbondesignsystem.com/elements/themes/overview/ | 테마·토큰·role 정의, layer 기반 깊이 모델 |
| `carbon_disclosure-pattern.png` | IBM Carbon | https://carbondesignsystem.com/patterns/disclosures-pattern/ | 점진적 공개(disclosure) 패턴 규칙 — 동시 1개, 중첩 금지 |
| `carbon_for-ai.png` | IBM Carbon | https://carbondesignsystem.com/guidelines/carbon-for-ai/ | AI label + explainability popover, AI 전용 "light-inspired" 스타일 |
| `atlassian_dynamic-table.png` | Atlassian ADS | https://atlassian.design/components/dynamic-table/examples | dynamic table 전체 예제(정렬/페이지네이션/드래그/empty view), selected state 토큰 플래그 배너 |
| `atlassian_typography.png` | Atlassian ADS | https://atlassian.design/foundations/typography | heading/body/metric/code 토큰 px+line-height 표 |
| `atlassian_elevation.png` | Atlassian ADS | https://atlassian.design/foundations/elevation | sunken/default/raised/overlay + overflow 4+1 elevation 모델 |
| `polaris-wc_table.png` | Shopify Polaris (Web Components) | https://shopify.dev/docs/api/admin-extensions/polaris-web-components/structure/table | `s-table` props — variant auto/list, loading, paginate, listSlot |
| `polaris_app-home.png` | Shopify Polaris / App Bridge | https://shopify.dev/docs/api/app-home | 앱이 iframe에 렌더되고 TitleBar/NavMenu는 호스트가 iframe 밖에 렌더 |
| `spectrum_table.png` | Adobe Spectrum | https://spectrum.adobe.com/page/table/ | 정렬 규칙, zebra 금지, 키보드 인터랙션 표, changelog |
| `spectrum_typography.png` | Adobe Spectrum | https://spectrum.adobe.com/page/typography/ | desktop/mobile 두 벌 스케일, 1.125 비율, base 14px |
| `spectrum_design-tokens.png` | Adobe Spectrum | https://spectrum.adobe.com/page/design-tokens/ | 토큰 네이밍 체계, alias 개념 |
| `fluent2_typography.png` | Microsoft Fluent 2 | https://fluent2.microsoft.design/typography | Caption2 10/14 → Display 68/92 전체 램프 |
| `fluent2_elevation.png` | Microsoft Fluent 2 | https://fluent2.microsoft.design/elevation | `$shadow2/4/8/16/28/64` (숫자=blur px), key+ambient 2겹, 컬러면 휘도 보정식 |
| `fluent2_list-usage.png` | Microsoft Fluent 2 | https://fluent2.microsoft.design/components/web/react/core/list/usage | Fluent 2가 공개 문서화한 유일한 "여러 행" 컴포넌트 |
| `baseweb_table-semantic.png` | Base Web (Uber) | https://baseweb.design/components/table-semantic/ | `size` compact/default/spacious, `divider` horizontal/vertical/grid/clean |
| `baseweb_table-grid.png` | Base Web (Uber) | https://baseweb.design/components/table-grid/ | CSS-grid 기반 대용량 테이블(가상 스크롤) |
| `primer_data-table.png` | GitHub Primer | https://primer.style/product/components/data-table/ | `cellPadding` condensed/normal/spacious, 컬럼 width/minWidth/maxWidth, 로딩·빈 상태 |
| `primer_typography-primitives.png` | GitHub Primer | https://primer.style/foundations/primitives/typography | body/caption/title CSS 변수 실제 값 |
| `primer_size-primitives.png` | GitHub Primer | https://primer.style/foundations/primitives/size | `--base-size-*` 4px 기반 사이즈 프리미티브 |
| `shadcn_data-table.png` | shadcn/ui | https://ui.shadcn.com/docs/components/data-table | TanStack Table 레시피 — 정렬/필터/컬럼 visibility/행 선택 전체 코드 |
| `radix-themes_table.png` | Radix Themes | https://www.radix-ui.com/themes/docs/components/table | `size` 1/2/3, `variant` surface/ghost |
| `radix_text.png` | Radix Themes | https://www.radix-ui.com/themes/docs/components/text | 9단계 타입 스케일 실물 |
| `tailwindcss-v4_font-size.png` | Tailwind CSS v4 | https://tailwindcss.com/docs/font-size | `--text-*` + `--text-*--line-height` 페어링 토큰 구조 |

## 1-b. Screenshots — 레이아웃 / 가로 폭

| Screenshot | System | URL | What it shows |
|---|---|---|---|
| `carbon_2x-grid.png` | IBM Carbon | https://carbondesignsystem.com/elements/2x-grid/overview/ | 브레이크포인트 표(320/672/1056/1312/1584), 마진·거터, screen region별 width 정책, 패널 3종 동작 |
| `primer_page-layout.png` | GitHub Primer | https://primer.style/product/components/page-layout/ | `containerWidth`, `PageLayout.Pane` width/minWidth/resizable/sticky props 전체 |
| `atlassian_page-layout.png` | Atlassian ADS | https://atlassian.design/components/page-layout/examples | TopNavigation/LeftSidebar/Main/RightSidebar/RightPanel 슬롯 구조, `isMainExtraWide` 토글 |
| `atlassian_page-layout-usage.png` | Atlassian ADS | https://atlassian.design/components/page-layout/usage | 사이드바 리사이즈/접기로 작업 공간을 넓히라는 가이드 |
| `atlassian_side-navigation.png` | Atlassian ADS | https://atlassian.design/components/side-navigation/examples | 사이드 내비 최소 폭 240px, 중첩 내비 |
| `fluent2_layout.png` | Microsoft Fluent 2 | https://fluent2.microsoft.design/layout | 12컬럼 그리드, manuscript/column/modular 그리드, size class 표(xxx-large 1920+), reflow 기법 |
| `radix-themes_container.png` | Radix Themes | https://www.radix-ui.com/themes/docs/components/container | `--container-1…4` = 448 / 688 / 880 / 1136px |

## 2. Screenshots — 플러그인 셸 (추가 스코프)

| Screenshot | System | URL | What it shows |
|---|---|---|---|
| `vscode_ux-guidelines-overview.png` | VS Code | https://code.visualstudio.com/api/ux-guidelines/overview | containers/items UI 아키텍처 — 확장이 기여할 수 있는 지점 전체 지도 |
| `vscode_ux-activity-bar.png` | VS Code | https://code.visualstudio.com/api/ux-guidelines/activity-bar | Activity Bar Do/Don't (아이콘 스타일 일치, 중복 금지) |
| `vscode_ux-sidebars.png` | VS Code | https://code.visualstudio.com/api/ux-guidelines/sidebars | View Container 개수 제한 규칙 (1개 권장, View 3–5개 max) |
| `vscode_webview-guide.png` | VS Code | https://code.visualstudio.com/api/extension-guides/webview | `--vscode-*` CSS 변수, body 테마 클래스, `vscode-reduce-motion` 등 |
| `vscode_theme-color-tokens.png` | VS Code | https://code.visualstudio.com/api/references/theme-color | 확장이 쓸 수 있는 전체 테마 컬러 토큰 레퍼런스 |
| `backstage_ui.png` | Backstage (Spotify) | https://ui.backstage.io/ | Backstage UI(BUI) v0.18.0 컴포넌트 목록 — `PluginHeader` 포함 |
| `backstage-ui_plugin-header.png` | Backstage | https://ui.backstage.io/components/plugin-header | 호스트가 제공하는 플러그인 페이지 프레임(icon/title/titleLink/tabs/actions) |
| `backstage_frontend-extensions.png` | Backstage | https://backstage.io/docs/frontend-system/architecture/extensions | extension id/attachTo/inputs/outputs, `if` predicate(권한·플래그) |
| `backstage_routes.png` | Backstage | https://backstage.io/docs/frontend-system/architecture/routes | RouteRef / ExternalRouteRef / route binding — 플러그인 경계 넘는 내비 |
| `backstage_fs-plugins.png` | Backstage | https://backstage.io/docs/frontend-system/architecture/plugins | 플러그인 정의와 routes 노출 |
| `backstage_plugins.png` | Backstage | https://backstage.io/docs/plugins/ | "stringent design guidelines" 선언 (legacy 문서) |
| `forge_design-tokens-theming.png` | Atlassian Forge | https://developer.atlassian.com/platform/forge/design-tokens-and-theming/ | `view.theme.enable()`, `html[data-color-mode]`, `utility.elevation.surface.current` |
| `forge_custom-ui.png` | Atlassian Forge | https://developer.atlassian.com/platform/forge/custom-ui/ | iframe 기반 서드파티 UI의 제약 |
| `forge_ui-kit.png` | Atlassian Forge | https://developer.atlassian.com/platform/forge/ui-kit/ | UI Kit 개요 (호스트 렌더링 컴포넌트) |
| `forge_ui-kit-components.png` | Atlassian Forge | https://developer.atlassian.com/platform/forge/ui-kit/components/ | 서드파티에게 허용된 컴포넌트 allowlist |
| `forge_user-interface.png` | Atlassian Forge | https://developer.atlassian.com/platform/forge/user-interface/ | UI Kit vs Custom UI 선택 기준 |
| `grafana_plugin-best-practices.png` | Grafana | https://grafana.com/developers/plugin-tools/key-concepts/best-practices | "never hardcode colors/spacing/font sizes", `useStyles2`, global style 금지 |
| `grafana_plugin-tools.png` | Grafana | https://grafana.com/developers/plugin-tools/ | 플러그인 타입(panel/datasource/app)과 UI extensions |
| `figma_plugin-design-guidelines.png` | Figma | https://help.figma.com/hc/en-us/articles/360039958914-Plugin-design-guidelines | 리뷰 게이트 방식 — "highly recommend matching your plugin to Figma's UI" |

---

## 패턴 정리

### A. Density — 명시적 밀도 모드가 있는가

| 시스템 | 밀도 API | 문서화된 실제 수치 |
|---|---|---|
| **IBM Carbon** | row size 5단계 (컴포넌트 prop) | **xs 24px / sm 32px / md 40px / lg 48px / xl 64px**. xl은 `padding-top: 16px` 오프셋, 2줄 콘텐츠일 때만 권장. 툴바/배치액션바는 **48px(lg·xl용)과 32px(sm·xs용) 2종만** 존재하고 row size와 강제 페어링 |
| **GitHub Primer** | `cellPadding: 'condensed' \| 'normal' \| 'spacious'` | px 미공개. 의도만 명시 — condensed="maximizes data visibility in a small area", spacious="enhances readability for dense or complex content" |
| **Base Web (Uber)** | `size: 'compact' \| 'default' \| 'spacious'` | px 미공개 |
| **React Spectrum** | `density: 'compact' \| 'regular' \| 'spacious'` (default `regular`) — "sets the amount of vertical padding within each cell". 별도로 `overflowMode: 'wrap' \| 'truncate'` (default `truncate`) | px 미공개 |
| **Radix Themes** | `Table.Root size="1|2|3"` — "controls how large the text and padding of the table cells should be" | px 미공개 |
| **Adobe Spectrum (디자인 문서)** | 밀도 모드 **없음**. 대신 **platform scale** desktop/mobile 2벌, **1:1.25 비율** (모바일이 25% 큼) | base font 14px(desktop) / 17px(mobile) |
| **Atlassian ADS** | dynamic table에 밀도 prop **없음** | — |
| **Microsoft Fluent 2** | 공개 디자인 사이트에 Table/DataGrid 문서가 **아예 없음** (컴포넌트 목록에 없음). DataGrid는 react.fluentui.dev Storybook에만 존재 | — |
| **shadcn/ui** | 밀도 모드 **없음**. data-table은 TanStack Table 레시피이고 셀 패딩은 직접 작성 | — |

**핵심**: 밀도를 "테마 전역 모드"로 두는 시스템은 없다. 전부 **테이블 컴포넌트의 prop**이다. 그리고 실제 px를 공개한 건 Carbon뿐이다.

### B. Typography scale — 밀집 읽기용

| 시스템 | 본문 기본 | 보조/캡션 | 비고 |
|---|---|---|---|
| **Carbon** | `$body-compact-01` = **14px / weight 400** (테이블 행 텍스트) | 컬럼 헤더 `$heading-compact-01` = **14px / 600** | 테이블 제목 `$heading-03` = 20px/400. 스케일 공식 `Xn = Xn-1 + {INT[(n-2)/4]+1}*2`, y₀=12px → 12·14·16·18·20·24·28·32… |
| **Atlassian** | `font.body` = **14px / 20px**, Regular | `font.body.small` = 12px/16px, `font.body.large` = 16px/24px | heading 7단계 전부 Bold: xxsmall 12/16 → xxlarge 32/36. **paragraph spacing이 토큰에 포함** (body 12px, large 16px, small 8px). font.code = 12px/20px |
| **Fluent 2** | `Body 1` = **14px / 20px** | `Caption 1` 12/16, `Caption 2` 10/14 | Subtitle2 16/22, Subtitle1 20/26, Title3 24/32. 각 사이즈마다 Regular/Semibold/Bold 3벌(`Strong`/`Stronger`) |
| **Primer** | `--text-body-size-medium` = **0.875rem(14px), line-height 1.5** | body-small 12px/1.625, caption 12px/1.25 w400 | body-large 16px/1.5. 사이즈 프리미티브는 `--base-size-4…48` 4px 기반 |
| **Radix Themes** | 9단계 스케일, step2 = **14px / 20px** | step1 12/16 | 3=16/24, 4=18/26, 5=20/28, 6=24/30, 7=28/36, 8=35/40, 9=60/60. 각 step에 letter-spacing까지 묶여 있음 |
| **Spectrum** | base **14px(desktop)**, 비율 **1.125 (major second)** | font-size-75 12px, font-size-50 11px | 100=14, 200=16, 300=18, 400=20, 500=22, 600=25 |
| **Tailwind v4** | `--text-sm` = 0.875rem, line-height `calc(1.25 / 0.875)` = **14px/20px** | `--text-xs` 12px, lh `calc(1/0.75)` = 16px | v4는 `--text-*`와 `--text-*--line-height`를 **한 쌍으로 묶은 토큰**이라 Atlassian/Radix식 "사이즈+행간 세트" 구조와 동일 |

**핵심**: 이 시스템들이 전부 **14px/20px(=1.43)을 dense 제품 본문 기본값**으로 수렴했다. 16px은 "long-form 읽기용"으로 따로 분리돼 있다(Atlassian "Body L is the default size for long-form content", Carbon expressive 타입셋). 스텝 수는 7–9단계.

### C. Hierarchy without size — 전부 작아야 할 때 레벨을 가르는 법

1. **Weight, not size.** Carbon 데이터 테이블은 컬럼 헤더와 행 텍스트가 **둘 다 14px**이고, 차이는 **600 vs 400 뿐**이다. Fluent 2는 아예 모든 사이즈에 `Strong`(Semibold)·`Stronger`(Bold) 변형을 토큰화했다.
2. **Atlassian의 weight 사용 규칙**(직접 명시): Regular = 일반 문단, **Medium = "alignment with iconography… use this weight in most components and whenever text could be seen beside line icons"**, Bold = "use this weight sparingly".
3. **Heading 스타일을 쓰고 bold/사이즈 변경으로 흉내내지 말 것.** Atlassian: "Use heading styles, rather than bold or a change of font size, as they're important for accessibility."
4. **Surface tint(배경)로 레벨 구분** — Carbon의 `$layer-01/02/03`, Atlassian의 `elevation.surface.sunken`. Atlassian은 sunken과 `color.background.neutral`을 명확히 구분한다: sunken은 **불투명(opaque)**이라 라이트/다크 둘 다 어두워지고, `color.background.neutral`은 **투명**이라 라이트에선 어두워지고 다크에선 밝아진다 → 중첩 surface 위에 얹을 땐 후자를 써야 한다.
5. **Divider > zebra.** Spectrum: **"Don't use zebra stripes… Both standard and quiet tables already have row dividers… Don't customize the background color of alternating rows."** 반대로 Carbon은 zebra를 옵션 modifier로 허용("to make scanning horizontal information easier"). Base Web은 `divider: horizontal | vertical | grid | clean` 4모드로 노출. **Spectrum과 Base Web이 divider를 1차 수단으로 두고, zebra는 Carbon만 허용한다.**
6. **Column divider는 아껴서** — Spectrum: "Use column dividers sparingly… don't add them to every column."
7. **Quiet variant** — Spectrum의 standard vs quiet: 테이블이 화면의 주인공이 아니면 quiet(배경·보더 제거). Radix Themes의 `variant="ghost"`(기본값) vs `"surface"`가 정확히 같은 개념 — surface는 "visually enclosed backplate"를 추가.

### D. Depth in 2026 — elevation 토큰과 glass

**shadow 토큰이 실제로 몇 단계인가:**

- **Fluent 2**: `$shadow2 / $shadow4 / $shadow8 / $shadow16 / $shadow28 / $shadow64` — **숫자가 blur px 값 그대로**. low elevation ramp(2/4/8/16)와 high elevation ramp(28/64)로 나뉜다. 각 그림자는 **key(sharp, directional) + ambient(soft, diffused)를 겹쳐서** 만든다. low ramp 기준 opacity 14%, high ramp에서 24%/28%. $shadow28 = "bottom sheet, side navigation, raised tab bars", $shadow64 = "pop-up dialogs". Windows는 key shadow 대신 **stroke**를 쓴다.
- **Fluent 2 컬러면 보정**: 브랜드 컬러 위에서는 같은 그림자가 같은 깊이로 안 보이므로 휘도식을 쓴다 — `luminosity = 0.2126R + 0.7152G + 0.0722B`, `shadow1 opacity = Round(42 − 0.116·lum)`, `shadow2 opacity = Round(34 − 0.09·lum)`. **"Don't use the main shadow ramp on colored surfaces."**
- **Atlassian**: **4단계 + 1** — `sunken / default / raised / overlay` + `overflow`. 그림자는 상위 2단계에만 붙는다: `elevation.surface.raised`는 **항상** `elevation.shadow.raised`와, `elevation.surface.overlay`는 **항상** `elevation.shadow.overlay`와 페어링. `elevation.shadow.overflow`는 스크롤로 내용이 잘렸음을 알리는 전용 그림자(수평 스크롤 테이블에 사용), box-shadow가 안 되면 `.overflow.spread` + `.overflow.perimeter` 조합으로 대체.
- **Atlassian 다크모드 규칙**: "Shadows can be harder to see in dark mode, so dark mode elevations also rely on **different surface colors**… the higher the elevation, the lighter the surface looks." → **다크에서는 그림자가 아니라 surface 밝기가 주 신호.**
- **Atlassian의 elevation 억제 규칙**: raised는 "reserved for cards that can be moved"(Jira/Trello 카드). "Raised elevations can create visual noise, so **don't use to group content when a border or white space would suffice**." sunken은 default 위에만, raised/overlay 위에는 금지.
- **IBM Carbon**: 데이터 테이블 style 문서에 **shadow 토큰이 없다.** Carbon의 깊이는 `$layer-01/02/03` 계열의 **배경 토큰(layer)** 으로 표현되고, 테마는 White/Gray10/Gray90/Gray100 4개. 즉 dense product UI에서 그림자를 거의 안 쓴다.
- **Glass/translucency**: 조사한 10개 디자인 시스템 중 **glass·translucency·blur를 토큰이나 가이드로 문서화한 곳은 없었다.** Apple Liquid Glass에 대응하는 공식 패턴을 추가한 시스템을 확인하지 못했다. 가장 근접한 것이 Carbon for AI인데, 이것도 유리가 아니라 **"light-inspired effects like brightness, glow, and gradients"**로 AI 존재를 표시하는 용도다. 대비 가이드는 별도로 제시되지 않았다.

### E. Tables — 구체적 기능 문서화 현황

| 기능 | 누가 뭐라고 |
|---|---|
| **Sticky header** | Polaris `s-table`에 sticky header 예제 존재. Carbon/Atlassian/Spectrum 디자인 문서에는 sticky header에 대한 별도 가이드 없음 |
| **컬럼 리사이즈** | 디자인 문서 레벨에서 리사이즈를 정식 문서화한 곳 없음. Primer는 대신 **컬럼별 `width` / `minWidth` / `maxWidth` + grow / growCollapse** 선언 방식 (`grow w/ 200px max`, `growCollapse w/ 100px min`) |
| **행 선택** | Carbon: 단일=radio, 다중=checkbox, **체크박스 20×20px, 좌우 padding 16px(`$spacing-05`)**. 선택되면 상단에 batch action bar가 뜨고 **배치 모드 동안 행의 단일 액션·오버플로 메뉴는 disabled 처리**. Spectrum: 체크박스는 테이블 왼쪽 |
| **인라인 액션** | Carbon: 행마다 오버플로 메뉴. **"오버플로 메뉴 항목이 3개 미만이면 메뉴 대신 인라인 아이콘 버튼으로"** — 클릭 1회 절약 + 가시성 |
| **툴바 액션 개수** | Carbon: **"Include up to five actions within the table toolbar"**, 그 이상은 오버플로/콤보 버튼 |
| **Zebra vs divider** | Spectrum 금지 / Carbon 옵션 허용 / Base Web 4모드(`horizontal`, `vertical`, `grid`, `clean`) |
| **정렬** | Carbon: 3상태(unsorted / sorted-up / sorted-down). **정렬된 컬럼만 아이콘 표시, unsorted 아이콘은 hover에서만 노출** |
| **Empty state** | Atlassian: `emptyView` prop. **"If there's an action that people must take to create or show table content, add this to the empty state"**. Base Web: `emptyMessage` / `loadingMessage` / `isLoading` |
| **로딩** | Polaris `s-table`의 `loading` — "the table might be in an **inert** state that prevents user interaction" (오버레이 + 상호작용 차단). Primer도 로딩 상태 문서화 |
| **긴 헤더 텍스트** | Carbon: **"wrap the text to two lines and then truncate the rest. The full text should be shown in a tooltip on hover."** |
| **정렬 규칙** | Spectrum: 텍스트 좌측 정렬(**"Never use center alignment"**), 숫자 우측 정렬 — 단 ZIP/IP/전화번호 같은 nominal number는 좌측. 컬럼 헤더는 데이터 정렬을 따라감. **숫자는 tabular + lining 숫자 사용**. 결측값은 **en dash(–)** |
| **테이블 배치** | Carbon: **"Avoid placing data tables inside data tables or smaller containers where the information can feel cramped or needs truncation."** |
| **대용량** | Base Web: "For larger amounts of information, browser rendering performance can suffer and you should use the **virtualized scrolling** features of the div-based table or table-grid components." → semantic `<table>`은 대용량에 쓰지 말라는 뜻 |
| **반응형 축약** | Polaris `s-table`의 `variant: auto | list` + 헤더별 `listSlot: primary | secondary | inline | labeled` — **좁은 화면에서 테이블이 리스트로 변형되고, 각 컬럼이 리스트 아이템의 어느 슬롯으로 갈지 컬럼 선언에 미리 박아둔다.** 반응형 테이블 문제에 대해 조사한 것 중 가장 구조적인 해법 |

### F. Split view / side panel

**솔직하게: "reading pane + context pane" 를 정식 패턴으로 문서화한 곳은 이 중 없었다.** 가장 가까운 것들:

- **VS Code**가 유일하게 공간 모델을 문서화한다 — Activity Bar(내비) / Primary Sidebar(뷰 컨테이너) / Editor(본문) / Secondary Sidebar(보조 컨텍스트) / Panel(하단) / Status Bar. Secondary Sidebar는 **"auxiliary location for Views"** 이고, 확장이 직접 기여할 수 없고 **사용자가 Primary Sidebar나 Panel에서 드래그해 옮겨야** 생긴다.
- **Carbon의 확장 행(expandable row)** 이 인라인 컨텍스트 패널 역할: expanded panel은 `padding-top/right: 16px`, **`padding-left: 48px`(`$spacing-09`)**, `padding-bottom: 24px`. 왼쪽 48px 들여쓰기가 "이건 위 행에 종속된 내용"이라는 계층 신호다.
- **Carbon의 batch expansion 경고**: 전체 펼치기 chevron은 기본 비노출. "Keeping detailed information in the expanded section saves user loading time by postponing some data queries until needed. **Expanding all rows at once will typically negate this advantage.**"

### G. Disclosure — 밀집 화면에서의 점진적 공개

Carbon의 disclosure 패턴이 가장 구체적이고, 규칙이 전부 "쓰지 마라" 쪽이다:

- 툴팁과 달리 **인터랙티브 요소를 담을 수 있을 때만** 쓴다.
- 폭은 **6 컬럼 이하**. "Don't use if the popover needs to have a width larger than six columns."
- **항상 사용자 트리거.** "Disclosures should never open automatically."
- **동시에 하나만 열린다.** "only one should open at a time to avoid screen clutter."
- **중첩 금지.** "Do not nest one disclosure within another disclosure." (context menu의 submenu는 예외로 허용)
- **중요 정보를 숨기지 말 것.** "Do not hide important information inside of a disclosure that the user may need in order to complete a task."
- 닫기: 트리거 재클릭 / 바깥 클릭 / Esc / Tab out. 닫기 X 아이콘은 **항상 우상단**.

### H. Accessibility — 실제 명시된 수치

- **GitHub Primer**: **"GitHub aims for Web Content Accessibility Guidelines (WCAG) 2.2 AA conformance. This includes all of WCAG 2.1 AA (with the exception of 4.1.1 Parsing, which was removed) plus additional considerations."** → 조사 대상 중 **WCAG 2.2 AA를 명시한 유일한 시스템**. 같은 문서에서 Section 508은 여전히 WCAG 2.0 AA 기준임을 언급.
- **IBM Carbon**: "Carbon color themes strive to comply with the **WCAG 2.1 AA** guidelines for contrast." (2.2 아님). 컴포넌트는 IBM Accessibility Checklist(WCAG AA + Section 508 + EU 표준) 기준.
- **Atlassian**: **"Use a color contrast ratio of 4.5:1 for regular text and 3:1 for large text and graphics."** 색만으로 의미 전달 금지.
- **타깃 사이즈**: WCAG 2.2의 2.5.8 Target Size(Minimum) 24×24 CSS px를 명시적으로 인용한 페이지는 확인하지 못했다. 다만 Carbon은 chevron **click target 32px**(아이콘 svg는 16px)을 문서화 — 24px 기준은 충족.
- **VS Code webview**는 접근성 신호를 body 클래스로 내려준다: `vscode-high-contrast`(테마 카테고리), **`vscode-using-screen-reader`**, **`vscode-reduce-motion`**. "always test your webview in high-contrast mode."
- **Spectrum**은 테이블 키보드 인터랙션을 전체 표로 문서화(방향키 셀 이동, Home/End 행 처음·끝, PageUp/Down 뷰포트 단위, Ctrl/Cmd+Home/End 전체 처음·끝). 밀집 테이블에서 이게 사실상 접근성의 본체.

### I. 2026 변화 — 날짜를 확인한 것만

- **IBM Carbon**: 사이트에 **"The Carbon site has been redesigned. Explore the preview site"** 배너. 모든 페이지 푸터 **"Last updated 09 September 2026 / Copyright © 2026 IBM"**, React Components `^1.115.0`. → **2026년 사이트 리디자인 진행 중**.
- **IBM Carbon**: data-table usage 페이지 상단 공지 — **"Data table with AI label is now stable. This addition changes the visual appearance of the component and introduces an AI explainability feature when AI is present in the component."** (배너에 연/월 표기는 없음, 현재 사이트 기준 stable). 관련해 **"AI slug"가 "AI label"로 리네이밍**됨이 별도 명시.
- **Shopify Polaris**: **Polaris Web Components가 2025년 10월 1일 GA**(파트너 블로그 "Published on Oct 1, 2025"). `polaris.shopify.com`과 `polaris-react.shopify.com`은 이제 **`shopify.dev/docs/api/polaris`로 리다이렉트**되고, Polaris React 리포지토리는 `Shopify/polaris-react-archive` (Deprecated)로 이동. App Home용 web component 라이브러리는 **버전 1.0이 stable, 1.1이 RC**. → **React 구현체를 버리고 프레임워크 중립 web component로 간 것이 확인된 가장 큰 구조 변화.** (검색 결과에는 "2026년 9월 15일부터 Shopify admin 새 비주얼 롤아웃"이라는 주장이 있었으나 **날짜가 적힌 1차 페이지를 직접 확인하지 못했으므로 2026년 변경으로 단정하지 않는다.**)
- **Atlassian ADS**: dynamic table 페이지 상단 배너 — **"Neutral selected states: When the `platform-dst-tokens-finesse` feature flag is enabled, this component uses the new neutral treatment for selected states."** → 선택 행의 색을 브랜드 블루에서 **중립색으로 바꾸는 작업이 feature flag 뒤에서 진행 중**. (배너에 날짜 없음. 사이트 푸터는 © 2026 Atlassian.)
- **VS Code**: UX Guidelines 페이지 갱신일 **9/16/2026**.
- **Backstage**: `ui.backstage.io`의 **Backstage UI (BUI) v0.18.0** — Table, PluginHeader 포함한 독자 컴포넌트 라이브러리. 기존 plugin 문서는 **"Plugins (Legacy) / LEGACY DOCUMENTATION"** 으로 강등되고 new frontend system이 정식. (버전 표기는 확인, 릴리즈 날짜는 페이지에 없음.)
- **Adobe Spectrum**: Table 컴포넌트 changelog의 **마지막 항목이 2022년 6월 8일 (6.0.1)**. **2026년 변경 없음** — Spectrum 2는 별도 사이트로 갈라져 있고 이 페이지는 갱신되지 않았다.

---

## 플러그인 셸 패턴

### 1. 호스트는 어떻게 플러그인이 "남의 것처럼" 보이는 걸 막는가 — 실제 메커니즘

네 가지 층위가 실제로 쓰이고 있고, 강제력이 다르다.

**(a) 토큰만 허용 + 하드코딩 금지 (가장 강한 실무 규칙) — Grafana**
> "**Never hardcode visual properties like colors, spacing, padding, or font sizes.** Use the `useTheme2()` hook from `@grafana/ui` to access design tokens (for example, `theme.spacing(2)`, `theme.colors.primary.main`)."
> "Always use components from `@grafana/ui`… This ensures a consistent UI experience across Grafana and **helps prevent UI breakages as Grafana evolves**."
> "**Never use global styles as they can cause breakages as Grafana evolves.**" (커스텀 스타일은 Emotion `@emotion/css` + `useStyles2` 훅으로만)

**(b) 호스트가 테마를 iframe 안으로 주입 + 플러그인은 읽기만 — Atlassian Forge**
- `view.theme.enable()` 호출 → "This will fetch the current active theme from the host environment (example, Jira) and apply it in your app. It will also **reactively apply theme changes** that occur in the host environment so that your app and the host are always in sync."
- 호스트가 `<html data-color-mode="dark" data-theme="dark:dark light:light">` 를 세팅. **플러그인이 읽어도 되는 건 `data-color-mode`뿐이고 `data-theme`은 "internal behavior and should not be read or modified in any way"** 로 명시적으로 금지.
- 결정적 토큰: **`utility.elevation.surface.current`** — "In some scenarios you may find that the background color of the element your application is rendered on does not match or differs between different locations and themes. For example, if your app is rendered inside of a modal or elevated card." → **플러그인이 "지금 내가 어떤 surface 위에 얹혀 있는지"를 토큰 하나로 알 수 있게 한 것.** 이게 플러그인 셸에서 배경색 불일치를 없애는 핵심 장치다.
- 토큰 수명주기까지 계약화: **active → deprecated(minor) → soft-deleted(다음 minor, 동작하지만 에러 발생) → deleted(다음 major).**
- 자체 브랜드 색이 필요하면 `html[data-color-mode]`를 쿼리해 자기 토큰을 스위칭하라고 허용 — 즉 **브랜드 색은 허용하되 모드 동기화는 강제.**

**(c) 컴포넌트 allowlist + 호스트 렌더링 — Forge UI Kit / Shopify App Bridge**
- Forge UI Kit: 서드파티는 허용된 컴포넌트 목록 안에서만 UI를 조립한다(호스트가 렌더). Custom UI(iframe, 임의 HTML)는 별도 트랙으로 분리하고 거기에만 위 (b)의 테마 opt-in API를 준다. **"자유롭게 그릴 수 있는 트랙"과 "절대 안 틀어지는 트랙"을 아예 두 개로 나눈 구조.**
- Shopify: 앱은 iframe 안에 렌더되지만, **`TitleBar`와 `NavMenu`는 앱이 선언하되 호스트가 iframe 밖에 그린다** — "Use App Bridge web components to add UI elements like title bars and navigation menus to Shopify admin **outside your app's iframe**."

**(d) CSS 변수 노출 + 리뷰 게이트 — VS Code / Figma**
- VS Code webview: body에 `vscode-light` / `vscode-dark` / `vscode-high-contrast` 클래스가 붙고, 모든 테마 색을 `var(--vscode-editor-foreground)` 형식(= `editor.foreground` 토큰의 `.`를 `-`로 치환)으로 접근. 폰트까지 내려준다 — `--vscode-editor-font-family / -font-weight / -font-size`. 강제는 아니지만 **"A poorly designed webview can also easily feel out of place within VS Code"** 라고 경고하고, webview 자체를 **"should also be used sparingly and only when VS Code's native API is inadequate"** 로 억제한다.
- Figma는 가장 약한 쪽: **"We highly recommend matching your plugin or widget to Figma's UI so we can create a seamless experience"** — 권고 + 사람이 심사하는 리뷰 게이트(거절 사유에 "usability… or any other negative externalities" 포함)만 있고 토큰 계약이 없다. 대신 Figma는 플러그인을 **모달/사이드 패널에 격리**해서 "남의 UI"임을 시각적으로 인정해버린다. 우리처럼 플러그인이 본문 전체를 차지하는 구조에서는 이 방식은 쓸 수 없다.

### 2. 내비게이션이 가변일 때(역할/설치에 따라 보이는 플러그인이 다름) 공간 모델을 어떻게 유지하는가

- **VS Code**: Activity Bar가 **불변의 좌측 아이콘 레일**이고, 확장은 거기에 View Container를 붙인다. 규칙이 명시적이다 — **"Use an excessive number of View Containers"는 Don't, "A single View Container … is generally enough for most extensions"**, View는 **"3-5 is a comfortable max"**. 아이콘은 **"Use an icon that matches the default Activity Bar item icon style"**, **"Duplicate an existing icon"은 금지**. 즉 **레일의 위치는 고정, 슬롯 개수는 플러그인당 1개로 제한**해서 항목이 늘거나 줄어도 공간 기억이 깨지지 않게 한다.
- **VS Code의 두 번째 장치**: 내비에서 못 찾아도 **Command Palette가 전역 검색 폴백**이다. 사이드바 가이드에서도 **"Add content to the Sidebar that could be a simple Command"는 Don't** — 즉 가벼운 기능은 아예 내비에 자리를 주지 말고 커맨드로 두라는 것.
- **Backstage**: 확장이 **`if` predicate**로 조건부 설치된다. "The predicate uses the same FilterPredicate syntax… evaluated against app-level data such as **featureFlags and permissions**." 단, 중요한 제약이 문서에 명시돼 있다 — **"Conditions are evaluated when the app tree is prepared, not continuously while the app is running. If the underlying feature flags or permissions change, the app needs to be prepared again… which in practice typically means reloading the app."**
- **Backstage의 순서 문제**: **"When an extension is toggled from disabled to enabled through configuration it resets the ordering of the extension, pushing it to the end of the list."** 그래서 순서가 중요하면 **기본 disabled로 두고 활성화 순서로 배치 순서를 결정**하라고 권한다. → 가변 내비의 순서는 "설치 순"이 아니라 **명시적 order 값**으로 잡아야 한다는 교훈.
- **신규 플러그인 발견성**: VS Code는 **Walkthroughs**(확장 전용 다단계 온보딩)를 정식 UX 가이드라인 항목으로 둔다. Backstage UI는 `PluginHeader`가 `icon` + `title` + tabs를 강제해 **어느 플러그인 안에 있는지 항상 표시**한다. 그 외에 "새로 쓸 수 있게 된 플러그인을 알려주는 표준 서피스"를 문서화한 시스템은 없었다.

### 3. 작업 중 플러그인 경계를 넘을 때 — 알려주는가, 매끄럽게 하는가

- **Backstage가 이 문제를 정면으로 다룬 유일한 케이스**이고, 답은 **"경로는 감추고 전환은 티 안 나게, 대신 링크 자체를 간접화한다"** 이다.
  - "Each Backstage plugin is an isolated piece of functionality that **doesn't typically communicate directly with other plugins**."
  - "The Backstage routing system makes it possible to implement **navigation across plugin boundaries, without each individual plugin knowing the concrete path or location of other plugins** in the routing hierarchy, or even its own."
  - 자기 페이지는 `createRouteRef()` → 플러그인의 `routes`로 노출. **남의 플러그인으로 가려면 `createExternalRouteRef()`** 를 만들고, 실제 대상은 **앱 레벨의 route binding**이 정한다. "We don't want to reference the Scaffolder plugin directly, since that would create an unnecessary dependency."
  - 결정적으로: **`useRouteRef`는 대상이 없으면 `undefined`를 반환한다** — "First we need to check whether the route is available, the link generator function will be undefined if it isn't." → **권한/설치 때문에 대상 플러그인이 없을 때 링크를 그냥 안 그리는 게 표준 동작.**
- **시각적으로 알리는 쪽**: Backstage UI의 `PluginHeader`(icon + title + titleLink + tabs)가 매 플러그인 페이지 상단에 붙으므로, **경계를 넘으면 헤더의 아이콘·이름·탭 세트가 통째로 바뀌는 것이 곧 전환 신호**다. Shopify의 `TitleBar`(title + subtitle)도 같은 역할을 호스트 크롬에서 수행.
- **명시적으로 "이동했습니다" 배너를 권하는 가이드라인은 어디에도 없었다.** 공통 답은 "전환 자체는 seamless, 대신 **페이지 프레임이 정체성을 항상 표시**한다"이다.

### 4. 호스트가 소유하는 것 vs 플러그인이 소유하는 것 — published 가이드라인의 경계선

| 요소 | 호스트 | 플러그인 | 근거 |
|---|---|---|---|
| 내비게이션 레일 / 런처 | **호스트** | 항목만 기여 | VS Code: 확장은 Activity Bar에 View Container를 *contribute* |
| 페이지 프레임 / 타이틀 / 탭 | **호스트** | 값만 선언 | Backstage `PluginHeader`(@backstage/ui), Shopify `TitleBar`+`NavMenu` — "rendered **outside your app's iframe**" |
| 라우팅 경로 | **호스트(integrator)** | RouteRef만 선언 | Backstage: "paths are configurable, so app integrators can set a custom path to a route whenever they like" |
| 테마 / 컬러모드 | **호스트** | 읽기만, 수정 금지 | Forge `data-theme`은 "should not be read or modified in any way" |
| 토스트 / 모달 | **호스트 API 경유** | 호출만 | Shopify: "give merchants feedback through **toasts and modals**" via App Bridge `shopify` global |
| 컨텐츠 영역 | | **플러그인** | VS Code Editor/Views, Forge Custom UI iframe |
| 빈 상태 / 로딩 | | **플러그인** (컴포넌트는 호스트 제공) | Atlassian `emptyView` prop, Base Web `emptyMessage`/`loadingMessage`, Polaris `loading` |
| 컨텍스트 메뉴 | **호스트** | 항목 기여 | VS Code Context Menus + `data-vscode-context` 속성으로 webview 내부도 호스트 메뉴에 편입 |

### 5. 플러그인 간 밀도/타입스케일 일관성을 강제하는가

**솔직한 답: 밀도를 명시적으로 강제하는 플러그인 셸은 하나도 없었다.** 강제되는 건 "토큰을 써라"까지고, 밀도는 그 토큰 안에 암묵적으로 들어 있다.

- **Grafana가 가장 가깝다**: spacing과 font size의 하드코딩 자체를 금지(`theme.spacing(2)` 강제)하므로 **간격 값이 토큰 세트 밖으로 못 나간다**. 결과적으로 밀도가 수렴한다. 하지만 "compact/comfortable 모드" 같은 개념은 없다.
- **Atlassian Forge**: "use tokens in place of colors, **spacing and typography** throughout your application", `token("space.150")`, `token("font.body")`. 역시 값 집합을 제한하는 방식.
- **VS Code**: 폰트는 `--vscode-editor-font-family/-weight/-size`로 **사용자 설정값을 그대로 내려준다** — 즉 밀도의 최종 결정권이 호스트도 플러그인도 아닌 **사용자**에게 있다.
- **Backstage**: BUI에 Tokens 섹션과 `Text` 컴포넌트가 있지만, 플러그인 저자에게 밀도를 강제한다는 문서는 없다.
- **Figma**: 강제 없음. 권고 + 사람 리뷰만.

---

## dataroom 에 적용할 것

1. **본문 기본을 `text-sm`(14px/20px)로 고정하고, 16px은 "문서 본문 읽기"에만 쓴다.**
   Carbon `$body-compact-01`, Atlassian `font.body`, Fluent 2 `Body 1`, Primer `--text-body-size-medium`, Radix step 2가 전부 14px이다. Tailwind v4의 `--text-sm` + `--text-sm--line-height`가 정확히 14/20이라 그대로 쓰면 된다. 문서 뷰어의 본문(추출 텍스트, AI 요약 장문)만 `text-base`(16/24). **리스트·테이블·스코어링 패널에 16px을 쓰지 않는다.**

2. **테이블 행 높이를 Carbon 램프로 못 박고 3개만 노출한다: 32 / 40 / 48px.**
   `h-8`(32, compact — 문서 리스트·크라이테리아 래더), `h-10`(40, default), `h-12`(48, comfortable — 리뷰어 스코어링처럼 셀 안에 컨트롤이 들어가는 경우). Carbon의 24px(xs)은 체크박스 20px과 충돌하므로 제외, 64px(xl)은 2줄 전용이라 제외. **툴바 높이는 행 높이에 페어링해 32px(compact) / 48px(default·comfortable) 두 개만** 둔다(Carbon 규칙 그대로). 밀도는 전역 테마가 아니라 **테이블 컴포넌트 prop**으로 — 조사한 모든 시스템이 그렇게 한다.

3. **계층은 크기가 아니라 weight + surface로 만든다. 세 단계만 허용.**
   같은 14px 안에서 `font-normal`(400, 데이터) / `font-medium`(500, 아이콘 옆 라벨·컬럼 헤더) / `font-semibold`(600, 섹션 제목·선택된 행) 3단계. Carbon이 컬럼 헤더와 행 텍스트를 둘 다 14px로 두고 600 vs 400으로만 가르는 걸 그대로 따른다. **텍스트 크기를 13px, 15px 같은 중간값으로 흩뿌려서 계층을 만들지 않는다.**

4. **깊이는 shadow 2단계 + surface 3단계로 제한한다. 리스트/테이블에는 shadow를 쓰지 않는다.**
   `theme.css`에 `--shadow-raised`(드래그 가능/포커스된 카드 전용)와 `--shadow-overlay`(모달·드롭다운·플로팅 툴바) **2개만** 정의. Atlassian 규칙 그대로 — **"border나 whitespace로 충분하면 raised를 쓰지 않는다."** 대신 surface 토큰 3단계 `--color-surface-sunken / --color-surface / --color-surface-raised`로 레벨을 표현(Carbon layer 방식). 다크 테마에서는 **그림자가 아니라 surface 밝기**가 주 신호가 되게 값을 잡는다(Atlassian 다크모드 규칙).

5. **스크롤 그림자를 토큰으로 정의한다 — dense 화면에서 가장 저렴한 깊이 신호.**
   Atlassian `elevation.shadow.overflow`에 해당하는 `--shadow-overflow`를 추가하고, sticky 헤더가 있는 테이블·문서 리스트·`two-depth-pane`의 스크롤 경계에 적용. 내용이 잘렸다는 사실 자체가 dense 화면에서 가장 자주 놓치는 정보다.

6. **테이블 규칙: divider만, zebra 없음. 숫자는 우측 정렬 + tabular-nums. 결측은 en dash.**
   Spectrum 규칙을 채택한다 — 행 구분선이 이미 있으면 zebra는 중복 노이즈다. Tailwind로: `tabular-nums` 유틸리티를 스코어/금액/날짜 컬럼에 강제, 텍스트 컬럼은 `text-left`(가운데 정렬 금지), 결측 셀은 `–`(U+2013). 컬럼 divider는 그룹 경계에만(Spectrum "use sparingly").

7. **행 액션: 3개 미만이면 오버플로 메뉴를 쓰지 않는다. 배치 모드에서 행 액션은 disable.**
   Carbon 규칙. 리뷰 화면에서 "승인/반려" 2개뿐인 행에 `⋯` 메뉴를 다는 걸 금지한다. 배치 선택이 켜지면 행 단위 아이콘·오버플로는 disabled로 내린다(두 모드의 액션이 동시에 활성인 상태를 만들지 않는다).

8. **disclosure는 동시에 1개, 중첩 금지, 폭은 패널 절반 이하, 자동 열림 금지.**
   Carbon disclosure 규칙을 AI findings 팝오버와 크라이테리아 설명에 그대로 적용한다. 특히 **"완료에 필요한 정보를 disclosure 안에 숨기지 않는다"** — AI 근거(citation)처럼 판단에 필요한 것은 확장 행이나 컨텍스트 페인에 상시 노출하고, 보조 설명만 팝오버로 뺀다. 확장 행을 쓸 때 **`pl-12`(48px) 들여쓰기**로 종속 관계를 표시(Carbon `$spacing-09`).

---

## 우리 셸에 적용할 규칙

1. **`packages/components/theme.css`가 소유하는 것을 확정하고, 그 밖은 플러그인이 정의할 수 없게 한다.**
   theme.css의 `@theme inline`이 소유: 컬러(semantic + surface 3단계), **타입 스케일 + 행간 페어(`--text-*` / `--text-*--line-height`)**, spacing 램프(4px 기반), radii, elevation(`--shadow-raised` / `--shadow-overlay` / `--shadow-overflow`), `--dark`/`--light` 스위치. Grafana의 규칙을 그대로 문서화한다 — **"플러그인 코드에 색·간격·폰트 크기 리터럴을 쓰지 않는다."** 우리 스택에서 이건 "임의 값 대괄호 문법(`text-[13px]`, `bg-[#f5f5f5]`, `p-[7px]`) 금지" 로 번역되고, ESLint/`eslint-plugin-tailwindcss` 또는 CI grep으로 강제 가능하다.

2. **플러그인의 자체 Tailwind pass가 절대 재정의하면 안 되는 것: `@theme`의 키 자체.**
   각 번들이 독립 Tailwind pass를 돌리는 구조에서는 플러그인이 `--color-primary`나 `--text-sm`을 자기 CSS에서 다시 선언하면 **마지막에 주입된 스타일시트가 이긴다**. 규칙: 플러그인은 theme.css를 **import만** 하고 `@theme` 블록을 **선언하지 않는다**. 플러그인 고유 색이 필요하면 `--plugin-<id>-*` 접두사로 **새 이름**을 만들고, 절대 기존 토큰 이름을 덮어쓰지 않는다. 그리고 **global selector(`body`, `*`, `:root`, `html`)에 스타일을 쓰지 않는다** — Grafana가 "Never use global styles as they can cause breakages as Grafana evolves"로 명시한 그 문제가 우리 구조에서는 더 심각하다(번들이 언마운트돼도 스타일은 남는다). 플러그인 스타일은 호스트가 넘겨준 마운트 엘리먼트 하위로 스코프한다.

3. **"내가 지금 어떤 surface 위에 있는가"를 토큰으로 내려준다 — Forge `utility.elevation.surface.current` 대응.**
   `workspace-content`가 자기 배경을 `--color-surface-current`에 세팅하고, `two-depth-pane`의 detail 영역처럼 다른 레벨의 면에서는 그 값을 덮어쓴다. 플러그인은 자기 컨테이너 배경을 하드코딩하지 말고 **기본을 `transparent`로 두거나 `--color-surface-current`를 쓴다.** 이게 없으면 같은 플러그인이 페이지·모달·패널에서 서로 다른 배경 위에 얹혔을 때 반드시 색이 어긋난다. 컬러모드는 Forge처럼 **호스트만 씀 / 플러그인은 읽기 전용**으로 계약한다.

4. **페이지 프레임·타이틀·탭·토스트·모달은 호스트 소유. 플러그인은 값만 선언한다.**
   Backstage `PluginHeader`(icon/title/titleLink/tabs/actions)와 Shopify `TitleBar`가 같은 답을 낸다. `@biyard/components`에 `PluginHeader`를 추가하고 `meta.ts`의 `icon`/`name`을 호스트가 읽어 렌더한다. 플러그인은 탭 목록과 액션만 넘긴다. **가변 내비(minRole) 환경에서 "지금 어느 플러그인 안인지"를 항상 보여주는 유일한 고정 요소가 이 헤더이므로, 플러그인이 자체 페이지 타이틀을 그리는 것을 금지한다.** 토스트·확인 모달도 host API로 올려서 z-index/포커스 트랩이 번들 경계를 넘어 싸우지 않게 한다.

5. **`two-depth-pane`은 "목록 + 상세"가 같은 화면에 공존하는 모든 화면에서 필수로 강제한다.**
   구체적으로: 문서 리스트 → 문서 뷰어, 크라이테리아 래더 → 크라이테리아 상세, AI findings 리스트 → 근거, 리뷰어 스코어 목록 → 스코어 입력. 이 네 곳은 **옵션이 아니라 필수**. 이유는 VS Code가 Activity Bar/Primary Sidebar/Editor의 **위치를 고정해서** 확장이 늘어도 공간 기억이 안 깨지게 한 것과 같다 — 플러그인마다 목록/상세 배치가 다르면 `minRole` 때문에 플러그인 구성이 달라지는 우리 환경에서는 학습이 누적되지 않는다. 반대로 **단일 객체 편집·설정 화면에서는 `two-depth-pane`을 쓰지 않는다**(빈 detail 페인은 비용만 든다).

6. **플러그인 경계를 넘는 링크는 직접 경로를 쓰지 않고, 대상이 없으면 링크를 렌더하지 않는다.**
   `dataroom`이 `assessments`에 의존하는 지점에서 `/assessments/...` 하드코딩을 금지하고, **`host.navigate` + 플러그인이 선언한 named route**로만 이동한다(Backstage `ExternalRouteRef` + route binding 대응). 그리고 Backstage `useRouteRef`가 대상 미설치 시 `undefined`를 반환하는 동작을 그대로 채택 — **`minRole` 때문에 `assessments`가 없는 사용자에게는 링크를 비활성이 아니라 아예 렌더하지 않는다.** 추가로 Backstage가 경고한 함정을 피한다: **권한/역할 변화는 앱 트리를 다시 준비해야 반영된다.** 우리도 `minRole` 평가를 런타임 내내 반응형으로 만들지 말고, 로그인/역할 변경 시점에 레지스트리를 다시 계산하는 것으로 정의한다.

7. **플러그인 레지스트리 순서는 등록 순서가 아니라 `meta.ts`의 명시적 order로 정한다.**
   Backstage는 "extension을 disabled→enabled로 토글하면 순서가 리셋되어 목록 끝으로 밀린다"는 함정을 문서화했다. `minRole`로 목록이 달라지는 우리 구조에서 **같은 플러그인이 사용자마다 다른 위치에 나타나면 공간 기억이 깨진다.** `meta.ts`에 정수 `order`를 추가하고 런처는 항상 그 값으로 정렬한다 — 가려진 항목이 있어도 보이는 항목의 상대 순서는 불변이어야 한다.

---

## 주의 — 예뻐 보이지만 dense read-heavy 앱을 망치는 것들

1. **밀도 모드를 전역 테마 스위치로 만드는 것.** 조사한 어떤 시스템도 그렇게 하지 않는다. 전부 테이블 컴포넌트의 prop이다. 전역 스위치로 만들면 문서 뷰어 본문까지 같이 쪼그라들어서, 정작 길게 읽어야 하는 곳이 읽기 어려워진다.

2. **Zebra stripe.** Spectrum이 직접 금지한다 — 행 구분선이 이미 있는데 배경까지 번갈아 칠하면 정보가 아니라 노이즈가 늘어난다. 스크린샷에서는 "표처럼 보여서" 좋아 보이지만, 선택 행·hover 행·AI 플래그 행 같은 **의미 있는 배경색이 들어갈 자리를 미리 태워버린다.** 우리처럼 행 상태가 여러 개(미검토/검토중/플래그/선택)인 화면에서는 치명적이다.

3. **raised shadow로 카드를 그룹핑하는 것.** Atlassian이 명시적으로 Don't — "Raised elevations can create visual noise, so don't use to group content when a border or white space would suffice." 리뷰 화면을 카드 격자로 만들면 카드 하나당 padding+shadow로 화면당 표시 행 수가 절반이 된다.

4. **Glass / translucency를 dense 영역에 쓰는 것.** 조사한 10개 디자인 시스템 중 **glass를 토큰이나 패턴으로 문서화한 곳이 하나도 없다.** 반대로 Fluent 2는 컬러 면 위 그림자마저 휘도식으로 보정할 만큼 "배경이 바뀌면 대비가 깨진다"에 민감하다. 반투명 배경 위에 14px 텍스트를 올리면 스크롤에 따라 대비가 변동하고, Atlassian의 4.5:1을 보장할 방법이 없다. 쓴다면 **텍스트가 없는 크롬(상단 바 배경) 한정**.

5. **Bento grid식 카드 레이아웃을 문서 리스트/스코어 패널에 적용하는 것.** Carbon: "Avoid placing data tables inside data tables or smaller containers where the information can feel cramped or needs truncation." Bento 셀은 정의상 작은 컨테이너다.

6. **중요한 정보를 disclosure/툴팁 뒤로 숨기는 것.** Carbon: "Do not hide important information inside of a disclosure that the user may need in order to complete a task." Due diligence에서 AI finding의 근거·출처는 판단의 입력값이므로 hover 뒤에 두면 안 된다. 특히 Carbon은 **"disclosure는 절대 자동으로 열리면 안 된다"**고까지 쓴다 — hover로 열리는 근거 팝오버는 마우스 이동만으로 화면이 계속 흔들린다.

7. **배치 확장(expand all).** Carbon이 정확히 경고한다 — 확장 행의 이점은 "데이터 쿼리를 필요할 때까지 미루는 것"인데 전체 펼치기는 그 이점을 무효화한다. 리뷰 화면에 "모두 펼치기"를 다는 건 성능과 스캔 가능성을 동시에 버리는 선택이다.

8. **행 높이를 24px 이하로 내리는 것.** Carbon의 xs가 24px인데, 이 행에는 20×20 체크박스가 들어간다(여유 2px). 선택 가능한 행이면 32px 아래로 내려가는 순간 클릭 타깃이 WCAG 2.2의 24×24 기준과 충돌하기 시작한다. Carbon 자신도 chevron의 **클릭 타깃을 아이콘(16px)보다 큰 32px**로 따로 잡아둔다.

9. **"디자인 가이드라인 문서를 만들면 플러그인들이 따를 것"이라는 가정.** Backstage의 legacy 문서는 "Adherence to stringent design guidelines guarantees a consistent and intuitive user experience"라고 쓰지만, 실제로 일관성을 만들어낸 건 문장이 아니라 **BUI 컴포넌트 라이브러리 + 토큰 + PluginHeader**다. Figma는 문장(권고)과 사람 리뷰만 있고, 그래서 플러그인을 모달에 격리하는 쪽을 택했다. **강제 가능한 메커니즘(토큰 전용, 리터럴 금지 린트, 호스트가 그리는 프레임)이 없는 가이드라인은 플러그인 수가 3개를 넘는 순간 무너진다.**

---

## 확인된 부재 (조사했으나 없었던 것)

- **Microsoft Fluent 2 공개 디자인 사이트에 Table/DataGrid 컴포넌트 문서가 없다.** `fluent2.microsoft.design/components/web/react` 목록에 table도 datagrid도 없고, `/components/web/react/table/usage` 류 URL은 전부 "We couldn't load that page … Microsoft employee? Sign in to see internal-only content"를 반환한다. DataGrid 문서는 react.fluentui.dev Storybook에만 존재한다. (해당 실패 캡처는 삭제했고, 대신 유일하게 공개된 다행 컴포넌트인 `fluent2_list-usage.png`를 남겼다.)
- **Shopify Polaris의 독립 문서 사이트(`polaris.shopify.com`, `polaris-react.shopify.com`)가 존재하지 않는다** — 둘 다 `shopify.dev/docs/api/polaris`로 리다이렉트된다. Polaris React는 `Shopify/polaris-react-archive` (Deprecated). 따라서 "Polaris IndexTable 디자인 가이드" 캡처는 불가능했고, 현행 문서인 `s-table` web component 레퍼런스로 대체했다.
- **Tailwind UI는 현재 Tailwind Plus이고 application-ui 블록은 로그인 벽 뒤에 있다.** 캡처한 것은 로그인 폼뿐이어서 삭제했고, 우리 스택에 실제로 쓸모 있는 `tailwindcss.com/docs/font-size`(v4 `--text-*` 토큰 구조)로 대체했다.
- **어떤 시스템도 "reading pane + context pane" split view를 정식 패턴으로 문서화하지 않았다.** VS Code의 Primary/Secondary Sidebar 구조가 가장 근접한 공개 문서다.
- **WCAG 2.2의 2.5.8 Target Size(24×24 CSS px)를 명시적으로 인용한 디자인 시스템 페이지를 찾지 못했다.** WCAG 2.2 AA 준수를 선언한 곳은 Primer뿐이고, Carbon은 2.1 AA로 표기한다.
- **glass / translucency / backdrop-blur를 토큰이나 가이드라인으로 문서화한 시스템은 없었다.**
