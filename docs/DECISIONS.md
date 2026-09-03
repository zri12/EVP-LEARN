# DECISIONS.md — Product & Technical Decision Log

## D001 — Framework
**Flutter + Dart.**  
Status: FINAL.

## D002 — Prototype Role
`UI-APK PEMB B.INGGRIS/` is read-only reference.  
Status: FINAL.

## D003 — No WebView
No Capacitor/WebView final APK.  
Status: FINAL.

## D004 — Offline
Core app fully offline.  
Status: FINAL.

## D005 — Bottom Navigation
Exactly 4:
Home, Modules, Progress, Profile.  
Status: FINAL.

## D006 — Module Access
All 3 modules unlocked.  
Status: FINAL.

## D007 — Academic Source
`UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx`.  
Status: FINAL for current baseline.

## D008 — Academic Storage
Local JSON + typed Dart.  
Status: FINAL.

## D009 — Learner State
SQLite via Drift.  
Status: FINAL.

## D010 — State
Riverpod.  
Status: FINAL.

## D011 — Navigation
go_router.  
Status: FINAL.

## D012 — Audio
just_audio + local assets.  
Status: FINAL.

## D013 — Localization
Indonesian default + English UI.  
Status: FINAL.

## D014 — Assessment Counts
10 Pre + 10 Post/module.  
Status: PRODUCT BASELINE; banks pending academic validation.

## D015 — Practice
3 scored activities/module, max 10 each.  
Status: FINAL.

## D016 — Final Score
Post weighted /70 + Practice /30.  
Status: FINAL unless explicitly changed.

## D017 — Passing Threshold
75 centralized.  
Status: PROVISIONAL pending school confirmation.

## D018 — Learning Gain
Current Post raw - current Pre raw.  
Status: FINAL.

## D019 — Retry
Preserve baseline/history; new attempt.  
Status: FINAL.

## D020 — Attempt History
Final APK visibly exposes evaluation history from Progress.  
Status: INCLUDED.

## D021 — Drag & Drop
Flutter-native touch DnD + tap fallback.  
Status: FINAL.

## D022 — Fonts
No runtime Google Fonts.  
Status: FINAL.

## D023 — Profile
Static researcher profile; no account.  
Status: FINAL concept.

Current prototype shows `AFRIDA DWI RAHMAWATI`; verify final spelling before release.

## D024 — Objectives
Prototype-derived.  
Status: PENDING academic validation.

## D025 — Question Banks
Current 60 MC prototype-derived.  
Status: PENDING academic validation.

## D026 — Flat-packing Typo
Do not silently correct `pipih/dUS`.  
Status: PENDING customer confirmation.

## D027 — Glossary Count
27 occurrences / 26 unique.  
Status: CURRENT source baseline.

## D028 — Required Audio
5 reading, 15 vocabulary preview, 26 glossary unique.  
Status: FINAL relative to current content.

## D029 — Application ID
The Phase 1 development scaffold currently uses `com.example.evp_learn`. This is not a production application ID.  
Status: PENDING before production release.

## D030 — Min Android SDK
Initialized with Flutter 3.41.6 using Android `minSdk 24` and `targetSdk 36`.  
Status: FACTUAL Phase 1 baseline; revisit only if customer/device requirements dictate.

## D031 — Visual Authority
Actual approved prototype implementation, not old prototype Markdown.  
Status: FINAL.

## D032 — Phase 1 Toolchain
Flutter 3.41.6 and Dart 3.11.4 were used to initialize the Android project.  
Status: FACTUAL Phase 1 baseline.
