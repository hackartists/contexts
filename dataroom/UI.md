# UI 디자인 가이드라인

화면을 만들 때 아래 네 층을 순서대로 훑는다. **타입**이 표면을 정하고, **원칙**이 무엇을 얼마나
보여줄지 정하고, **컬러**와 **폭**이 나머지를 정한다.

---

## 1. 디자인 타입

### Flat Design 2.0

> **Flat design with a measured amount of depth added back — subtle shadow, layering and
> motion used only to restore the affordance that pure flat design removed.**

면은 평평하게, 경계는 1px border 로 만든다. **그림자는 떠 있는 레이어에만** 쓴다 —
popover · dropdown · modal. 카드 · 표 · 입력 필드에는 쓰지 않는다.

### Minimalism

> **Reduction to what serves the task; every remaining element earns its place by function,
> not decoration.**

장식은 기능이 아니다. 지워도 일이 되면 지운다.

### 보조

- **Dark Mode** — 애널리스트는 한 번에 오래 본다. `--dark` / `--light` 토큰이 이미 있으므로
  새 화면은 두 모드 모두에서 확인하고 넘어간다.
- **Purposeful motion only** — 상태 변화를 설명하는 모션만 쓴다. 등장 연출은 모션이 아니라 소음이다.

### 쓰지 않는 것

| 타입 | 이유 |
|---|---|
| Glassmorphism | 대비가 무너진다. VDR 제품 중 쓰는 곳이 하나도 없다. |
| Neumorphism | 저대비. 누를 수 있는 것인지 구분되지 않는다. |
| Skeuomorphism | 실물 은유가 필요한 대상이 없다. |
| Bold Typography | 밀도 높은 화면에서 자리만 먹는다. |
| Illustration-led | 데이터가 주인공인 화면에 그림이 들어갈 자리가 없다. |
| Bauhaus | 조형 실험이다. 매일 반복해 보는 업무 화면과 맞지 않는다. |

Gradient 는 랜딩 페이지 전용이다. **제품 UI 에는 쓰지 않는다.**

---

## 2. 설계 원칙

### Information Density

> **The proportion of data-ink to total ink — how much of what is on screen is the data itself
> rather than the container around it.**
> — Tufte, *The Visual Display of Quantitative Information*

전문 사용자는 밀도 임계값이 높다. 여기서 높은 밀도는 **타협이 아니라 요구사항**이다.

**체크**
- 한 화면에서 데이터가 아닌 것(여백 · 테두리 · 헤더 · 아이콘)이 차지하는 비율은 얼마인가?
- 스크롤을 늘려서 여유를 만든 것인가, 아니면 실제로 정보를 더 준 것인가?
- 줄일 수 있는 건 데이터가 아니라 그 주변이다.

### Grounding

> **Tying generated claims to evidence the system actually holds — retrieval, citation and
> attribution — so a claim can be traced back to its source.**

사용자는 **주장에서 출처까지 한 번의 클릭**으로 갈 수 있어야 한다.

**체크**
- 신뢰도를 숫자로 지어내지 않는다. 없는 confidence score 를 만들지 마라.
- **빈 곳을 그려라.** "A · B · C 가 필요한데 A 만 있음" 이 결론보다 더 많은 정보를 준다.
- 시각적 위계에서 **근거와 공백이 판정보다 위**다. 판정만 크게 띄우면 검증할 방법이 없어진다.

### Progressive Disclosure

> **Deferring secondary information and actions until the user asks for them, keeping the
> default view to what most users need most of the time.**

Information Density 와 정면으로 충돌한다. 밀도가 기본값이고, 숨기는 건 근거가 있을 때만이다.

**체크**
- 숨긴 것이 2차 정보인가, 아니면 그냥 정리가 안 돼서 치운 것인가?
- **hover 로 여는 것은 금지** — 비가역 · 외부노출 · 파괴적 행동에 대해서는 절대 쓰지 않는다.
- **자동으로 열리지 않는다.** 여는 주체는 항상 사용자다.

---

## 3. 컬러 규칙

실제 값은 `packages/components/theme.css` 에서 정한다. 여기서는 규칙만 정한다.

- **색은 상태에만.** 표는 사실상 흑백이다. 색은 상태 배지 · 우선순위 · 라벨칩 · 진행바에만 쓴다.
- **선택 상태 관용구**: 좌측 4px 컬러 바 + 연한 배경. 선택은 테두리 강조로 표현하지 않는다.
- **등급 · 레벨은 Sequential 스케일**(단일 색상 + 명도 램프)로 만든다. red → amber → green 은
  쓰지 않는다. 등급은 순서 있는 데이터이고, 명도가 주 구분자이므로 모든 색맹 유형에서 살아남는다.
  **반드시 텍스트 라벨을 함께 둔다** (WCAG 1.4.1).
- **상태색은 색상만이 아니라 명도로도 분리한다.** 어두운 빨강 + 밝은 초록 원칙. 색상만 다르고
  명도가 같으면 흑백으로 인쇄했을 때 같은 회색이 된다.
- **배지는 색 텍스트가 아니다.** `-muted` 배경 + 진한 전경 + 라벨로 만든다. 색면은 비텍스트
  대비 3:1 만 넘기면 되므로 색상과 명도를 자유롭게 고를 수 있다.
- **플러그인은 semantic 토큰만 소비한다.** primitive 를 직접 참조하지 않는다.
- **WCAG 2.2 AA 를 하한으로, APCA 를 튜닝 목표로.** AA 를 통과하는 것과 오래 봐도 편한 것은 다르다.

---

## 4. 폭 운용

- Full width 는 **콘텐츠 하나를 늘리는 데 쓰지 않고 pane 을 늘리는 데** 쓴다.
- **페이지 셸에 전역 max-width 를 걸지 않는다.** 캡은 콘텐츠 타입이 건다 — 테이블은 fluid,
  프로즈와 폼은 캡.
- pane 내부 컴포넌트는 viewport breakpoint(`md:` / `lg:`)가 아니라
  **container query(`@md:` / `@lg:`)** 로 반응한다. pane 은 리사이즈 가능하므로 viewport 기준은
  깨진다. Tailwind v4 는 container query 가 코어에 있다.
- 울트라와이드에서는 늘리지 말고 **3번째 pane 을 연다.** pane 은 3개가 상한이다.

---

*근거: [`references/ux-ui-trends-2026/`](../references/ux-ui-trends-2026/README.md) 의 2026년 수집 자료.*
