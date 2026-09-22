# AI-over-documents tools — 근거·인용·발견 제시 UI 레퍼런스

수집일: 2026-09-22 / 대상: dataroom `evaluation` 서비스 결과 화면 설계
모든 캡처는 **공개 마케팅·문서 페이지에 실제로 임베드된 제품 UI**이며, 로그인·우회는 하지 않았다.
아래 "패턴 정리"는 전부 캡처 화면에서 **직접 눈으로 확인한 것**만 기술했다. 확보 실패는 맨 아래에 그대로 남겼다.

---

## 1. 캡처 목록

| Screenshot | Product | URL | What pattern it shows |
|---|---|---|---|
| `hebbia_matrix-grid-hero.png` | Hebbia Matrix | https://www.hebbia.com/product/matrix | 행=회사, 열=질문인 그리드. `Source Documents` 열이 근거 PDF 칩 스택으로 따로 존재. 셀 안에 `Metric/Value/Basis` 미니 표가 들어가 **근거 기준(Basis)이 셀 내부 컬럼**으로 노출 |
| `hebbia_control-every-step.png` | Hebbia Matrix | https://www.hebbia.com/product/matrix | "Control every step — tracing every answer back to the exact sentence". 셀 단위 협업 커서(Shaun/Christie)와 셀 컨텍스트 메뉴 `Verify content / Assign reviewer / Re-run` |
| `hebbia_blog_grid-cells-hero.png` | Hebbia Matrix | https://www.hebbia.com/blog/introducing-matrix-the-interface-to-agi | 포트폴리오 그리드 렌더. 열 = EBITDA Margin / Revenue Growth / Beat-Miss Goals / Tailwinds. 정량 셀과 정성 셀이 한 행에 공존 |
| `hebbia_blog_matrix-intro.png` | Hebbia | 〃 | 본문 논지: "인용이 있어도 사고과정을 모르면 신뢰 못 한다 / 중요한 결정은 생성적이 아니라 **판별적(discriminative)**이다" |
| `hebbia_matrix-product.png` | Hebbia | https://www.hebbia.com/product/matrix | 제품 페이지 전체 맥락(Scale the work, keep the judgment / Control every step / 산업별 활용) |
| `rogo_workflow-cards-sources.png` | Rogo | https://rogo.com/product | `Running workflow…` 체크리스트(Identifying companies → Searching sources → Retrieving metrics → Creating table → **Finalizing citations…**), 답변 위 `Found 12 sources` 배지, AI Table |
| `rogo_product.png` | Rogo | https://rogo.com/product | "Transparent, auditable sources" / "Proprietary document interrogation" 4대 축, 연결 데이터 소스 인벤토리(LSEG·FactSet·Capital IQ·SEC Filings…) |
| `harvey_vault_review-table-badges.png` | Harvey Vault | https://www.harvey.ai/products/vault | 리뷰 테이블: 행=계약 PDF, 열=쟁점. 셀 값이 **3단계 색 배지**(Disputed 적 / Somewhat Disputed 황 / Not Disputed 녹) |
| `harvey_vault_query-over-files.png` | Harvey Vault | 〃 | 프롬프트 위 `📁 Project Atlas Data Room` 스코프 칩, `Generate a review / Draft a document / Use a workflow` 액션, 파일별 Category 태깅 |
| `harvey_vault.png` | Harvey Vault | 〃 | 전체 페이지. 데이터룸 파일 트리 + `Review table / Draft document` 탭, "96% key-term extraction accuracy" 수치 |
| `alphasense_inline-highlight-attribution.png` | AlphaSense Generative Search | https://www.alpha-sense.com/platform/generative-search/ | 답변 문장을 **큰따옴표로 인용** + 핵심 구절 노란 하이라이트 + 문장 끝/중간에 소스타입 칩(`Investor Transcripts ›`, `Internal Content ›`) |
| `alphasense_thinking-steps-source-chips.png` | AlphaSense | https://help.alpha-sense.com/hc/en-us/articles/41665816407699-Accessing-Generative-Search | `Thinking…` 추론 스텝 트리 + **실제 검색한 범위를 칩으로 노출**(Caterpillar Inc / ESG / Presentations / +16) + `Skip, View Fast answer` |
| `alphasense_source-scoping-controls.png` | AlphaSense | 〃 | `+ / All Sources / Enhance` 컴포저 컨트롤과 Select Documents 모달(Universe·Keywords·Tags·문서유형·기간, 6건 중 5건 체크) |
| `alphasense_single-doc-split-view.png` | AlphaSense | 〃 | 문서 뷰어 툴바의 `✨ Ask in Doc` 버튼 + 좌(원문·키워드 하이라이트) / 우(생성 답변) 분할 |
| `alphasense_generative-search.png` | AlphaSense | https://www.alpha-sense.com/platform/generative-search/ | 제품 페이지 전체 맥락(Generative Search / Deep Research / Work Products 탭 구조) |
| `elicit_cell-drilldown-modal.png` | Elicit | https://support.elicit.com/en/articles/3090497 | **셀 → 근거 드릴다운 모달**. 좌: 번호 배지가 달린 추출 클레임 목록 / 우: `← 3 of 6 →`, `Claim ③`, 원문 `Table 4 · On page 10` 렌더 + 근거 문장 틴트 블록 + `Open paper ↗` |
| `elicit_help_cell-to-quote.png` | Elicit | 〃 | "표에서 가져오면 그 표를 인용한다" 문서화, 그리고 **"복잡한 표는 추출에 실패하기도 한다"는 한계 명시** |
| `elicit_help_workflows-and-tables.png` | Elicit | https://support.elicit.com/en/articles/1418881 | Find Papers / Research Report / Systematic Review / Extract Data / Chat with Papers / Research Agent 워크플로별 테이블 UI |
| `perplexity_answer-with-citations.png` | Perplexity | https://www.perplexity.ai/search?q=… (실사용 캡처) | `Answer/Links/Images` 탭, 우상단 `Sources 10 ›` 카드, `Researched 1s` 메타, **번호가 아닌 도메인 칩** 인용(`investor.nvidia +1`), 하단 후속질문 5개 |
| `luminance_doc-inline-annotations.png` | Luminance | https://www.luminance.com/ | 문서 위 앵커된 카드: `Term` + 앰버 배지 `NON STANDARD` → 접이식 `Reasons`(비표준 사유 4개 bullet) → 접이식 `Mark-up`(수정 제안 4개) → `Mark-up / Preview` 버튼. 본문에는 레드라인 |

---

## 2. 패턴 정리

### 2-1. 인용 메커니즘 (Citation mechanics)

- **번호 각주는 이제 소수파다.** 화면에서 실제로 본 인용 표기는 세 갈래였다.
  - **소스타입 칩**: AlphaSense는 `"NVIDIA expects slower CapEx growth due to higher financing costs."` 뒤에 아이콘 + 라벨 + `›` 형태의 pill(`Investor Transcripts ›`)을 붙인다. 두 번째 문장에서는 `"Private AI firms [Internal Content ›] are pausing data center builds…"`처럼 **문장 중간**에 칩이 들어간다. 즉 "이 절(clause)이 어느 소스에서 왔는지"를 문장 단위보다 더 잘게 표시한다.
  - **도메인 칩**: Perplexity는 `[1]` 대신 모노스페이스 도메인 칩 `🛡 investor.nvidia +1`을 문장 끝에 붙인다. 번호를 없애고 **출처의 성격(공식 IR 사이트)** 을 즉시 읽히게 한 것.
  - **원형 번호 배지**: Elicit만 전통적 번호(①~⑩)를 쓰는데, 이건 목록형 추출 결과이기 때문이다. 각 수치(`aHR = 1.18 (95% CI: 0.83, 1.67), P = 0.356 ③`) 끝에 배지가 붙는다.
- **하이라이트를 인용의 일부로 쓴다.** AlphaSense는 인용 문장 안에서 `slower CapEx growth`, `credit markets`만 노란색으로 칠한다. 인용 = "출처 링크"가 아니라 "출처 + 결정적 구절"의 묶음이다.
- **클릭하면 원문의 해당 위치로 간다.** Elicit 드릴다운 모달이 이걸 화면으로 보여주는 유일한 캡처다: 우측 패널에 논문의 **Table 4가 이미지 그대로** 렌더되고 `On page 10`이 명시되며, 그 아래 틴트 배경 블록에 근거 문장이 **원문 그대로(줄바꿈·오탈자 포함)** 들어간다. 위에는 `← 3 of 6 →` 페이저가 있어 **한 클레임에 근거가 여러 개일 때 순회**할 수 있고, `Claim ③` 라벨이 지금 보고 있는 근거가 어느 클레임 것인지 고정해 준다. 맨 아래 `Open paper ↗`로 전체 원문으로 이탈.
- Hebbia는 카피로 "tracing every answer back to the **exact sentence**"라고 명시하지만, 공개 화면에서 그 sentence-level 점프 동작 자체를 캡처하지는 못했다(로그인 필요).

### 2-2. 근거 패널 레이아웃 (Evidence panel layout)

- **세 가지 배치가 관측됨.**
  - **모달 2분할 (Elicit)**: 표 위에 덮이는 모달, 내부를 좌우 약 45:55로 나눠 **좌=AI 추출 클레임 / 우=원문 근거**. 좌우 폭이 거의 같다 = "요약이 원문보다 우월하지 않다"는 메시지.
  - **문서 위 플로팅 카드 (Luminance)**: 화면의 주인공은 계약서 본문이고, 근거·판단 카드가 해당 조항 **옆에 앵커**되어 떠 있다. 카드 폭은 화면의 약 1/4. 본문에는 레드라인이 그대로 보인다.
  - **문서 뷰어 + 우측 답변 패널 (AlphaSense `Ask in Doc`)**: 좌측에 원문(키워드 하이라이트, `…guidance has 12 keyword hits in this document`), 우측에 생성 답변. 약 45:55.
- **Hebbia/Harvey는 별도 근거 패널을 두지 않고 그리드 셀 자체를 근거 컨테이너로 쓴다.** Hebbia의 `Financials, Growth & Valuation` 셀 안에는 `Metric | Value | Basis` 미니 표가 들어가 있고, `Basis` 열에 `LTM Jun 30, 2026`, `vs. LTM Jun 30, 2025`, `NTM Jul '26–Jun '27, CapitalIQ Estimates`, `FactSet std.` 같은 **산출 기준 문자열**이 값과 1:1로 붙는다. 값과 근거가 같은 시각 단위 안에 있다.
- **소스 목록은 답변 "옆"이지 "아래"가 아니다.** Perplexity는 답변 본문 우측 상단에 `Sources · 10 ›` 카드를 띄워 놓고, 답변 하단 액션 바에도 `10 sources`를 중복 배치한다.

### 2-3. 확신도·불확실성 (Confidence & uncertainty)

- **숫자 confidence score를 화면에 띄우는 제품은 이 세트에 단 하나도 없었다.** 0–100, % , 별점 같은 표시는 전혀 관측되지 않았다.
- 대신 **순서형 카테고리 배지**로 표현한다. Harvey Vault가 가장 명확: 같은 컬럼 안에 `Disputed`(분홍) / `Somewhat Disputed`(노랑) / `Not Disputed`(연녹) 3단계. "Somewhat"이라는 **언어적 헤지를 배지 라벨 자체에 박아** 넣었다.
- Luminance는 이진 플래그 + 사유 전개: `NON STANDARD` 앰버 배지 하나를 띄우고, 그 확신의 근거를 `Reasons ⌄` 안에 **4개 bullet으로 분해**한다("Includes auto-renewal / Term period exceeds 3 years / Lacks option to terminate for convenience / The Contract term period is 6 years"). 확신도를 스칼라로 압축하는 대신 **판단을 구성하는 조건들을 나열**하는 방식.
- Hebbia는 확신도 대신 **행동 가능한 검증 경로**를 준다. 셀 컨텍스트 메뉴가 `Verify content / Assign reviewer / Re-run` — "얼마나 확신하냐"가 아니라 "누가 확인할 거냐"로 문제를 옮긴다.
- 제품 카피 수준에서도 확신도는 "감사 가능성"으로 치환된다: Rogo "Transparent, auditable sources", AlphaSense "accurate, auditable outputs".

### 2-4. 빈틈·누락 근거 (Gaps / missing evidence)

- **"근거를 못 찾았다"를 1급 UI 상태로 승격한 제품은 캡처 범위에서 못 찾았다.** 이게 이 리서치의 가장 큰 공백이자, 동시에 dataroom의 가장 큰 차별점 기회다.
- 가장 근접한 것들:
  - **Harvey의 `Not Disputed`** — 녹색 배지가 "확인했고 문제 없음"을 값으로 표현한다. 빈 셀이 아니라 **명시적 negative**.
  - **Luminance의 `Lacks option to terminate for convenience`** — "없음"을 Reasons bullet 안에 문장으로 적는다. 즉 "부재"가 판단의 근거가 된다.
  - **Elicit 도움말의 한계 고지** — 제품 문서에 "Elicit occasionally fails to extract and use information from some tables, depending on table complexity and formatting"라고 적고, **읽을 수 있었던 표 목록을 확인하는 경로**(논문 열고 맨 아래로 스크롤)를 안내한다. 즉 "시스템이 못 읽은 것"을 사용자가 점검할 수 있게 열어 둔다.
- Rogo는 "surfacing gaps before they become buyer-side questions"를 마케팅에서 주장하지만, 그 갭 화면 자체는 공개 페이지에 없었다(확인 못 함).

### 2-5. 결론 우선 vs 근거 우선 (Verdict vs evidence framing)

**시각 위계를 그대로 읽으면 두 진영으로 갈린다.**

- **근거 우선 (evidence-led)**
  - **Elicit**: 모달에서 가장 큰 면적은 AI 요약이 아니라 **논문 원본 표 이미지**다. `Claim ③`은 작은 라벨, `On page 10`도 작은 회색 텍스트. 결론 문장이라는 게 아예 없고 추출된 수치 목록만 있다.
  - **Hebbia**: 화면 최상단이 `Ask the Matrix…` 입력줄과 컬럼 헤더(질문)이고, 그 아래는 전부 문서 행이다. **`Source Documents`가 두 번째 컬럼**으로 회사명 바로 옆에 온다 — 답변보다 먼저 근거 문서가 나온다. Hebbia 자신이 블로그에서 "citations to sources만으로는 부족하고 사고 과정을 봐야 한다"고 쓴 것과 일관된다.
  - **Rogo**: `Found 12 sources` 배지가 **답변 산문보다 위에** 놓인다. 워크플로 체크리스트의 마지막 항목이 `Finalizing citations…` — 인용이 후처리가 아니라 산출물의 완성 조건으로 표시된다.
  - **Luminance**: 화면의 절대 다수가 계약서 원문이다. 판단 카드는 그 위에 얹힌 작은 오버레이이고, 카드 안에서도 가장 위는 `Term`(조항명)과 인용된 조항 텍스트이지 결론이 아니다.
- **결론 우선 (verdict-led)**
  - **Harvey Vault**: 테이블 셀에서 가장 눈에 띄는 것은 **색 채운 배지 `Disputed`** 다. 근거는 셀에 없고 별도 열람이 필요하다. 5개 행을 훑으면 사람은 색만 보고 넘어간다 — fiduciary 맥락에서 가장 위험한 위계.
  - **Perplexity**: 답변 문장이 큰 세리프체로 최상단에 오고, `10 sources`는 그 아래 회색 작은 텍스트다. 소스 카드도 우측에 **접힌 상태**로 있다. 결론을 읽고 끝내기 가장 쉬운 구조.
  - **AlphaSense**: 중간. 답변이 위이지만 문장 전체를 큰따옴표로 감싸 **"이건 내 말이 아니라 인용이다"** 라고 시각적으로 선언하고, 칩이 문장 중간까지 파고든다.

### 2-6. 표/매트릭스 출력 — 큰 그리드를 읽히게 만드는 법

- **Hebbia Matrix가 원형이다.** 행 = 문서/엔터티, 열 = 질문. 캡처에서 확인한 가독성 장치:
  - **툴바에 밀도 토글 3종**(행 높이 3단계 아이콘)이 상시 노출 — 17행 스캔 모드와 셀 정독 모드를 전환한다.
  - **열마다 타입 아이콘**이 헤더에 붙는다(회사 아이콘, 문서 아이콘, 원형 아이콘, 표 아이콘). 열이 "무엇을 담는 칸인지"를 라벨 없이 구분.
  - **셀 안에 서로 다른 렌더러**를 쓴다: 텍스트 배지(`Networks`, `Payment Processing` — 각각 다른 색), PDF 칩 스택, 미니 표, 미니 슬라이드 썸네일. 한 그리드 안에서 정성/정량/원문이 공존.
  - **정성 셀은 `라벨: 문장` 포맷으로 고정**된다(`Tech dependency: San Francisco's…`, `Market saturation: Denver's market…`). 굵은 라벨이 앞에 오니 잘린 셀도 스캔이 된다.
  - 탭으로 **용도별 프리셋**(Investing / Banking / Legal / Corporate)을 나눈다.
- **Harvey**는 같은 구조를 훨씬 단순화: 행=PDF 파일명(빨간 PDF 아이콘 포함), 열=쟁점 1개, 셀=배지. 행 번호(1~5)와 좌측 체크박스가 있어 **부분 선택 → 재실행/요약** 흐름을 암시.
- **공통**: 두 제품 모두 **행 헤더에 파일 아이콘 + 파일명 전체**를 쓴다. 요약된 엔터티명이 아니라 실제 파일명을 보여주는 게 신뢰의 기본 단위다.

### 2-7. 추적성 (Traceability) — 무엇을 왜 검색했는지

- **AlphaSense가 가장 노골적이다.** `Thinking…` 아래에 계획 문장("I'll gather information on the specific AI technologies Caterpillar is incorporating… from company documents, broker research, expert insights, and internal content")이 나오고, 접이식 하위 스텝("Use Search to find recent Caterpillar company documents that discuss…")이 달리며, 그 **바로 아래에 실제로 검색한 범위가 칩으로 나열**된다: `Caterpillar Inc` `ESG` `Presentations` `+16`. 즉 "무엇을 찾았나"가 아니라 **"어디를 뒤졌나"** 를 보여준다. 우상단 `Skip, View Fast answer`로 추론 과정을 건너뛸 수 있는 탈출구도 함께 제공.
- **Rogo**는 체크리스트형: `✓ Identifying companies → ✓ Searching sources → ✓ Retrieving company metrics → ✓ Creating table → ⟳ Finalizing citations…`. 스텝마다 완료 체크가 남아 사후에도 읽힌다.
- **Perplexity**는 `Researched 1s`라는 한 줄 메타만 남긴다(소요 시간). 과정은 접혀 있다.
- **검색 범위를 사용자가 먼저 고정하는 UI도 추적성의 일부다.** AlphaSense `Select Documents` 모달은 Universe(`TSLA Tesla Inc`), Keywords, Tags, 문서유형(`10-K/10-Q`), 기간(`Last 1 year`)으로 좁힌 뒤 **`6 Results` 중 `5 Selected`** 를 체크박스로 확정한다. Harvey는 프롬프트 위에 `📁 Project Atlas Data Room` 스코프 칩 하나로 같은 일을 한다. 둘 다 "AI가 알아서 고른 것"이 아니라 "내가 범위를 확정했다"는 감각을 준다.

---

## 3. dataroom evaluation 화면에 시사점

1. **평가 결과 화면의 최상단·최대 면적은 "레벨 판정"이 아니라 "근거"가 차지해야 한다.** Harvey가 셀에 `Disputed` 색배지만 띄우는 순간 리뷰어는 색만 보고 넘어간다 — 수탁자 책임이 걸린 화면에서 가장 위험한 위계다. 반대로 Elicit 모달은 AI 요약과 논문 원본 표를 거의 45:55로 배치해 "요약이 원문을 대체하지 않는다"를 레이아웃으로 선언한다. dataroom은 **Elicit/Hebbia 쪽(근거 우선)에 서야 하고**, 레벨 배지는 근거 블록보다 작고 뒤에 두는 게 맞다. 판정을 크게 띄우면 "AI가 이미 심사했다"는 오독을 UI가 보증하게 된다.
2. **숫자 confidence는 내지 마라. 업계 최상위 제품 어느 것도 안 쓴다.** 대신 두 가지를 조합하라: (a) Harvey식 **순서형 라벨에 헤지를 박아 넣기**(`충족` / `부분 충족` / `미충족` — "부분"이 라벨에 있어야 한다), (b) Luminance식 **판정을 구성한 조건 bullet 나열**(`Reasons` 접이식: "X 문서는 있으나 기간이 요구 범위 밖", "Y 지표는 언급만 되고 수치 없음"). 스칼라 점수는 근거 없이 신뢰를 만들어 내는 반면, 조건 나열은 리뷰어가 직접 반박할 수 있는 형태다.
3. **"근거를 찾지 못함"을 빈 셀이 아니라 1급 상태로 만들면 이 세트 전체에서 우위를 가진다.** 캡처한 어떤 제품도 이걸 제대로 하지 않았다 — 가장 근접한 게 Harvey의 `Not Disputed`(명시적 negative)와 Elicit 도움말의 한계 고지 정도다. dataroom의 assessment structure는 **레벨마다 필요한 증거를 선언**하고 있으므로, "이 레벨은 A·B·C를 요구하는데 데이터룸에서 A만 찾았고 B·C는 없다"를 그대로 렌더할 수 있다. 이건 구조적 이점이며, 실사에서 실제로 가치 있는 산출물은 판정이 아니라 **요청 리스트(누락 문서 목록)** 다.
4. **인용은 번호 각주 대신 "소스타입 칩 + 결정적 구절 하이라이트"로.** AlphaSense가 `"…slower CapEx growth due to higher financing costs." [Investor Transcripts ›]` 형태로 보여주듯, 칩에 **문서 종류**(감사보고서 / 투자심의자료 / 계약서 / 이메일)를 넣으면 리뷰어가 링크를 열기 전에 증거의 급(級)을 판단한다. 실사에서는 "출처가 어디냐"보다 "그게 감사받은 서류냐 경영진 덱이냐"가 더 중요하므로, 이 변형이 dataroom에 더 잘 맞는다.
5. **셀/파인딩 단위의 `Verify content / Assign reviewer / Re-run`을 반드시 넣어라.** Hebbia가 셀 컨텍스트 메뉴로 이걸 제공하고 셀 위에 협업자 커서까지 띄우는 건, **AI 출력을 "검토 대기 항목"으로 강등**시키는 장치다. 수탁자 맥락에서 이건 장식이 아니라 워크플로의 핵심이다 — 화면이 "누가 아직 확인 안 했는가"를 보여줘야 리뷰어가 일을 건너뛰지 않는다. 미확인 파인딩과 인간 검증 완료 파인딩을 **시각적으로 다르게** 그려야 한다.
6. **평가 근거 드릴다운은 Elicit 모달 구조를 그대로 가져와라.** 좌=추출된 발견(각 항목에 번호 배지) / 우=원문 문서 렌더 + 페이지 번호 + 근거 문장 틴트 블록 + `← n of m →` 페이저 + 전체 문서 열기. 특히 **`n of m` 페이저**가 중요한데, 하나의 sub-indicator에 근거가 3건 있으면 "3건이 있고 지금 2번째를 보고 있다"를 알려 줘야 리뷰어가 근거의 두께를 체감한다. 근거가 1건뿐이면 `1 of 1`이 그 자체로 약한 근거라는 신호가 된다.
7. **"무엇을 검색했는지"를 결과와 함께 남겨라 — 그러나 접어서.** AlphaSense의 계획 문장 + 검색 범위 칩(`Caterpillar Inc` `ESG` `Presentations` `+16`)이 dataroom에 직역된다: "이 criterion을 위해 데이터룸의 재무/법무 폴더 42개 문서를 검색했고 그 중 6개를 인용함". 동시에 AlphaSense가 `Skip, View Fast answer` 탈출구를 둔 것처럼 **기본은 접힘**이어야 한다. 그리고 Harvey처럼 프롬프트/결과 헤더에 **데이터룸 스코프 칩**을 상시 노출해, 이 평가가 어떤 문서 집합 위에서 나온 것인지 화면에서 사라지지 않게 하라.

---

## 4. 확보 실패

로그인 없이 실제 UI를 볼 수 없었던 것들. 공백을 그대로 남긴다.

| Product | 시도한 것 | 결과 |
|---|---|---|
| **Consensus** | `consensus.app/results/?q=…` 직접 접근 (2회, 최대 75초 대기) | 1차: Cloudflare "Performing security verification" 인터스티셜. 실제 UA로 재시도 시 통과했으나 답변 스트림이 `Pro · Formulating…` 에서 무한 대기 — 비로그인 세션에는 결과가 렌더되지 않음. **Consensus Meter(찬/반/중립 집계 바)를 확보하지 못함** — 확신도 표현 사례로 가장 아쉬운 누락 |
| **NotebookLM** | `notebooklm.google` / `support.google.com/notebooklm` / 공개 featured notebook 링크 탐색 | `notebooklm.google` → `notebook.google`(Gemini Notebook으로 리브랜딩) 301. 마케팅 페이지는 추상 일러스트뿐, 실제 UI 없음. 헬프센터 FAQ에도 스크린샷 없음. 공개 featured notebook의 직접 URL을 로그인 없이 확보 실패. **인라인 인용 칩 → 소스 패널 스크롤 동작 미확인** |
| **Glean** | `glean.com/product/assistant` | 페이지는 뜨나 `Glean:GO 2026` 전면 모달이 원하는 섹션을 덮음. 페이지 자체도 추상 일러스트 위주로 인용 UI 없음 |
| **Dust** | `dust.tt/home` 전체 캡처 | 실제로 캡처했으나 인용/근거 관련 UI가 전혀 없어 삭제 |
| **Claude / ChatGPT document modes** | 공개 surface 탐색 | 둘 다 파일 업로드 후 인용된 답변을 보려면 로그인 필요. 공개 공유 링크 중 문서 기반 인용 사례를 찾지 못함. **미확보** |
| **V7 Go** | `v7labs.com/go`, `docs.v7labs.com/docs/confidence-scores` | 전자는 제품 그리드 UI 없는 리브랜딩 페이지, 후자는 404. **셀별 confidence score UI라는 유일한 반례 후보를 확인 못 함** |
| **Hebbia / Harvey / Rogo / AlphaSense in-app** | 로그인 필요 | 모두 데모 요청 게이트. 마케팅 페이지·공식 블로그·헬프센터에 임베드된 실제 제품 스크린샷으로 대체함(위 표의 캡처는 전부 그 경로) |

### 위 공백이 남긴 미확인 질문

- 인용 칩 클릭 시 **원문 문서가 해당 문단까지 자동 스크롤/하이라이트되는지** — Hebbia는 카피로 주장("exact sentence")하나 동작은 미확인. Elicit만 정적 스크린샷으로 근접 사례를 확인했다.
- **수치 confidence를 노출하는 제품이 실제로 존재하는지** — V7 Go가 가장 유력한 후보였으나 확인 실패. 확인한 범위에서는 "없음"이 결론이다.
- **"근거 없음" 전용 UI 상태**가 실제로 구현된 제품 — 확인한 범위에서는 없음.
