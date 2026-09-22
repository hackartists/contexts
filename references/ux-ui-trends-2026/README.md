# UX/UI Trends 2026 — Reference Library

2026년 UX/UI 트렌드 조사를 위해 수집한 1차 자료 모음.

- **수집일**: 2026-09-22
- **수집 기준**: **2026-01-01 이후 발행**이 문서 자체(표지·판권면·Federal Register 호수·arXiv 접수 스탬프)로 확인된 것만. 호스팅 페이지의 날짜나 제목의 "2026"은 근거로 인정하지 않음.
- **규모**: 30개 PDF / 약 166 MB

## ⚠️ 원문 파일은 git 에서 제외됨

리포지터리 경량 유지를 위해 `*.pdf` 등 바이너리는 루트 `.gitignore` 로 제외했습니다.
**버전 관리되는 것은 이 README 와 각 그룹의 `INDEX.md` 뿐입니다.**
다른 머신에서 원문이 필요하면 각 `INDEX.md` 의 소스 URL 로 다시 내려받으세요.

> 예외: 최초 수집분 13개 PDF 는 `.gitignore` 적용 전에 watchdog 이 자동 커밋·push 해버려
> 히스토리에 남아 있습니다(`494efc1`, `a445b1f`). 히스토리 rewrite 는 하지 않기로 결정했습니다.

## 구성

| 그룹 | 주제 | 파일 | 용량 |
|---|---|---|---|
| [`01-ai-agentic-ux/`](01-ai-agentic-ux/INDEX.md) | AI-native / agentic UX, 생성형 UI, 위임·감독·신뢰 | 12 | 51 MB |
| [`02-accessibility-design-systems/`](02-accessibility-design-systems/INDEX.md) | 접근성 법령·표준(EAA/ADA/EN 301 549), 디자인 시스템 | 9 | 13 MB |
| [`03-industry-trend-reports/`](03-industry-trend-reports/INDEX.md) | 산업 트렌드·소비자 조사 리포트 | 9 | 102 MB |

구성별 상세 목록·요약·제외 사유는 각 `INDEX.md` 참조.

## 수집 과정에서 확인된 주요 사실 (통념과 다른 것들)

1. **EN 301 549 v4.1.1 은 2025-09 가 아니라 `2026-09` 문서다.** 표지에 `V4.1.1 (2026-09)` 로 찍혀 있고 본문 WCAG 언급이 2.2 461회 / 2.1 9회로 기준선이 **WCAG 2.2 A/AA 로 상향**됐다. 다만 문서 자체가 *"**Once** the present document is cited in the Official Journal..."* 라고 쓰고 있어 **EU 관보 등재 전**이며, EAA/WAD 의 법적 적합성 추정 근거는 **여전히 v3.2.1(2021) → WCAG 2.1 AA**.

2. **미국의 "2026년 4월 마감"은 사라졌다.** DOJ 잠정최종규칙(91 FR No.75, 2026-04-20)으로 ADA Title II 기한이 2026-04-24 → **2027-04-26**, 소규모 기관은 → **2028-04-26** 으로 연기. HHS 도 Section 504 에 동일 조치(2026-05-11). **기술 기준(WCAG 2.1 AA)은 불변** — "연기 = 완화"가 아님.

3. **유명한 "2026" 리포트 상당수가 실제로는 2025년 발행이라 제외됐다.** Accenture Life Trends 2026(PDF 생성 2025-11-12, ©2025), Qualtrics 2026 CX Trends(2025-10-06), Accenture Macro Foresight 2026 Outlook(표지 "December 16, 2025"), NIA 「2026년 12대 AI·디지털 트렌드」(게시 2025-12-30), Deloitte Tech Trends 2026 등. 제목의 연도를 근거로 삼으면 안 되는 이유.

## 알려진 공백

- **McKinsey Technology Trends Outlook 2026**(2026-09, 6th ed.)과 **Adobe 2026 Creative/Digital Trends** — `www.mckinsey.com`, `business.adobe.com` 두 호스트가 이 환경에서 HTTP/2 `INTERNAL_ERROR` 로 전면 차단됨. 정확한 PDF URL 은 `03/INDEX.md` 에 기록해뒀으니 다른 네트워크에서 재시도 가능.
- **HTML 전용이라 수집 불가**: W3C WCAG 3.0 워킹드래프트(2026-09-10), WebAIM Million 2026, Material 3 Expressive, Apple Liquid Glass HIG, NN/g, IBM Design, Microsoft HAX, Google PAIR. → 본문에서 이 출처들의 수치를 인용할 때는 **코퍼스 근거가 아님**을 명시할 것.
- **폼 게이트/유료**: zeroheight Design Systems Report 2026, Level Access SODAR, Gartner, Into Design Systems 2026 덱. 우회 시도하지 않음.
- **2026년 컨퍼런스 덱 카테고리는 공집합** — Config/Awwwards/UX London 의 2026 자료가 SlideShare/Speaker Deck/Notist 에 없음(Awwwards 는 인터랙티브 웹 전용).
- **Zero-click / Zero UI**: 30편 전체에서 해당 용어 **0회**. 업계·SEO 담론 용어라 학술·법령 중심 코퍼스에 구조적으로 안 잡힘. 인접 실증은 오픈서베이 AI 검색 리포트가 대체.

## 날짜 관련 단서 (인용 시 주의)

- `2026-01_http-archive_web-almanac-2025.pdf` — **발행은 2026-01-15 이지만 데이터는 2025-07 크롤 기준**이고 제목도 *2025* Web Almanac.
- `2026-03_figma_state-of-the-designer-2026.pdf` — 발행 2026-03 이나 **설문 현장조사는 2025년 9~10월**.
- `2026-01_kidp_cmf-design-trend-report-2026-2027-ko.pdf` — KIDP 공개일 2026-01-21, **PDF 내부 생성일은 2025-12-12**.
- Figma 리포트 원본은 이메일 폼 게이트라 **공개 미러에서 취득**. 두 URL 모두 `03/INDEX.md` 에 기록.
