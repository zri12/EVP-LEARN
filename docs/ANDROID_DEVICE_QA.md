# Phase 11D — Final Human Physical Acceptance Report

QA date: 2026-09-04 (Asia/Jakarta)

## Device

- Model: Samsung Galaxy A15 (SM-A155F)
- Android: 16 / API 36
- Architecture: `arm64-v8a`
- ADB serial: `RR8X204QF0J`
- Airplane Mode: ON
- Wi-Fi: OFF

## Final APK

- Path: `build/app/outputs/flutter-apk/app-debug.apk`
- Bytes: 201,183,466
- SHA-256: `10127F291A9764E1DB12D208FF04ED54C4CC3BAC11180F26077E07AE692DAE8F`
- Installed and manually tested on the exact device above.

## Launcher and splash

- Launcher label `EVP LEARN`: PASS
- Current EVP Learn logo: PASS
- No cropping / not tiny: PASS
- Duplicate standalone `EVP LEARN` on splash removed: PASS
- Splash timing approximately five seconds: PASS
- Home opens after splash: PASS

## Audio — human audible verification

- Reading: 5/5 PASS
- Vocabulary: 15/15 PASS
- Glossary: 26/26 PASS
- Total: 46/46 PASS
- Same audio while playing: PASS
- Same audio after completion: PASS
- Switching audio A → B: PASS

## Reading audio lifecycle

- Reading 1 → Reading 2 stops: PASS
- Reading 2 → Reading 3 stops: PASS
- Reading 3 → Practice stops: PASS
- Reading → Android Back stops: PASS
- Ghost playback: NONE

## Human practice interaction

- Long-press finger drag: PASS
- Drop target: PASS
- Tap-to-match: PASS
- Re-pair: PASS
- Counter 0/3 → 1/3 → 2/3 → 3/3: PASS
- Invalid 4/3–6/3 count observed: NO
- Check enabled at 3/3: PASS
- Check scoring: PASS
- Continue: PASS
- Finger sequence reorder: PASS
- Sequence items lost/duplicated: NO
- Sequence Check and Continue: PASS
- Activity 3 → Practice Summary: PASS
- Practice Summary → Post-test: PASS

## Module flows

- Module 1 full flow through Final Result and Home: PASS
- Module 2 full flow through Final Result: PASS
- Module 2 Reading 1, Reading 2, Reading 3: PASS
- Module 2 Page Not Found: NONE
- Module 3 full flow through Final Result: PASS

## Resume, retry, history, and progress

- Pre-test force-stop resume: PASS
- Module 2 Reading 2 force-stop resume: PASS
- Matching draft force-stop resume: PASS
- Sequence draft force-stop resume: PASS
- Post-test force-stop resume: PASS
- Retry starts: PASS
- Old history preserved: PASS
- Force-stop during Retry preserves active retry: PASS
- Retry completes: PASS
- Attempt 1 and Attempt 2 visible: PASS
- Latest and Best values: PASS
- Completed count, History, and Attempt Detail: PASS

## Android Back

- Module Overview → Back: PASS
- Learning → Back: PASS
- Practice → Back: PASS
- Attempt Detail → Module Progress → Progress: PASS
- Final Result → Home → Back does not reopen Final Result: PASS

## Offline

- Home: PASS
- Assessment: PASS
- Practice: PASS
- Audio: PASS
- Progress: PASS
- Internet-required feature observed: NO

## Bugs

- No new bug details were reported.
- Unresolved BLOCKER: 0
- Unresolved MAJOR: 0
- The submitted form left the `BUG BARU ADA/TIDAK ADA` selector unmarked;
  the stated final result was PASS and no blocker/major was reported.

## Automated validation

- `dart format lib test`: PASS (72 files)
- `flutter analyze`: PASS (0 errors, 0 warnings, 0 infos)
- `flutter test`: PASS (88 tests)
- `flutter build apk --debug`: PASS

## Safety

- Schema version: 2
- Migration: unchanged
- Scoring: unchanged
- Academic JSON/DOCX: unchanged
- Reference prototype: unchanged
- 46 WAV files: unchanged
- Network dependency: none
- Application ID: `com.example.evp_learn`
- Release signing: not configured
- No commit or push was performed; Phase 12 was not started.

## Verdict

**PHASE 11 PHYSICAL QA VERIFIED — READY FOR GIT CHECKPOINT**
