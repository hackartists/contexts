# VDR / Due-Diligence Platform UI References

조사일: 2026-09-22 · 캡처 도구: Playwright 1.63 (chromium, 1440×900 viewport, full-page, lazy-load 스크롤 + 쿠키/채팅 오버레이 제거)

수집 방식: 제품 UI는 대부분 로그인 뒤에 있으므로 **공개 마케팅 페이지에 임베드된 실제 제품 스크린샷 + 공개 헬프센터(Intercom/Zendesk) 문서의 실제 화면 캡처**를 대상으로 했다. 로그인/가입/우회는 일절 하지 않았다.

파일은 두 종류다.
- **`*_<화면>.png` (crop)** — 실제로 UI가 보이는 부분만 잘라낸 것. 실질적인 레퍼런스.
- **`*_<페이지>.png` (full-page)** — 출처 페이지 전체. 문맥·URL 증빙용.

실제 제품 UI가 담긴 유효 캡처: **16장** (+ 일러스트 1장, + 문맥용 full-page 10장).

---

## 1. 캡처 목록

### 실제 제품 UI (crop)

| Screenshot | Vendor | URL | What pattern it shows |
|---|---|---|---|
| `dealroom_request-list-table-detail.png` | DealRoom | https://dealroom.net/product/diligence | 실사 요청 리스트. 14컬럼 그룹핑 테이블, 그룹 헤더에 `n/m` + 진행바, 행높이 ~27px |
| `intralinks_dealcentre-document-requests.png` | Intralinks (SS&C) / DealCentre AI | https://www.intralinks.com/resources/product-releases/dealcentre-ai-vdrpro-investorvision-product-enhancements | Document Requests 화면. 상단 4개 KPI 스트립, 컬럼별 필터 아이콘, 우측 세로 `Filters`/`Columns` 드로어 탭 |
| `firmex_three-pane-index-table-metadata.png` | Firmex | https://www.firmex.com/virtual-data-room/ | **3-pane**: 인덱스 트리 ｜ 번호 매겨진 문서 테이블 ｜ 우측 메타데이터/코멘트 인스펙터 |
| `firmex_documents-tab-index-tree.png` | Firmex | https://support.firmex.com/hc/en-us/articles/204467578-Reviewing-documents-efficiently | Documents 탭. QUICK VIEW / INDICES 2단 좌측 패널, `No.` 컬럼, 드래그 그립 |
| `firmex_all-documents-flat-index-numbers.png` | Firmex | 위와 동일 | 트리를 버린 **플랫 뷰**. `Index ｜ Folder ｜ No.(5.1/2.1/3.1) ｜ Name ｜ Version ｜ Date Added` |
| `ansarada_document-index-topbar-nav.png` | Ansarada | https://help.ansarada.com/en/articles/2597706-recent-documents | Document index 상단바(Filter/Search/Bulk download/Actions) + 좌측 `View` 메뉴, 적용 필터 칩 |
| `ansarada_document-index-numbering.png` | Ansarada | https://help.ansarada.com/en/articles/2597663-preview-pdfs | 인덱스 트리의 **제로패딩 번호 체계** `01 / 02 / 03 / 03.01`, 행 인라인 Download 액션 |
| `ansarada_advanced-search-panel.png` | Ansarada | https://help.ansarada.com/en/articles/2597682-how-to-search-for-documents | 인라인 고급검색 패널. Full text / Name and number 탭, Fuzziness 0–5, 폴더 스코프 체크박스 테이블 |
| `ansarada_qa-view-questions.png` | Ansarada | https://help.ansarada.com/en/articles/2599609-ask-questions-in-one-way-q-a | Q&A `View questions`. All/Your 세그먼트 토글 + Subject/Priority/Status 3필터 + 빈 상태 |
| `ansarada_view-as-team-filter.png` | Ansarada | https://help.ansarada.com/en/articles/5372315-what-can-they-view-view-as | **View as** 드롭다운 (`WHAT CAN THEY SEE` + 팀 목록). 권한을 매트릭스가 아니라 impersonation 필터로 노출 |
| `box_preview-annotation-activity-sidebar.png` | Box | https://www.box.com/collaboration/virtual-data-room | 문서 프리뷰 오버레이 + 페이지 앵커 주석 + 우측 Activity 레일(아이콘 레일로 패널 전환, 코멘트에 `Page 6` 딥링크) |
| `ideals_dashboard-activity-analytics.png` | iDeals | https://www.papermark.com/blog/best-virtual-data-rooms-for-due-diligence | Dashboard. KPI 카드 3개(선택 상태=탭 역할), 참가자 퍼널 바, 도넛 + 일자별 바, `Participants by activity` 확장 테이블 |
| `digify_analytics-overview.png` | Digify | 위와 동일 | Analytics overview. 4개 수치 셀(큰 숫자 + 소문자 대문자 라벨 + ⓘ), 세그먼트형 필터 입력 그룹 |
| `caplinked_insights-activity-report.png` | CapLinked | https://www.caplinked.com/virtual-data-room/ | Insights. 좌측 리포트 목록, 파란 탭 스트립(VIEW FILE DATA / VIEW USER DATA), Group Rankings, 파일별 `Time Viewed / Viewed Count / Downloaded Count` |
| `papermark_data-room-folder-view.png` | Papermark | https://www.papermark.com/blog/intralinks-overview-features-pricing | shadcn 계열 VDR. 좌 아이콘 레일 + 폴더 트리 + 폴더 **카드** 리스트(`Add Document / Add Folder / Edit index`) |
| `papermark_group-permissions-per-row-toggles.png` | Papermark | https://www.papermark.com/data-room | 그룹 권한 화면. `All Groups > Management Team` 브레드크럼 + General/Members/Permissions 서브탭 + 행별 eye/download 아이콘 토글 |

### 일러스트(실 스크린샷 아님, 패턴 참고용)

| Screenshot | Vendor | URL | 비고 |
|---|---|---|---|
| `digify_page-analytics-and-permissions.png` | Digify | https://digify.com/virtual-data-room.html | Page Analytics(뷰어 리스트 ↔ 페이지별 체류 바차트)와 Granular Permissions(✓/✗/빈칸 3-state 매트릭스). **양식화된 일러스트** |

### 문맥용 full-page 캡처

`ansarada_data-room-product.png`, `ansarada_help-*.png`(5), `box_virtual-data-room.png`, `caplinked_vdr.png`, `dealroom_diligence-request-list.png`, `dealroom_ma-platform.png`, `digify_virtual-data-room.png`, `firmex_kb-reviewing-documents.png`, `firmex_vdr-product.png`, `intralinks_release-notes-ui.png`, `intralinks_vdrpro-*.png`(3, **이미지 없는 텍스트 문서** — 패턴 근거로만 사용), `papermark_*.png`(3)

---

## 2. 패턴 정리

### 2.1 문서 브라우징 — 트리 vs 테이블

- **Firmex**: 좌측 고정폭(≈250px) 패널이 위아래 2블록. 위는 `QUICK VIEW`(All Documents / New Documents / Unread Documents / New Since / Encrypted Documents / Offline Documents = 저장된 필터), 아래는 `INDICES` → 인덱스명(`Due Diligence`) → `Overview` → 번호가 **라벨 안에 박힌** 자식(`1. Articles of Incorporation`, `2. Shareholder Meetings` …). 선택 노드는 연한 채움 + 주황 좌측 4px 바.
- **Firmex 플랫 뷰**: `All Documents`를 고르면 트리를 버리고 테이블에 `Index`(어느 인덱스인지)·`Folder`(폴더명 링크)·`No.`(`5.1`, `2.1`) 컬럼을 추가한다. 즉 **깊은 계층을 트리로 안 보여주고 컬럼으로 평탄화**한다.
- **Ansarada**: 트리 하나만 쓴다. `⌄ Document Index / › 01 Overview / › 02 Employment / ⌄ 03 Corporate Structure… / 03.01 Ellipsis Iron Limited Corporate Structure 2…`. 번호는 회색, 제목은 검정으로 같은 줄에서 **색·굵기로만** 분리. 파일 행 우측에 `⤓ Download` 인라인 액션.
- **Intralinks VDRPro**: 좌측 pane에 `Expand All Folders`, 우측 pane에 내용. 퀵필터는 `All Documents / Favorites / Recent / Deleted Documents / Approval Requests / Redacted Documents`. 컬럼은 `Manage Columns` 아이콘(리스트 우상단)으로 on/off + **드래그로 순서 변경**.
- **Papermark**: 좌측 폴더 트리 + 우측은 테이블이 아니라 **폴더 카드 리스트**(1px 보더, 라운드, 폴더 아이콘, 볼드 이름, `Nov 18, 2024 • 3 Documents • 0 Folders` 메타 한 줄, 우측 `⋮`). 카드 높이 ≈72px, 간격 12px. 밀도가 확연히 낮다.
- **Box**: 파일 브라우징 UI는 공개 페이지에 dense하게 안 나온다. 대신 프리뷰/주석이 전면에 나옴.
- **벌크 액션**: Firmex/DealRoom/Intralinks 모두 행 맨 앞 체크박스 + 헤더 전체선택. Ansarada는 체크박스 대신 상단바 `Bulk download` / `Actions` 메뉴. Firmex는 행 맨 앞에 6점 **드래그 그립**이 별도로 있어 체크박스와 재정렬을 분리했다.

### 2.2 문서 뷰어 — 메타데이터/주석과의 배치

- **Firmex = 3-pane.** 좌 인덱스 트리 ｜ 중앙 문서 테이블 ｜ 우 메타데이터 인스펙터(≈250px). 인스펙터는 헤더에 선택 항목명(`📁 Shareholder Meetings`), 접히는 섹션 `DETAILS`(Status / `Add Status`, Description / `Add Description +`), `COMMENTS (0)`, `TAGS (0)`. 카운트가 0이어도 섹션을 지우지 않고 `(0)`으로 남겨둔다.
- **Box = 전면 오버레이 + 우측 레일.** 문서 프리뷰가 화면 전체를 덮고, 우측에 ≈380px 사이드바. 사이드바 안쪽에 또 세로 아이콘 레일(코멘트/파일정보/메타데이터/Box Sign/Slack/Zoom/Adobe/…)이 있어 아이콘으로 패널을 바꾼다. Activity 피드는 `uploaded v1 - v4` 같은 시스템 칩 + 사람 코멘트가 섞이고, 각 코멘트 하단에 파란 **`Page 6`** 딥링크. 선택된 코멘트는 주황 좌측 바 + 연파랑 배경. 문서 위에는 주석 영역이 주황 사각형으로 표시되고, 꼬리 달린 팝오버 컴포저(텍스트 + `Cancel` / `Post`)가 그 영역에 앵커된다. 하단 좌측에 떠 있는 다크 툴바(줌 %, 전체화면, 하이라이트, 영역 코멘트, 텍스트 선택).
- **Intralinks VDRPro 뷰어**(텍스트 문서 근거, 스크린샷 없음): 브라우저 인뷰어. `Search`는 **좌측 패널에 히트 목록**을 띄우고 클릭하면 **우측 패널에 해당 페이지** 표시(case sensitive / whole word / wildcard 옵션). `Quick Access Panel`은 페이지를 아이콘(썸네일) 격자로 보여주고 클릭 시 우측에 표시. 그 외 View Controls(페이지 전환/레이아웃/회전), Pan, Select, Zoom, Maximum/Minimum, Download.
- **Ansarada는 정반대.** PDF는 **새 창 브라우저 프리뷰**이고, 헬프 문서에 "Search, edit, print, comments are not available when previewing PDFs"라고 명시. 즉 뷰어를 주석 표면으로 안 쓴다. 150MB 이하만 프리뷰.

### 2.3 인덱스 / 번호 체계

- **Intralinks VDRPro**가 가장 명시적이다: 번호 포맷은 `2.1.2.16` — 첫 숫자는 최상위 폴더, 이후 각 소수 자리는 하위 폴더, 마지막 자리는 폴더 내 위치. 번호는 **연속**이며 이동/삭제/삽입 시 자동 재인덱싱되어 중복·구멍이 없다. 인덱싱은 폴더 단위 on/off(`Settings > Exchange Settings > Document > Management > Index Files and Folders`). `Freeze Index / Unfreeze Index`로 번호를 고정할 수 있다.
  - 중요한 부작용이 문서에 그대로 적혀 있다: **번호는 개인 권한에 따라 재계산되지 않기 때문에, 접근 권한이 없는 멤버는 번호에 구멍이 보인다.** (폴더 전체가 안 보이면 폴더째 숨김)
- **Ansarada**: 2자리 제로패딩 + 점 연결(`01`, `02`, `03`, `03.01`). 검색 탭이 아예 `Name and number search`로 분리되어 있어 **번호가 1급 검색 키**다. 인덱스는 Excel로 export 가능.
- **Firmex**: 인덱스 안에서는 폴더별 `No.`(1, 2, 3 …), 플랫 뷰에서는 점 표기(`5.1`, `2.1`, `3.1`). `No.` 컬럼은 정렬 가능(캐럿).
- **DealRoom**: 요청 리스트의 ID는 `748`, `230`, `330`처럼 값이 반복된다 — 문서 인용번호가 아니라 카테고리/섹션 번호에 가깝다.
- **Intralinks DealCentre**: 요청에는 `DR-2`, `DR-1` 같은 **접두어 + 시퀀스** ID를 쓰고 파란 링크로 렌더한다.

### 2.4 권한 & 워터마킹 노출 방식

- **Ansarada `View as`** — Document index 필터 바의 드롭다운. 열면 `View as you ✓` 체크 후 `WHAT CAN THEY SEE` 섹션 헤더 아래 팀 목록이 색 점과 함께 나열된다(`admin`(청록), `BUY SIDE`(회색), `BUY SIDE: clean team`(회색), `buy side 2`(빨강)). 선택하면 인덱스가 그 팀 시점으로 다시 그려진다. **권한 매트릭스를 읽히는 대신 결과를 보여주는 방식.**
- **Intralinks `View As`** — 같은 사상. `More Actions > View As`에서 사용자를 골라 Documents 탭을 그 사람 시점으로 본다.
- **Papermark** — 행 단위 아이콘 토글. `Name | Actions` 테이블에서 각 행 우측에 눈(view)·다운로드(취소선) 아이콘 2개. 활성 = 짙은 채움 사각형, 비활성 = 회색 아이콘. 체크박스가 아니라 **아이콘의 채움 상태**로 on/off를 표현한다. 그룹은 `All Groups > Management Team` 브레드크럼 + `General / Members / Permissions` 서브탭으로 진입.
- **Digify**(일러스트) — `Granular Permissions` 매트릭스. 행 = 사용자(아바타 + 이메일), 열 = 라벨 없는 권한 3개, 셀 = 초록 체크 / 빨강 ✗ / 빈 체크박스의 3-state.
- **Ansarada 팀 편집 모달** — `Team name` 입력, `Colour` 스와치, `Scan permissions` 체크박스(`Full text search`, `Bulk download`, `Security for Microsoft Office documents`). 즉 팀 자체에 색을 배정하고 그 색을 View as 드롭다운에서 재사용한다.
- **Ansarada 능력 표** — 행 = capability(`Add comment`, `View comments`, `Copy and paste cells`, `Edit formulas`, `Play macro`, `Print` …), 열 = 단일 `Allow editing`. 셀은 `Off | On` 2분할 알약(On = 초록 채움). 체크박스보다 상태가 더 또렷하다.
- **워터마킹**: 별도 화면이 아니라 보안 설정 안의 한 항목으로 취급된다. Ansarada는 `Watermarks`가 PDF 전용이고 "XFA-formatted PDF와 PDF portfolio는 표지에만 워터마크가 찍힌다"고 명시. Intralinks는 IRM 보호 문서를 브라우저에서 못 열고 다운로드 강제 → 뷰어 진입 자체가 권한에 따라 달라진다.

### 2.5 Q&A / 요청 리스트

- **Ansarada Q&A**: 상단바 `Ask a question / Filter / Search / Actions`. 본문 `View questions` → 세그먼트 토글 `[All questions | Your questions only]`(활성 = 회색 트랙 위 흰 알약) → 라벨 왼쪽 정렬 3필터 `Subject [All▾] Priority [All▾] Status [All▾]` → 결과 영역. 비어 있을 때는 보더 박스 안에 회색 `No records found.` + 초록 링크 `Ask a question`. 질문 작성 시 priority, Subject(직접 입력 또는 드롭다운), 본문, 그리고 **`Related Items` 섹션에서 파일을 첨부하거나 데이터룸에 이미 있는 문서를 링크**한다. AIDA가 유사 기제출 질문을 검사한다.
- **DealRoom 요청 리스트**: `Due Diligence List / Human Resource` 처럼 **리스트 / 카테고리** 2단 그룹 헤더 행. 그룹 헤더 우측에 `0 / 6` + 얇은 초록 진행바 + `0%`. 컬럼: 체크박스, ID, Title(말줄임), `PR`(우선순위 깃발, 빨강/주황/회색), `Status`(점 + Open/In progress/Resolved), `Assignee`(아바타+이름), `Reviewers`(아바타+이름, `+1` 오버플로), `Findings`(색 점 + 수), `Reply`(말풍선 + 수), `Files`(클립 + 수), `Labels`(초록 알약 `Sprint 8`), `Start date`, `Due date`, `Updated`. 좌측에 별도 `Worklists` 패널(`New +` 버튼, `All worklists`, 워크리스트 → 카테고리 자식).
- **Intralinks DealCentre Document Requests**: 상단에 4개 KPI(`3 Document Requests / 3 Open / 0 Ready for Review / 0 Completed`) — 얇은 세로 구분선만 있고 카드 보더·그림자 없음. 테이블 컬럼별 헤더에 필터 깔때기 + `...` 메뉴가 **각각** 붙어 있다. 우측 가장자리에 90° 회전된 세로 탭 `Filters` / `Columns`(접힌 드로어). 릴리즈 노트에 "Advisor가 요청을 발행하고 seller가 업로드하면 상태가 자동으로 `Ready to Review`로 바뀐다", "AI가 업로드 파일이 요청한 문서와 맞는지 검사한다"고 적혀 있다.
- **Datasite**는 이걸 `Trackers`라고 부르고, "체크리스트에 맞춰 fileroom/폴더 구조를 자동 생성"한다고 문서에 명시(스크린샷 확보 실패).

### 2.6 액티비티 & 감사

- **iDeals Dashboard**: 상단 KPI 카드 3장 — `Activity 3 / sign-ins over the last two weeks`, `Documents 1 / views in the last two weeks`, `Q&A 1 / unanswered questions`. **선택된 카드는 연초록 배경 + 초록 보더**로, 카드가 탭 역할을 한다. 아래에 날짜 레인지 입력 + `Activity on [All groups ▾]`. 그 밑 `2 Participants` 단일 가로 바 + 범례 칩 `0 Invited / 0 Signed in / 2 Engaged / 0 Idle` — 참가자 퍼널을 한 줄로 압축. 하단 좌=`Summary` 도넛(`% of actions`) + 그룹별 범례(`Administrators 1/1 users — 50.00%`), 우=`Dynamics of [Activity ▾]` 일자별 막대 + `Participants by activity | Active | Docs accessed | Time in project | Actions` 확장형 테이블(`1/1` 알약, `5 hr 58 min`).
- **CapLinked Insights**: 좌측에 리포트 목록(`Overview / Activity by Member / Activity by Group / Activity by Date / Files Activity / File Security / Member Status`). 제목 옆에 생성 시각 `03/07/2022 @ 9:52 am` + `?`. **꽉 찬 파란 탭 스트립**(`VIEW FILE DATA` / `VIEW USER DATA`, 대문자 소형). `Group Rankings`는 행마다 `Rank 1` 큰 숫자 + 그 아래 작은 라벨, 이어서 `63 Workspace Events` / `35 Files Accessed` / `70.0% Workspace Activity`, 우측 확장 캐럿. 파일 테이블은 `File Name | Time Viewed(01:09:42s) | Viewed Count | Downloaded Count`.
- **Digify Analytics overview**: 4개 수치 셀 `1 ACTIVE GUESTS ⓘ / 1 VISITS ⓘ / 0 TOTAL TIME SPENT / 0 AVG. TIME SPENT ON FILES`. 카드가 아니라 얇은 세로 구분선만. 필터는 `[Time | All time ▾] [Guests ▾ | No guests added ▾] [Owners | Show ▾] [Apply]` 세그먼트형 입력 그룹 + 비활성 `Apply` 버튼. 아래 `No. of visits` 도넛 + `MOST RECENT VISITS`(아바타 + 이메일 + 날짜, 우상단 `View all`).
- **Ansarada 주간 Insights 이메일**: `Project Naruto / 09 Feb 2026 - 16 Feb 2026` 헤더, 라임 제목 블록 3개 — `User group activity`(User group｜Total｜This week), `Documents accessed`(User group｜Last week｜This week), `Most viewed documents`(Top 5 by view count, 각주 `* May exclude documents with tracking disabled.`). 각 블록 끝에 `Go to <링크> for more details`. 즉 **요약은 push, 드릴다운은 앱으로**.
- **Ansarada 문서 상태 아이콘**: 폴더 옆 **다이아몬드 = 빈 폴더**. 파일 우측 **꽉 찬 원 = 마지막 로그인 이후 추가/변경**, **빈 원 = 마지막 열람 이후 변경 없음**, 호버하면 본인 열람 여부가 뜬다. Firmex는 같은 의미를 파일명 앞 **주황 점**으로 쓴다.
- **Intralinks 문서 리스트 컬럼**: `Protected`(아이콘 호버 시 적용된 보호 표시), `Note`(노트 아이콘 → 슬라이더 패널), `Redacted`, `Added By/Added On`, `Last Modified By/Modified On`. 즉 감사 정보를 별도 화면이 아니라 **리스트 컬럼으로** 노출한다.

### 2.7 밀도

- **DealRoom이 가장 조밀하다.** 1440px 폭 기준 행 높이 ≈27px, 본문 12–13px, 헤더 라벨 11–12px 회색. zebra 없음, 1px 회색 수평 구분선만. 14개 컬럼이 가로 스크롤 없이 들어간다.
- **Firmex**: 행 높이 ≈34px, 폰트 13px. 좌 패널 ≈250px, 우 인스펙터 ≈250px, 중앙 가변. 페이지네이션 푸터(`Page 1 of 1`, `50 rows per page`, `Showing 1-8 of 8 results`)가 항상 붙어 있다 — 무한스크롤 아님.
- **Intralinks**: 행 높이가 가장 여유롭다(≈40px 환산). 대신 컬럼 헤더마다 필터+메뉴 아이콘이 붙어 헤더 자체가 무겁다.
- **Ansarada**: 셋 중 가장 여백이 많다. 필터 영역이 회색 라운드 블록으로 크게 잡히고, 좌 메뉴 항목 간격도 넓다. 대신 색을 거의 안 쓴다(파스텔 듀오톤 아이콘 + 초록 액센트만).
- **Papermark**: 밀도가 가장 낮다. 폴더 1개 = 카드 1장(≈72px). 실사 문서 수백 건에는 안 맞는 형태.
- **색 사용은 공통적으로 절제적**이다. 표는 사실상 흑백이고, 색은 (1) 상태 점/알약, (2) 우선순위 깃발, (3) 라벨 칩, (4) 카운트 아이콘, (5) 진행바에만 들어간다. CapLinked의 꽉 찬 파란 탭 스트립이 유일한 예외적 색면이다.

### 2.8 깊이 / 재질

- **테이블 내부는 전부 플랫**이다. 어떤 제품도 행·셀에 그림자를 쓰지 않는다. 구분은 1px `#e5e7eb`급 라인과 회색 헤더 배경.
- **그림자는 "떠 있는 것"에만** 쓴다: Box의 주석 팝오버, Ansarada의 View as 드롭다운, Ansarada 팀 편집 모달, 마케팅 페이지에서 앱 창 전체를 띄울 때의 soft drop shadow.
- **글래스/블러/그라디언트는 제품 UI 안에서 한 건도 못 봤다.** 그라디언트는 마케팅 섹션 배경(DealRoom의 남색 밴드, Box의 보라 헤더, Ansarada의 라임 CTA 밴드)에만 있다.
- **라운드 반경**: 버튼·입력은 대부분 6–8px. Intralinks만 완전 pill 버튼(`Export`, `Create Request`). Papermark는 카드 8–12px + 1px 보더.
- **선택/활성 표현**은 두 갈래다. (a) 좌측 4px 컬러 바 + 연한 배경 — Firmex(주황), DealRoom(연파랑), Box 코멘트(주황). (b) 밑줄 탭 — Firmex 상단 탭(주황 밑줄), Papermark 탭. Intralinks는 연파랑 채움 알약 탭.
- **Ansarada만 다크 요소를 쓴다**: 최상단 앱 바가 검정이고 로고가 라임. 나머지 본문은 전부 흰색.

---

## 3. dataroom 에 시사점

- **문서 번호를 데이터 모델의 1급 필드로 넣어야 한다.** Intralinks의 `2.1.2.16` 규칙(연속·자동 재인덱싱·freeze 가능)과 Ansarada의 `03.01` 제로패딩, 그리고 Ansarada가 검색을 `Full text` / `Name and number` 두 탭으로 쪼갠 것은 전부 "실사에서는 번호로 문서를 지목한다"는 같은 사실을 가리킨다. AI 평가 결과가 근거 문서를 인용할 때도 이 번호를 써야 추적이 된다. 단, Intralinks가 자기 문서에 적어둔 부작용 — **권한 없는 투자자에게는 번호에 구멍이 보인다** — 은 그대로 우리한테도 온다. 번호를 전역 고정으로 갈지, 투자자별로 다시 매길지(그러면 회사 측과 번호가 어긋난다)를 설계 초기에 결정해야 한다.

- **깊은 계층은 트리로만 풀지 말고 "플랫 테이블 + Index/Folder/No. 컬럼"을 기본 뷰로 둘 것.** Firmex의 `All Documents` 뷰가 정확히 이 해법이고, 정렬·필터·컬럼 토글이 전부 살아난다. 트리는 스코프를 좁히는 보조 장치로 쓰고, 대신 Firmex의 `QUICK VIEW`(Unread / New Since / …)처럼 **저장된 필터를 좌측에 상설 노출**하는 편이 실제 검토 동선(“지난번 이후 바뀐 것만”)에 맞다.

- **뷰어는 Box형 3-영역으로 가되, 우측 레일을 아이콘으로 다중화하지 말 것.** 페이지 앵커 하이라이트 + 앵커된 컴포저 + 우측 Activity 피드(코멘트마다 `Page 6` 딥링크)는 우리가 필요로 하는 "근거 인용" 동선과 정확히 일치한다. 반대로 Box가 사이드바 안에 또 세로 아이콘 레일(Slack/Zoom/Adobe/Box Sign…)을 넣은 건 통합 벤더의 사정이지 우리 문제가 아니다. 우리는 탭 2–3개(Assessment / Comments / Metadata)면 충분하다. Ansarada처럼 프리뷰를 새 창 + 주석 불가로 만드는 선택은 **피해야 한다** — 평가·리뷰 패널이 제품의 핵심인데 뷰어가 읽기 전용이면 근거-의견 연결이 끊긴다.

- **권한은 매트릭스가 아니라 `View as`로 검증시킬 것.** Ansarada / Intralinks 둘 다 "이 팀에게 무엇이 보이나"를 impersonation 필터로 답한다(`WHAT CAN THEY SEE` + 팀 색 점). 매트릭스 UI는 설정 화면에만 두고, 회사 워크스페이스 상단에는 "투자자 A 시점으로 보기" 토글을 올리는 게 실수 방지에 훨씬 효과적이다. 설정 자체는 Papermark식 **행별 아이콘 토글**(eye / download)이 shadcn `Toggle` + `Table`로 가장 적은 코드로 구현된다 — Digify식 라벨 없는 3-state 체크박스 매트릭스는 열 의미가 안 읽혀서 피하는 게 좋다.

- **평가·리뷰 진행률은 DealRoom식 "그룹 헤더 + `n/m` + 진행바"를 그대로 가져올 만하다.** 실사 요청 리스트를 카테고리로 묶고 헤더 우측에 `0/6 ▓░░░ 0%`를 붙이는 패턴은, 우리의 "평가 기준별 충족 문서 수"나 "리뷰어별 완료 수"에 거의 1:1로 매핑된다. Tailwind v4 + shadcn에서는 `TableRow` 변형 + 얇은 `Progress`로 끝난다. 다만 **DealRoom의 14컬럼/27px 행 밀도를 그대로 복제하지는 말 것** — 우리는 리뷰어·AI 평가·상태까지 붙으므로, 컬럼 토글(Intralinks `Manage Columns`, Firmex `Columns ▾`)을 먼저 넣고 기본 노출 컬럼은 7–8개로 잘라야 한다.

- **시각 스타일은 "플랫 + 1px 라인 + 색은 상태에만"으로 고정.** 조사한 어떤 제품도 제품 UI 안에서 글래스·그라디언트·블러를 쓰지 않았고, 그림자는 오직 팝오버/드롭다운/모달에만 있었다. 2026 트렌드 리포트류가 밀어붙이는 글래스/뎁스는 이 도메인에서는 역효과다(읽기 부하 증가 + 인쇄/워터마크 맥락과 충돌). 대신 **선택 상태에 좌측 4px 컬러 바 + 연한 배경**(Firmex 주황, DealRoom 연파랑, Box 주황)이라는 값싸고 확실한 관용구를 채택하고, Tailwind에서는 `data-[state=selected]:border-l-4` 한 줄로 끝낸다.

---

## 4. 확보 실패

- **Datasite** — 조사 시점(2026-09-22)에 `datasite.com` 전체가 `Datasite.com Unavailable / The Datasite website is under maintenance` 정적 페이지로 대체되어 있었다. 제품 페이지·브로셔 PDF 전부 접근 불가. 대체로 `datasite.my.site.com`의 *Diligence user guide for administrators*를 캡처했으나 문서 내 시각 자료가 전부 임베드 비디오라 렌더 결과가 빈 박스였다. **확보한 UI 스크린샷 0장.** 텍스트로 얻은 것만: 관리자 가이드 목차가 `Invitation | Registration | Log in | Trackers | Load documents | Q&A | Permissions | Users | Redaction | Analytics | Close project`이고, `Trackers`가 실사 체크리스트/문서 요청 리스트이며 "fileroom/폴더 구조를 체크리스트에 자동 연결해 생성"한다는 점.
- **iDeals** — `ideals.com`이 헤드리스 크롬 요청을 차단(200 OK, 29KB 빈 셸). 자사 사이트에서는 한 장도 못 얻었고, **Papermark의 VDR 비교 글에 실린 실제 Dashboard 스크린샷 1장으로만** 확보했다. 문서 인덱스·뷰어·Q&A 화면은 미확보.
- **Intralinks VDRPro** — 지원 문서(`support.intralinks.com`)는 매우 상세하지만 **본문에 스크린샷이 하나도 없는 순수 텍스트**다. 확보한 실제 UI는 DealCentre AI 릴리즈 노트 히어로의 Document Requests 화면 1장뿐. 문서 리스트·뷰어·권한 화면의 실제 스크린샷은 미확보(본 리포트의 해당 항목은 텍스트 근거임을 명시했다).
- **Ansarada 마케팅 사이트** — 랩탑 목업 3개가 전부 **추상화된 일러스트**(회색 바 + 빨강/주황/라임 칩)이지 실제 스크린샷이 아니다. 실제 UI는 전부 `help.ansarada.com`(Intercom)에서 얻었다. 다만 헬프 문서 이미지 상당수가 GIF/동영상이라 첫 프레임만 잡혀 문서 목록이 비어 있는 상태로 찍힌 것이 있다(예: Q&A `No records found.`, Document index 빈 리스트).
- **Dropbox DocSend** — `docsend.com`이 curl·WebFetch 모두 403이고, 추정 URL 2개(`/virtual-data-room/`, `/virtual-data-rooms/`)가 전부 404였다. 내비게이션의 실제 경로를 확인할 수단이 없어 **0장**.
- **SecureDocs** — `securedocs.com/product`가 Onit의 ContractWorks(CLM) 페이지로 리다이렉트된다. VDR 제품 UI 없음. **0장.**
- **Box** — 파일 브라우저/권한 화면은 공개 페이지에 없고, 확보한 것은 프리뷰+주석 콜라주 1장이다. 실사용 데이터룸 목록 화면은 미확보.
- **DealRoom** — `/platform-tour`는 인터랙티브 투어 진입 카드(썸네일)만 있고 투어 자체는 임베드로 열리지 않아 폐기했다. Data Room 탭(문서 브라우징) 실제 화면도 미확보 — 확보한 것은 Tasks/요청 리스트 화면이다.
