# IMPLEMENTATION_ROADMAP.md — Flutter Build Plan

## Phase 0 — Documentation & Reference Freeze
- install docs;
- mark reference read-only;
- confirm source authority;
- no prototype redesign.

Exit:
Codex reads correct AGENTS and docs.

## Phase 1 — Flutter Initialization
- create project;
- lints;
- Riverpod;
- go_router;
- Drift;
- SharedPreferences;
- just_audio;
- localization;
- folders.

Exit:
launch + analyze/test.

## Phase 2 — Design System & Shell
- tokens;
- buttons/cards;
- top bar;
- 4 bottom nav;
- Splash;
- Home;
- Modules;
- Progress shell;
- Profile.

Exit:
visual compare 360/390/412.

## Phase 3 — Content Foundation
- typed models;
- JSON;
- loader;
- validator;
- exact theory/vocab/readings/glossary;
- current assessment/practice data.

Exit:
content renders from data, not widget hardcoding.

## Phase 4 — Offline Assets
- logo;
- module art;
- lesson art;
- reading visuals;
- reading 5;
- vocabulary 15;
- glossary 26;
- local font.

Exit:
asset validator pass.

## Phase 5 — Learning Screens
- Overview;
- Objectives;
- Theory;
- Vocabulary;
- Reading;
- Glossary.

Exit:
static learning flow matches prototype.

## Phase 6 — Assessment Engine
- pure scoring;
- tests;
- Pre;
- Post;
- results.

Exit:
dynamic scores; no hardcode.

## Phase 7 — Practice
- matching;
- tap fallback;
- LongPressDraggable;
- DragTarget;
- re-pair;
- sequence;
- partial scoring.

Exit:
9 activities functional.

## Phase 8 — Persistence
- Drift schema;
- attempts;
- baseline;
- retry;
- resume;
- latest/best.
- Persist the exact Pre-test/Post-test question order per attempt, either as
  ordered question IDs or as a deterministic shuffle seed. A new attempt must
  receive a new shuffle; resuming the same attempt after process restart must
  restore the same order.

Exit:
restart safe.

## Phase 9 — Progress & History
- overall;
- module rows;
- latest/best;
- visible attempt history.

## Phase 10 — Localization & Accessibility
- ARB complete;
- no mixed labels;
- semantics;
- touch targets;
- Android back.

## Phase 11 — Offline QA
- automated;
- widths;
- physical Android;
- airplane mode;
- all audio;
- retry/history.

## Phase 12 — Release
- profile confirm;
- academic updates available;
- app ID/signing;
- release build;
- install;
- checksum;
- customer handoff.

## Codex Rule
Do not jump straight to “build APK” with one monolithic file.

Each phase should leave:
- compiling code;
- tests;
- focused checkpoint;
- no reference modifications.
