# EVP Learn — Android APK Project

EVP Learn is an offline Android learning application for **English for Vocational Purposes (EVP)** in a retail context, targeted primarily at **Grade X vocational high school (SMK), Kurikulum Merdeka Phase E**.

The customer-approved React/Vite UI/UX prototype is stored at:

```text
./UI-APK PEMB B.INGGRIS/
```

That folder is a **read-only reference**. The Android application must be implemented properly in Flutter/Dart.

## Product Summary

- Android APK
- Flutter + Dart
- fully offline after installation
- no login
- no backend
- no Firebase/Supabase
- no mandatory Internet connection
- 3 unlocked modules
- Indonesian/English system UI
- local reading audio and pronunciation audio
- Pre-test / Practice / Post-test
- persistent progress and attempt history
- real Android drag-and-drop plus tap fallback

Primary learning modules:

1. Narrative Text — IKEA business story
2. Descriptive Text — POS Terminal, Gondola Shelving, Vintage Leather Biker Jacket
3. Procedure Text — Customer checkout using a POS terminal

## Documentation

Start at `docs/INDEX.md`.

AI/Codex rules are in `AGENTS.md`.

## Proposed Project Structure

```text
PROJECT APK PEMBELAJARAN B.INGGRIS/
├── AGENTS.md
├── CLAUDE.md
├── README.md
├── docs/
├── UI-APK PEMB B.INGGRIS/   # read-only reference
├── android/
├── assets/
├── lib/
├── test/
├── integration_test/
└── pubspec.yaml
```

## Expected Flutter Commands

Once initialized:

```bash
flutter pub get
dart format .
flutter analyze
flutter test
flutter run
flutter build apk --debug
flutter build apk --release
```

Do not commit signing credentials.

## Academic Source

Canonical academic material:

```text
UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx
```

Do not use differently named older/revised documents as a replacement unless the customer explicitly changes the canonical source.

## Visual Source

Canonical visual/behavior reference:

```text
UI-APK PEMB B.INGGRIS/src/App.tsx
UI-APK PEMB B.INGGRIS/src/data.ts
UI-APK PEMB B.INGGRIS/src/index.css
UI-APK PEMB B.INGGRIS/src/imports/
UI-APK PEMB B.INGGRIS/public/audio/
```

Old Markdown inside that reference directory may be stale. Main-project docs override it as defined in `AGENTS.md`.

## Current Product Status

The web prototype has been approved by the customer as generally suitable for the next development stage. The Flutter project should therefore **implement**, not redesign, the approved experience.

Academic details may still receive adjustments after the customer's academic supervision session. Content must remain replaceable without rewriting the scoring engine or overall UI.
