# Asset Migration Map

This is the provenance and runtime registry reference for locally bundled Flutter assets. The React prototype remains read-only; Flutter runtime never loads from `UI-APK PEMB B.INGGRIS/`.

## Scope and integrity status

- Phase 2 retained four approved root-shell PNG assets.
- Phase 4 migrated exactly 46 required WAV files: 5 reading, 15 vocabulary, and 26 unique formal glossary pronunciations.
- SHA-256 source/destination comparison passed for all 46 Phase 4 WAV files immediately after copy (reading: 10,655,830 bytes; vocabulary: 1,057,114 bytes; glossary: 1,937,950 bytes).
- The logical registry is `lib/core/constants/app_assets.dart`; resolution is namespace-specific so a reading key and a vocabulary key with the same text cannot collide.
- The physical source academic DOCX was not copied or changed. Its canonical source remains `UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx`.

## Root-shell visual assets (Phase 2)

| Flutter destination | Read-only prototype source | Runtime use |
|---|---|---|
| `assets/images/branding/evp-icon.png` | `UI-APK PEMB B.INGGRIS/src/imports/evp-icon.png` | Splash, root header, Home hero |
| `assets/images/modules/module-1-narrative.png` | `UI-APK PEMB B.INGGRIS/src/imports/module-art/module-1-narrative.png` | Module 1 root card |
| `assets/images/modules/module-2-descriptive.png` | `UI-APK PEMB B.INGGRIS/src/imports/module-art/module-2-descriptive.png` | Module 2 root card |
| `assets/images/modules/module-3-procedure.png` | `UI-APK PEMB B.INGGRIS/src/imports/module-art/module-3-procedure.png` | Module 3 root card |

## Required reading audio (5)

| Logical key | Read-only prototype source | Flutter destination |
|---|---|---|
| `m1-1` | `UI-APK PEMB B.INGGRIS/public/audio/reading/m1-1.wav` | `assets/audio/reading/m1-1.wav` |
| `m2-1` | `UI-APK PEMB B.INGGRIS/public/audio/reading/m2-1.wav` | `assets/audio/reading/m2-1.wav` |
| `m2-2` | `UI-APK PEMB B.INGGRIS/public/audio/reading/m2-2.wav` | `assets/audio/reading/m2-2.wav` |
| `m2-3` | `UI-APK PEMB B.INGGRIS/public/audio/reading/m2-3.wav` | `assets/audio/reading/m2-3.wav` |
| `m3-1` | `UI-APK PEMB B.INGGRIS/public/audio/reading/m3-1.wav` | `assets/audio/reading/m3-1.wav` |

## Required vocabulary audio (15)

| Logical key | Read-only prototype source | Flutter destination |
|---|---|---|
| `m1-1` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m1-1.wav` | `assets/audio/vocabulary/m1-1.wav` |
| `m1-2` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m1-2.wav` | `assets/audio/vocabulary/m1-2.wav` |
| `m1-3` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m1-3.wav` | `assets/audio/vocabulary/m1-3.wav` |
| `m1-4` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m1-4.wav` | `assets/audio/vocabulary/m1-4.wav` |
| `m1-5` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m1-5.wav` | `assets/audio/vocabulary/m1-5.wav` |
| `m2-1` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m2-1.wav` | `assets/audio/vocabulary/m2-1.wav` |
| `m2-2` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m2-2.wav` | `assets/audio/vocabulary/m2-2.wav` |
| `m2-3` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m2-3.wav` | `assets/audio/vocabulary/m2-3.wav` |
| `m2-4` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m2-4.wav` | `assets/audio/vocabulary/m2-4.wav` |
| `m2-5` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m2-5.wav` | `assets/audio/vocabulary/m2-5.wav` |
| `m3-1` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m3-1.wav` | `assets/audio/vocabulary/m3-1.wav` |
| `m3-2` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m3-2.wav` | `assets/audio/vocabulary/m3-2.wav` |
| `m3-3` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m3-3.wav` | `assets/audio/vocabulary/m3-3.wav` |
| `m3-4` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m3-4.wav` | `assets/audio/vocabulary/m3-4.wav` |
| `m3-5` | `UI-APK PEMB B.INGGRIS/public/audio/vocabulary/m3-5.wav` | `assets/audio/vocabulary/m3-5.wav` |

## Required formal glossary audio (26 unique files)

`adjustable` has two formal glossary occurrences in Module 2 and intentionally resolves to this one physical file.

| Logical key | Read-only prototype source | Flutter destination |
|---|---|---|
| `adjustable` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/adjustable.wav` | `assets/audio/glossary/adjustable.wav` |
| `assemble` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/assemble.wav` | `assets/audio/glossary/assemble.wav` |
| `asymmetrical` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/asymmetrical.wav` | `assets/audio/glossary/asymmetrical.wav` |
| `attach` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/attach.wav` | `assets/audio/glossary/attach.wav` |
| `boycott` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/boycott.wav` | `assets/audio/glossary/boycott.wav` |
| `casing` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/casing.wav` | `assets/audio/glossary/casing.wav` |
| `centerpiece` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/centerpiece.wav` | `assets/audio/glossary/centerpiece.wav` |
| `delivery` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/delivery.wav` | `assets/audio/glossary/delivery.wav` |
| `dual-screen-display` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/dual-screen-display.wav` | `assets/audio/glossary/dual-screen-display.wav` |
| `durable` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/durable.wav` | `assets/audio/glossary/durable.wav` |
| `eye-catching` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/eye-catching.wav` | `assets/audio/glossary/eye-catching.wav` |
| `finish` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/finish.wav` | `assets/audio/glossary/finish.wav` |
| `flat-packing` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/flat-packing.wav` | `assets/audio/glossary/flat-packing.wav` |
| `gondola-shelving` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/gondola-shelving.wav` | `assets/audio/glossary/gondola-shelving.wav` |
| `greet` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/greet.wav` | `assets/audio/glossary/greet.wav` |
| `insert` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/insert.wav` | `assets/audio/glossary/insert.wav` |
| `integrated` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/integrated.wav` | `assets/audio/glossary/integrated.wav` |
| `open-front` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/open-front.wav` | `assets/audio/glossary/open-front.wav` |
| `payment-method` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/payment-method.wav` | `assets/audio/glossary/payment-method.wav` |
| `premium` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/premium.wav` | `assets/audio/glossary/premium.wav` |
| `retailer` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/retailer.wav` | `assets/audio/glossary/retailer.wav` |
| `revolutionary` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/revolutionary.wav` | `assets/audio/glossary/revolutionary.wav` |
| `scan` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/scan.wav` | `assets/audio/glossary/scan.wav` |
| `sturdy` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/sturdy.wav` | `assets/audio/glossary/sturdy.wav` |
| `verify` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/verify.wav` | `assets/audio/glossary/verify.wav` |
| `visibility` | `UI-APK PEMB B.INGGRIS/public/audio/glossary/visibility.wav` | `assets/audio/glossary/visibility.wav` |

## Image and font audit

| Source or visual | Classification | Phase 4 action |
|---|---|---|
| `src/imports/lesson-art/narrative-lesson.png` | Unused/deferred raster | Not copied: every current reading and assessment `imageKey` is `null`. |
| `src/imports/lesson-art/descriptive-lesson.png` | Unused/deferred raster | Not copied: every current reading and assessment `imageKey` is `null`. |
| `src/imports/lesson-art/procedure-lesson.png` | Unused/deferred raster | Not copied: every current reading and assessment `imageKey` is `null`. |
| `furniture`, `pos`, `shelving`, `jacket`, `checkout` reference visuals | Programmatic UI | Documented only; rebuild natively when their learning screens are implemented. |
| Local Inter `.ttf` / `.otf` | Not available in approved reference imports | Nothing copied or registered; retain approved local system Roboto fallback. |

The existing `pubspec.yaml` directory registrations cover all migrated image and audio destinations. No remote font, image, audio, or runtime network dependency was introduced.

## Intentionally excluded prototype audio

The prototype contains legacy/extra vocabulary and glossary WAV files beyond the 46 required assets above. They are not bundled because they are not a logical key in the Phase 3 academic JSON. This includes legacy glossary files such as `affordable`, `cash-drawer`, `checkout`, `crisis`, `display`, `flat-pack`, `genuine`, `innovation`, `merchandise`, `receipt`, `sleek`, `supplier`, `suppliers`, and non-required vocabulary keys above `m1-5`, `m2-5`, or `m3-5`.
