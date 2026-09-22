# UX Flow 설계 가이드라인

Flow 를 만들 때 아래 세 관점으로 각각 한 번씩 훑는다. 순서가 곧 우선순위다.

---

## 1. Information Scent

> **The cues a user relies on to judge whether a path leads to what they want — drawn from
> link labels, surrounding context, and prior experience. Users follow the strongest scent
> and abandon when it weakens.**
> — Pirolli & Card, *Information Foraging Theory* (Xerox PARC)

**개시권: 사용자.** 사용자는 이미 행동 중이고, 다음 한 걸음을 찾고 있다.

사용자는 먹이 찾는 동물처럼 냄새를 따라간다. 냄새가 점점 강해져야 계속 가고, 약해지면 떠난다.

**체크**
- 이 화면에서 다음 걸음이 무엇인지 보이는가?
- 링크·버튼·제목이 **목적지에 무엇이 있는지** 말하는가? (지어낸 말·슬로건 금지)
- 냄새가 끊기는 지점은 어디인가? 거기가 이탈 지점이다.

---

## 2. Anticipatory Design

> **Design that predicts what a user needs and prepares or acts on it before they ask,
> reducing or removing the decision itself.**
> — Aaron Shapiro (2015)

**개시권: 시스템.** 사용자는 요청한 적이 없다.

강도는 세 단계다: **예측**(순서만 바꿈) → **준비**(만들어두고 확인만 받음) → **실행**(대신 결정).

**체크**
- 사용자가 이걸 요청한 적이 있는가? 없다면 **무시 가능하고 되돌릴 수 있는가?**
- 틀렸을 때 비용이 "조금 불편"인가 "왜 마음대로"인가? 후자면 하지 마라.
- 알림을 늘리는 방식인가? 그렇다면 **정렬·묶음으로 바꿔라.** 긴급하지 않은 방해에 대한
  사용자 관용도는 낮다.

---

## 3. Delegation

> **The user explicitly hands a bounded set of tasks, decisions or actions to the system,
> which then operates inside permissions the user has set.**

**개시권: 사용자가 사전에 넘김.** 맡기고 자리를 뜬다.

다이얼로 본다: **실행**(시키는 것만) → **결정**(판단까지) → **자율**(끝까지 알아서).

**체크**
- 지금 어느 단계인지 사용자가 아는가? 온/오프 이분법이 아니라 다이얼로 보이는가?
- **범위 · 검토 · 되돌리기** 세 가지가 다 있는가?
- 맡긴 뒤 **지켜보는 비용**은 얼마인가? 실행 중에 답을 요구하지는 않는가?
  (관찰은 항상 열되, 확인은 비가역·외부노출·비용발생 행동에만)

---

## 적용 순서

```
Information Scent  →  Anticipatory Design  →  Delegation
   (항상, 기본값)        (패턴이 확인되면)       (사용자가 원하면)
```

**건너뛰지 않는다.** Scent 가 안 되는 화면에서 Anticipatory 를 하면 도움이 아니라 방해이고,
Anticipatory 가 신뢰를 못 얻은 상태에서 Delegation 을 열면 아무도 다이얼을 올리지 않는다.

## 경계 규칙

셋을 가르는 건 **개시권**이고, 지켜야 할 선은 하나다.

| | 개시 | 사용자가 허락했나 | 그래서 필수인 것 |
|---|---|---|---|
| Information Scent | 사용자 | — | 명확한 레이블 |
| Anticipatory | 시스템 | **아니오** (암묵) | 무시 가능 · 되돌리기 |
| Delegation | 사용자 (사전) | **예** (명시) | 범위 · 검토 · 되돌리기 |

> **묻기 전에 주는 건 Anticipatory, 맡겨서 하는 건 Delegation.
> 경계를 넘으려면 사용자에게 물어봐야 한다.**

가장 흔한 사고는 Anticipatory 가 슬금슬금 Delegation 영역으로 넘어가는 것이다 — 사용자가
허락한 적 없는데 시스템이 대신 결정하기 시작하는 순간, 신뢰가 깨진다.

## 자율성이 올라갈 때 바뀌는 요구사항

단계가 올라갈수록 사용자가 요구하는 것이 달라진다. 정확도만 올려서는 다음 단계로 못 간다.

| 단계 | 핵심 요구 |
|---|---|
| 제안 | 정확도 |
| 결정 | 개인화 — 내 맥락을 아는가 |
| 자율 | **공정성(perceived impartiality)** — 이 시스템이 내 편인가 |

---

*근거: [`README.md`](README.md) 의 2026년 수집 자료 및 NN/g Information Foraging 문헌.*
