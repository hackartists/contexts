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
| `server/` | Backend API (Rust, axum) with Postgres |
| `web/` | QR landing page and Universal Link / App Link association files |

## Stack

- App: Flutter, iOS and Android.
- Backend: own server, Rust (axum) + Postgres. All business rules (attendance window,
  duplicate attendance, connection requests) are enforced on the server.
- Push: Firebase Cloud Messaging only, sent from the server. No other Firebase product.
- Files (session slides): S3-compatible storage managed by the server.
- Auth: email verification code only, no passwords, same flow as dataroom
  (`send_code` -> `verify_code` -> server-issued session). The app stores the session token in
  Keychain/Keystore and the session is extended on use, so users stay logged in.

## MVP scope

Goal: a session-centric archive plus connecting session speakers with interested people.

- Operator features live in the same app, shown only to operator accounts: manage sessions,
  show the session QR, set the attendance window, view attendance.
- QR attendance is the key flow and must never push sign-up:
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
- Connection requests go to session speakers only. The speaker accepts or declines; on accept
  both sides' contacts are revealed and the conversation happens outside the app. Guests are
  asked to sign up at this point.
- Out of MVP: attendee-to-attendee connections, chat, needs board, company search, payment,
  RSVP.
