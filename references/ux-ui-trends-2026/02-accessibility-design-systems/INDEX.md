# 02 — Accessibility Law/Standards & Design Systems (2026+ only)

Collected 2026-09-22. Hard filter: every kept file is verifiably dated **2026-01-01 or later**
(publication date confirmed from the document's own cover page, report date field, Federal Register
issue date, or arXiv submission stamp — not from the hosting page).

| File | Title | Publisher | Published | Size | Source URL |
|---|---|---|---|---|---|
| `2026-04_us-doj_ada-title-ii-compliance-date-extension-ifr.pdf` | Extension of Compliance Dates for Nondiscrimination on the Basis of Disability; Accessibility of Web Information and Services of State and Local Government Entities (Interim Final Rule, 28 CFR Part 35) | U.S. Department of Justice / Federal Register (91 FR, No. 75) | 2026-04-20 | 368K | https://www.govinfo.gov/content/pkg/FR-2026-04-20/pdf/2026-07663.pdf |
| `2026-05_us-hhs_section-504-web-accessibility-compliance-date-extension.pdf` | Extension of Compliance Dates for Nondiscrimination on the Basis of Disability; Accessibility of Web Content and Mobile Applications of Recipients of Departmental Financial Assistance | U.S. Department of Health and Human Services / Federal Register | 2026-05-11 | 368K | https://www.govinfo.gov/content/pkg/FR-2026-05-11/pdf/2026-09266.pdf |
| `2026-09_etsi_en-301-549-v4-1-1-harmonised-standard.pdf` | EN 301 549 V4.1.1 — Accessibility requirements for ICT products and services (Harmonised European Standard) | ETSI / CEN / CENELEC | 2026-09 (cover page: "V4.1.1 (2026-09)") | 3.8M | https://www.etsi.org/deliver/etsi_en/301500_301599/301549/04.01.01_60/en_301549v040101p.pdf |
| `2026-04_h5p_accessibility-conformance-report-vpat-2-5-int.pdf` | H5P Group Accessibility Conformance Report, International Edition (VPAT® 2.5 INT — WCAG 2.2 A/AA + Section 508 + EN 301 549) | H5P Group | 2026-04-24 (report date field) | 988K | https://h5p.com/pdfs/h5p-vpat-april-2026.pdf |
| `2026-05_arxiv_llm-web-accessibility-systematic-review.pdf` | Large Language Models for Web Accessibility: A Systematic Literature Review | Aljedaani et al. (SDAIA / Univ. of North Texas), arXiv:2605.13873 | 2026-05-06 | 728K | https://arxiv.org/pdf/2605.13873 |
| `2026-06_arxiv_a11yrepair-web-accessibility-repair.pdf` | A11YRepair: Bridging Web Accessibility Barriers via Knowledge-Enhanced Divide-and-Conquer Repair | Huang et al. (TU München), arXiv:2606.21926 | 2026-06-20 | 4.5M | https://arxiv.org/pdf/2606.21926 |
| `2026-07_arxiv_ai-prototyper-figma-plugin-llm-gui-prototyping.pdf` | AI Prototyper: A Figma Plugin for Decomposition-Based GUI Prototyping with LLMs | Salangsingha et al. (Edinburgh Napier Univ.), arXiv:2607.14830v2 | 2026-07-17 | 924K | https://arxiv.org/pdf/2607.14830 |
| `2026-07_arxiv_detecting-ui-principle-violations-rl.pdf` | Learning to Detect UI Principle Violations via Reinforcement Learning | Mehta et al. (UC Santa Cruz / CMU), arXiv:2607.20690v2 | 2026-07-22 (v2 2026-08-04) | 800K | https://arxiv.org/pdf/2607.20690 |
| `2026-08_arxiv_legally-mandated-still-inaccessible-norway.pdf` | Legally Mandated, but Still Inaccessible: Digital Tensions in Older Adults' Use of Norwegian Web Services | Inal et al. (NTNU), arXiv:2608.12552 | 2026-08-12 | 460K | https://arxiv.org/pdf/2608.12552 |

**9 files, 13 MB total.**

## 요약

- **EN 301 549가 v4.1.1로 갱신되었고, 표지 날짜는 2025년 9월이 아니라 `2026-09`다.** ETSI/CEN/CENELEC이 2026-08-24 채택, 2026-09-02 공개했으며 웹(9장)·문서(10장)·소프트웨어(11장) 요구사항 기준이 WCAG 2.1 → **WCAG 2.2 Level A/AA**(ISO/IEC 40500:2025 참조)로 상향되었다. 다만 **아직 EU 관보(OJ)에 인용되지 않아 EAA/WAD의 법적 적합성 추정(presumption of conformity) 기준은 여전히 v3.2.1(2021)** 이다 — 2026년 하반기 EU 컴플라이언스 문서의 핵심 함정.
- **미국은 2026년에 두 개의 웹접근성 의무 시행일이 모두 1년씩 밀렸다.** DOJ는 2026-04-20 잠정최종규칙(IFR)으로 ADA Title II 준수기한을 인구 5만 이상 지자체 2026-04-24 → **2027-04-26**, 소규모·특별구 2027 → **2028-04-26** 으로 연기했다(기술기준은 WCAG 2.1 AA 유지, 의견수렴 2026-06-22 마감). HHS도 2026-05-11 동일 취지로 Section 504 수혜기관의 기한을 연장했다. 즉 **기준은 그대로이고 일정만 늦춰진** 구조라, "연기 = 완화"로 읽으면 안 된다.
- **WCAG 3.0은 2026-09-10자 W3C 워킹 드래프트가 최신이며, 적합성 모델이 "단일 conformance level + 상·하위 리포팅 tier"로 제안됐다.** 다만 여전히 Working Draft 단계(CR 2027 Q4 목표, Recommendation은 2028년 이후 전망)이고 W3C는 WCAG 2.x를 폐기하지 않겠다고 밝혔으므로, **2026년 계약·조달 문서에서 구속력 있는 기준은 계속 WCAG 2.1/2.2 AA**다.
- **접근성 적합성 보고(VPAT/ACR)는 템플릿 자체보다 "WCAG 2.2 기반 재작성"이 2026년의 실제 변화다.** ITI VPAT 템플릿은 2.5(2025-04)에서 멈춰 있고 2.6은 아직 없다. 대신 2026년 발행 ACR들은 VPAT 2.5 **INT** 판을 써서 WCAG 2.2 + Section 508 + EN 301 549를 한 문서로 커버하는 형태가 표준이 됐다(수집한 H5P ACR이 그 전형).
- **현장 데이터는 오히려 역행 중이다.** WebAIM Million 2026 기준 상위 100만 홈페이지의 **95.9%가 WCAG 실패**(2025년 94.8%에서 악화), 페이지당 평균 오류 56.1개(+10.1% YoY), 페이지 요소 수는 1년 만에 +22.5%. 실패 유형 상위 6개(대비, 레이블 누락, 빈 버튼, alt 누락 등)는 7년째 동일하다 — 즉 규제 강화보다 UI 복잡도 증가 속도가 더 빠르다.
- **디자인 시스템 쪽 2026년 화두는 "AI가 읽을 수 있는 디자인 시스템"과 자동 거버넌스다.** 학계에서도 Figma 플러그인 기반 LLM 프로토타이핑(AI Prototyper), 생성된 프런트엔드 코드의 **UI 원칙/접근성 위반을 RL로 자동 검출**, 접근성 위반의 LLM 자동 수리(A11YRepair) 연구가 2026년에 몰려 나왔다. 반면 토큰 포맷 표준(W3C DTCG)은 2025.10 이후 2026년 신규 릴리스가 없어, **표준은 정체·적용은 AI 워크플로 쪽으로 이동**하는 양상이다.

## 수집 실패 / 제외

### 날짜 때문에 제외 (pre-2026)

| 대상 | 사유 |
|---|---|
| WCAG 2.2 (W3C Recommendation, 2023-10 / 2024-12 개정) | 2023년 표준. 2026+ 요건 미충족. 단 EN 301 549 v4.1.1이 이를 참조하므로 실질 기준으로는 살아 있음. |
| W3C Design Tokens Format / Color / Resolver Module **2025.10** | 첫 stable 릴리스가 2025-10-28. 2026년 후속 릴리스 없음. 게다가 HTML 전용. |
| ITI VPAT® 2.5 템플릿 (508 / WCAG / EU / INT 판, .doc) | 2025-04 발행. 2026년판(2.6) 미존재. |
| ITU, *Strategic mainstreaming of ICT accessibility for an inclusive digital transformation* | 사이트 경로는 `/2026/02/` 지만 **문서 판권면이 "© ITU 2025 / Geneva, 2025"** → 제외. PDF는 내려받아 확인 후 삭제함. |
| AccessibleEU *Accessibility Indicators Annual Report 2025* (Finland/Poland/Portugal/Romania 등) | 2026-09에 게시됐으나 문서 자체가 **2025 보고연도**이고 본문 내 2026 날짜가 전혀 없음 → 규칙대로 제외. |
| AccessibleEU *Getting to know the European legislation on accessibility* | PDF 메타데이터 CreationDate가 2024-03, 본문 최신 인용 2025-06. 2026 확정 불가 → 제외. |
| EUD, *Report on the implementation of the European Accessibility Act* (D2.4) | 2025-06 발행. |
| ETSI EN 301 549 **V4.1.0** final draft (2026-06) | 2026년이긴 하나 V4.1.1에 의해 대체된 투표용 초안이라 중복 → 미수집. |

> **EN 301 549 v4.1.1에 대한 정정:** 과업 지시에는 "v4.1.1은 2025년 9월 발행이므로 부적격"이라고 되어 있었으나, **ETSI 원문 표지는 `EN 301 549 V4.1.1 (2026-09)`** 이다(ESO 채택 2026-08-24, 공개 2026-09-02). PDF를 직접 내려받아 표지에서 확인했으므로 **적격으로 판단해 수집**했다. 2025-09에 나온 것은 v4.1.1이 아니라 이전 버전 계열이다.

### 2026년 자료지만 PDF/PPTX가 존재하지 않아 제외 (HTML 전용)

| 대상 | 비고 |
|---|---|
| **W3C WCAG 3.0 Working Draft (2026-09-10)** | 본 수집에서 가장 아쉬운 항목. W3C TR은 HTML만 제공하며 공식 PDF 없음. https://www.w3.org/TR/wcag-3.0/ · 공지: https://www.w3.org/WAI/news/2026-09-10/wcag3/ |
| **WebAIM Million 2026 report** | HTML 전용, PDF 배포본 없음. https://webaim.org/projects/million/ |
| GSA **FY2025 Governmentwide Section 508 Assessment** (2026-03-02 의회 제출) | FY23·FY24는 PDF가 있으나 FY25는 HTML/Reading View만 제공. 추정 경로 3종 probe 모두 404. |
| EU **Rolling Plan for ICT Standardisation 2026** — Accessibility 챕터 | Interoperable Europe 포털 HTML 전용, PDF 배포본 없음. |
| **Material 3 Expressive** (Google) / **Apple Liquid Glass (HIG)** | 두 플랫폼 디자인 언어 모두 2026년 시점에 웹 문서·디자인 리소스 형태로만 제공. 공식 PDF/PPTX 스펙 배포본 없음. |
| W3C DTCG 기술 리포트 | HTML 전용. |

### 게이트/유료로 제외 (우회 시도하지 않음)

| 대상 | 사유 |
|---|---|
| **zeroheight, Design Systems Report 2026** (5회차, 실무자 147명) | `report.zeroheight.com/download` 에서 이메일 폼 제출 필요. |
| **Level Access / G3ict / IAAP, State of Digital Accessibility Report (8th Annual, 2026)** | 본문은 HTML 챕터로 공개되나 리포트 원본은 "Unlock the report" 폼 게이트. |
| **Into Design Systems / AI Design Systems Conference 2026** (2026-03-19~20, "Encoding governance on agentic design systems", "Building real design systems with agents" 등) | 슬라이드·자료가 유료 녹화 패키지에만 포함. 공개 PDF 없음. |
| Speaker Deck / Notist 2026 디자인 시스템 덱 | 검색 결과 2026년 등록 덱 자체가 확인되지 않음(상위 결과 모두 2019~2021년). |
