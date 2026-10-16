# 인계 메모 — 2026-10-16

새 세션에서 이어받을 때 이 파일만 읽으면 됩니다. (기억 파일 `dataroom-dev-site`, `scenario-step-review`, `dataroom-dev-vs-base` 는 세션 시작 때 자동으로 올라갑니다.)

## 지금 하는 일

**dev 사용자 시나리오를 아주 작은 스텝으로 한 건씩 검토** — 스텝마다 UI/UX 어색한 곳과 버그를 찾아 그 자리에서 고칩니다. 화면 전체를 다시 그리는 방식은 그만뒀습니다.

확인 대상은 **배포된 dev**: `https://dataroom.dev.biyard.co/workspace/biyard-dev`
→ **사용자 Chrome(claude-in-chrome)** 으로만 열립니다. 내장 브라우저 패널은 로그인이 없어 막힙니다.

코드는 워크트리 `C:\Users\a7592\Desktop\dev\asset-dev` 에서 봅니다.
**읽기 전에 반드시** `git fetch upstream dev && git checkout --detach upstream/dev` — 현재 `5cb17b351` 로 맞춰둠.

## 시나리오 순서 (합의됨)

1. 첫 진입
2. 평가기준 만들기
3. 기준에 증빙·데이터·화면 붙이기
4. 데이터룸 만들고 자료 올리기
5. 데이터룸에 평가 기준 적용
6. 증빙 붙여 레벨 올리기
7. 종합 등급 확인·재평가
8. 공시 발행
9. 외부 열람·검증
10. 딜 연결 승인·구성원 초대

## 스텝 1(첫 진입)에서 나온 것 — 아직 미처리

`/workspace/biyard-dev` → `/assessments` 로 리다이렉트됩니다.

1. 첫 화면이 **평가기준**입니다(데이터룸 아님). 의도인지 확인 필요.
2. 본문이 빈 채로 시작 — 「왼쪽에서 …을 고르면 여기에 열립니다」. 데이터룸 화면도 같음.
3. 레일에 **홈이 없음**.
4. 평가기준 목록에 **「제목 없음」 v1 기준 1** 이 섞여 있음.
5. **「국내 금 자산 평가」가 두 개** (`v1` 기준 6 / `gold-kr/v1` 기준 6) — 구분이 배지뿐.
6. 데이터룸 목록 줄에 **날짜만** — 평가 진행도·등급이 안 보임.
7. 데이터룸 필터 `전체/요청/스팸` 이 평가 요청 메일함 역할인데 설명이 없음.

## 막혀 있는 것 — 개발자들이 복구 중 (건드리지 말 것)

평가 관련 화면이 전역으로 안 열립니다. 다시 진단하지 마세요.

```
/plugin.assessments.Assessments/Get                → 500
/plugin.assessments.Assessments/GetRoomAssessment  → 500
{"service":"assessments","code":31,"message":"assessment storage failed"}
```

- `code 31` = `EvaluationError::Database` (`services/assessment/src/error.rs:93`)
- 같은 화면의 `GetRoomDataViews` · `ListEvidences` · `GetRun` 은 **200** → DB 연결은 살아 있음
- 공통점은 **기준·하위지표·scoring 을 읽는 경로** (`levels::get_assessment_view`, `workspace::get_workspace_assessment`)
- 최근 관련 커밋: `c08c48ffe`(scoring 을 관계 테이블로), `8a934d615`(레벨 관계 모델·FK)
- 확정하려면 assessment 서비스 로그에서 `get_assessment_view:` 라벨을 보면 됨

**곁가지(우리 몫)**: 프론트가 모든 실패를 「이 평가의 기준을 불러오지 못했습니다」 한 문구로 뭉갭니다 (`services/assessment/ui/room-screen.tsx:240`). 500·권한 없음·기준 0개가 구분이 안 됩니다. 복구되면 이걸 손볼 후보.

## 접어둔 작업 — 평가 화면 목업

어제까지 만들던 미리보기입니다. 지금은 **보류**.

- `Downloads\평가화면-dev현재.html` — dev 현재 화면 그대로
- `Downloads\평가화면-변경안.html` — 거기에 변경을 얹은 것 (최신)

마지막 상태: 3단(레일+본문), 기준은 상단 6칸, 하위지표는 그 아래 한 줄, 본문은 「요구 증빙」 카드 + 「입력 데이터」 카드, 「+ 첨부」를 누르면 자료 고르기 화면으로 전환.
