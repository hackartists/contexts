# 01 — AI-Native & Agentic UX (2026+ only)

Collected 2026-09-22. Hard constraint applied: every file below is dated **2026-01-01 or later**,
verified against arXiv metadata (`<published>` field) or the publisher's own posted date.

| File | Title | Publisher | Published | Size | Source URL |
|---|---|---|---|---|---|
| `2026-01_arxiv_agentic-design-patterns-system-theoretic-framework.pdf` | Agentic Design Patterns: A System-Theoretic Framework | arXiv (cs.HC / cs.AI) | 2026-01-27 | 1.2M | https://arxiv.org/abs/2601.19752 |
| `2026-05_arxiv_design-principles-for-human-agent-interaction.pdf` | Design Principles for Human-Agent Interaction | arXiv (cs.HC) | 2026-05-28 | 1.3M | https://arxiv.org/abs/2606.20630 |
| `2026-05_arxiv_macaron-a2ui-generative-ui-personal-agents.pdf` | Macaron-A2UI: A Model for Generative UI in Personal Agents | arXiv (cs.HC) | 2026-05-24 | 3.7M | https://arxiv.org/abs/2605.24830 |
| `2026-05_arxiv_mist-multimodal-speech-tool-calling-assistants.pdf` | MIST: Multimodal Interactive Speech-based Tool-calling Conversational Assistants for Smart Homes | arXiv (cs.HC) | 2026-05-07 | 3.6M | https://arxiv.org/abs/2605.06897 |
| `2026-06_arxiv_rethinking-the-ui-of-genui.pdf` | Rethinking the UI of GenUI: A Tale of Two Designs | arXiv (cs.HC) | 2026-06-11 | 3.3M | https://arxiv.org/abs/2606.13843 |
| `2026-06_speakerdeck_agentic-ui-ag-ui-a2ui.pdf` | Agentic UI (AG-UI & A2UI protocols) — 39-slide conference deck | Speaker Deck / Manfred Steyer (ANGULARarchitects) | 2026-06-08 | 3.8M | https://speakerdeck.com/manfredsteyer/agentic-ui |
| `2026-07_arxiv_ux-principles-human-ai-agent-interaction-workplace.pdf` | A Framework of User Experience Principles for Human-AI Agent Interaction in the Workplace | arXiv (cs.HC) | 2026-07-22 | 176K | https://arxiv.org/abs/2607.19941 |
| `2026-08_arxiv_legoui-transparency-controllability.pdf` | LEGOUI: Designing with UI-DSL Bricks to Balance Transparency and Controllability | arXiv (cs.HC) | 2026-08-04 | 24M | https://arxiv.org/abs/2608.04293 |
| `2026-09_arxiv_affora-design-system-agent-friendly-interfaces.pdf` | Affora: A Design System for Agent-Friendly Interfaces | arXiv (cs.HC) | 2026-09-16 | 3.1M | https://arxiv.org/abs/2609.19125 |
| `2026-09_arxiv_trust-by-design-trust-calibration-socratic-dialogue.pdf` | Trust by Design: Trust Calibration Through Non-Advisory Socratic Dialogue in Conversational Agents | arXiv (cs.HC) | 2026-09-13 | 4.0M | https://arxiv.org/abs/2609.14818 |
| `2026-09_arxiv_value-sensitive-delegation-everyday-ai-agent-use.pdf` | Value-Sensitive Delegation in Everyday AI Agent Use: Evidence from OpenClaw | arXiv (cs.HC) | 2026-09-18 | 752K | https://arxiv.org/abs/2609.22067 |
| `2026-09_arxiv_work-behind-delegation-supervising-ai-coding-agents.pdf` | The Work Behind Delegation: A Framework for Supervising AI Coding Agents | arXiv (cs.HC) | 2026-09-21 | 2.5M | https://arxiv.org/abs/2609.24234 |

**12 files · 51 MB total · all validated as real PDFs (`file` → "PDF document, version 1.7").**

> 참고: `2607.18257` (Assistant or Actor? — 위임 후회), `2608.25565` (Maru — 생성 UI 정보구조),
> `2605.02729` (컴퓨터-유즈 에이전트용 사용성 휴리스틱) 도 2026년 자료로 확인·다운로드했으나
> 위 12편과 주제가 중복되어 최종 목록에서 제외했습니다.

## 요약

- **2026년의 핵심 이동은 "결과물 UI"에서 "위임 조건 UI"로의 전환입니다.** OpenClaw 사용자 레딧 게시물 73,093건을 Value Sensitive Design으로 분석한 연구는, 사용자가 중요하게 여기는 21개 가치가 에이전트의 *산출물*이 아니라 실행 전후에 사용자가 설정하는 *운영 조건*(Bounded Reach, Reviewability, Dependable Operation 등)에 집중된다는 점을 보여줍니다. 산출물 관련 가치는 대체로 충족되지만, **감독(supervising) 관련 가치는 6개 가치군 전부에서 거의 충족되지 못했습니다** — 즉 2026년 에이전틱 UX의 최대 미해결 영역은 감독 인터페이스입니다.

- **신뢰는 "높이는 것"이 아니라 "보정(calibration)하는 것"으로 재정의되었습니다.** Trust by Design(2026-09)은 대화형 에이전트의 목표를 usability에서 trust calibration으로 옮기고, 에이전트가 스스로 권위를 제한하는 non-advisory 소크라테스식 대화로 적정 의존(appropriate reliance)을 설계합니다. 관련 2026 연구들은 사용자가 **에이전트 단위가 아니라 태스크 단위로 신뢰를 조정**한다는 점(되돌릴 수 없거나 외부에 노출되는 행동에는 확인을 요구)을 반복적으로 확인합니다.

- **생성형 UI(GenUI)는 "대화형 프롬프트 → 고충실도 한 방" 관행에 대한 반성기에 들어섰습니다.** Rethinking the UI of GenUI는 24명의 UX 디자이너/PM 대상 비교 연구에서, 비정형 프롬프트 + depth-first + high-fidelity 방식이 초기 0-to-1 탐색에 부적합함을 보이고 **구조화 입력 + breadth-first + 저충실도** 대안을 제시합니다. LEGOUI는 같은 문제를 UI-DSL 기반 단계별 파이프라인과 provenance 노출로 풀어, 블랙박스 생성을 **투명성·개입 가능성**으로 바꿉니다(요구사항 추출 정확도 95%+). Macaron-A2UI는 이를 개인 에이전트의 런타임 UI 생성 모델로 확장합니다.

- **"인터페이스의 사용자"가 사람만이 아니게 되었습니다.** Affora(2026-09)는 사람과 컴퓨터-유즈 에이전트 *양쪽* 모두를 독자로 삼는 디자인 시스템으로, 시각적 자유도를 유지하면서 행동 가능성과 태스크 상태를 기계가 읽을 수 있게 노출합니다. 핵심 발견은 **에이전트 성능이 픽셀이 아니라 인터페이스 표현에 담긴 "상호작용 의미(interaction meaning)"에 좌우된다**는 것 — 의미만 보존되면 시각 디자인은 크게 달라져도 무방합니다. 산업계 쪽에서는 AG-UI / A2UI 같은 에이전트-UI 프로토콜 표준화가 같은 방향으로 움직이고 있습니다(Speaker Deck 덱).

- **설계 지식이 원칙·패턴 형태로 정착되는 해입니다.** Design Principles for Human-Agent Interaction은 상호작용을 *초기 / 진행 중 / 장기 / 실패 시* 4단계로 나눈 **14개 원칙**을 제시하고 9개 실제 에이전트 시스템을 평가했으며, 워크플레이스 연구는 참여 디자인·전문가 리뷰·메타분석을 거쳐 검증된 **8개 UX 원칙**을 내놓습니다. 시스템 측에서는 Agentic Design Patterns가 에이전트를 추론·지각·행동·학습·커뮤니케이션 5개 하위시스템으로 분해한 **12개 패턴**을 정의합니다. 세 문서를 겹쳐 읽으면 "원칙(UX) ↔ 패턴(아키텍처)" 대응표를 만들 수 있습니다.

- **오류 복구와 중단 가능성이 별도 설계 대상으로 분리되었습니다.** The Work Behind Delegation(2026-09)은 AI 코딩 에이전트 감독에 드는 *보이지 않는 노동*을 프레임워크화하며, 위 원칙 문서들도 "things go wrong" 단계를 독립 설계 스테이지로 취급합니다. 멀티모달 쪽은 MIST가 음성 + 도구호출(tool-calling)을 결합한 대화형 어시스턴트를 다루지만, **음성/제스처 중심 연구는 여전히 에이전틱 위임 논의와 분리되어 있는 편**이라 2026년 현재 대화형 ↔ GUI 하이브리드 통제 패러다임은 아직 통합 이론이 없습니다.

## 수집 실패 / 제외

| 소스 | 사유 |
|---|---|
| Nielsen Norman Group — "State of UX 2026" 리포트 및 AI 에이전트 관련 2026 아티클 | 다운로드 가능한 PDF 없음. 전부 HTML 아티클이며 리포트는 유료/등록 기반. NN/g의 "intent-based outcome specification" 논의는 웹 페이지로만 존재 |
| ACM Digital Library — CHI 2026 프로시딩 | 대상 논문 다수가 open-access가 아니며 ACM 로그인/기관 인증 필요. 우회 시도하지 않음 |
| `arXiv:2509.20731` — Imagining Design Workflows in Agentic AI Futures | **2025년 9월** 자료로 2026+ 조건 미충족. 제외 |
| `arXiv:2510.17842` — Vibe Coding: Toward an AI-Native Paradigm | **2025년 10월**. 제외 |
| `arXiv:2511.00843` — Portal UX Agent | **2025년 11월**. 제외 |
| `arXiv:2504.10918` — Adaptive Human-Agent Teaming (리뷰 논문) | **2025년 4월**. 제외 |
| Gartner — "40% of enterprise apps will run task-specific AI agents by end of 2026" 예측 리포트 | 유료 구독 전용. 수치가 2차 인용으로만 유통되며 원문 PDF 접근 불가 |
| Medium / 디자인 에이전시 블로그 (Fuselab, Studio Maydit, knubisoft 등) "Agentic UX 2026 가이드" | HTML 전용, 다운로드 가능한 문서 없음. 또한 1차 연구가 아닌 요약성 콘텐츠 |
| SlideEgg "Agentic AI Framework" 19-slide 덱 | 상업용 템플릿 판매 사이트. 회원가입 필요하고 리서치 레퍼런스로서 가치 낮음 |
| IBM Design / Microsoft HAX / Google PAIR 2026 신규 백서 | 2026년에 새로 발행된 다운로드형 PDF를 찾지 못함. 기존 가이드라인은 전부 2025 이전 웹 문서 |
