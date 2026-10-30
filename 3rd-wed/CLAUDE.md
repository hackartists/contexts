# CLAUDE.md

3rd Wed (써드웨드) is the app for a monthly blockchain business community. Each month the
community takes one industry and discusses how RWA (real-world asset tokenization) and STO
(security token offering) could apply to it, aiming to turn the discussion into partnerships
and pilot projects.

## Product context

- Operating plan (source of truth for the domain):
  https://docs.google.com/document/d/1mydbwDMZi1uvHwzxzeiiEs4Q7QVyXbSgjv4tWBgLqAo/edit
- Sessions run on the third Wednesday of each month at 17:00, from October 2026 to
  October 2027 (13 sessions), at Draper Startup House Garosu-gil.
- Participants are demand companies (who present business needs), technology companies
  (who propose solutions) and ecosystem partners.
- Session format: topic talk (15m), demand company needs (15m), Q&A and ideation (45m),
  networking.

## Repository layout

Monorepo.

| Path | What it holds |
|---|---|
| `app/` | Flutter app (iOS + Android only, no web target) |
| `server/` | Backend API (Rust, axum) with Postgres. Serves data only, no pages |
| `web/` | React (Vite) CSR app, deployed as static files: QR landing page and `/.well-known` Universal Link / App Link association files |

## Stack

- App: Flutter, iOS and Android.
- Backend: own server, Rust (axum) + Postgres. All business rules (attendance window,
  duplicate attendance, business card exchange conditions, meeting request state transitions)
  are enforced on the server.
- Web: React CSR only, no SSR. It fetches from the server API. Serve
  `/.well-known/apple-app-site-association` as `application/json` without redirects.
- QR codes are generated on the client from the session link; the server never renders QR.
- Push: Firebase Cloud Messaging only, sent from the server. No other Firebase product.
- Files (session slides): S3-compatible storage managed by the server.
- Auth: email only (no phone), no passwords. The mail carries a 6-digit code and a one-time login link; same base flow as dataroom
  (`send_code` -> `verify_code` -> server-issued session). The app stores the session token in
  Keychain/Keystore and the session is extended on use, so users stay logged in.

## Design

- Bento layout. Tone: business and trustworthy (Apple / Toss style): light background,
  restrained color.
- References: iOS widgets and Control Center (module sizes), Toss (Korean typography,
  density), Luma (session detail, QR check-in flow).
- Home has three modules: the highlight session picked by operators, a business meeting
  request to operators, and my business cards. Session details (program, speakers, panel,
  host) live only on the session detail screen.

## MVP scope

Goal: a session-centric archive plus operator-brokered business meetings and business card
exchange among session attendees.

- Operators are the system's operations team. There is no per-session operator; the team
  manages every session and acts as the bridge between attendees and speakers.
- Speakers and panelists do not have to sign up. Operators enter their details when
  registering a session.
- Operator features live in the same app, shown only to operator accounts: manage sessions
  (enter speakers and panel, pick the highlight session), show the session QR, set the
  attendance window, view attendance, meeting request inbox, pre-question inbox.
- QR attendance is the key flow and must never push sign-up:
  - The user scans the on-site session QR with the phone camera; the Universal Link opens
    the attendance screen.
  - One fixed QR per session, encoding an HTTPS link to the session. Attendance is accepted
    only inside the session's attendance window (default 16:30-19:00 on the session day).
  - App installed: the Universal Link / App Link opens the session's attendance screen.
  - App not installed: the link opens the web landing page, which sends the user to the store.
    After install, the first screen asks the user to scan the QR again with the in-app
    scanner. No deferred deep linking service.
  - Logged-in user: attendance is recorded immediately.
  - Not logged in: name, affiliation and email are asked once (the first session only),
    cached on the device, and sent with every attendance record. On sign-up, past attendance
    with the same verified email is attached to the account.
  - Scans outside the window or repeated scans record nothing and show a message.
- Business meeting requests go to operators, not directly to speakers. The attendee may
  specify a related session and target. Status: requested -> confirmed by operators ->
  connected or on hold. Operators broker the meeting.
- Pre-questions for a session go to operators.
- Business cards: attendees who checked in and entered a business card (consenting to share
  it) automatically exchange cards with everyone else who did both for the same session.
  The attendee list is the card list; only people who did both are included.
- Out of MVP: other attendee-to-attendee features (chat), needs board, company search,
  payment, RSVP.

## Local development

- Flutter SDK: `~/flutter/bin/flutter` (not on PATH). iOS plugins use Swift Package Manager; there is no Podfile.
- Android builds need JDK 21 (`JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home`); JDK 26 fails in Gradle.
- Server runs on port 18080 (8080 is used by dataroom locally): `cd server && make db-up && make seed && make run`.
  Dev login: any email + code `000000`. Seed includes a round-0 demo session dated today with attendance open.
- App config via `--dart-define`: `API_BASE` (default `http://localhost:18080`), `WEB_ORIGIN` (default `http://localhost:5173`).
- Deep links: Flutter deep linking is disabled; `app_links` handles `https://<host>/s/{id}`, `https://<host>/auth/{token}` (mailed login link) and the `thirdwed://` equivalents. App link host: `3rd-weds.app.biyard.co` (legacy `3rdweb.biyard.co`).
