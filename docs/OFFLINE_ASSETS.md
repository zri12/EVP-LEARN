# OFFLINE_ASSETS.md — Asset and Offline Policy

## 1. Core Rule

The release APK must work without Internet.

All required:
- content;
- audio;
- images;
- icons;
- fonts

must be bundled locally.

## 2. Recommended Flutter Asset Structure

```text
assets/
├── data/
│   └── modules/
│       ├── module_1.json
│       ├── module_2.json
│       └── module_3.json
├── images/
│   ├── branding/
│   ├── modules/
│   ├── lessons/
│   └── readings/
├── audio/
│   ├── reading/
│   ├── vocabulary/
│   └── glossary/
└── fonts/
    └── inter/
```

Register in `pubspec.yaml`.

## 3. Source Asset Reference

Prototype assets:

```text
UI-APK PEMB B.INGGRIS/src/imports/
UI-APK PEMB B.INGGRIS/public/audio/
```

Copy/optimize into Flutter assets. Flutter runtime must not depend on React directories.

## 4. Reading Audio — Required 5

Logical mapping:

```text
audio/reading/m1-1
audio/reading/m2-1
audio/reading/m2-2
audio/reading/m2-3
audio/reading/m3-1
```

Current source files are WAV.

Every release validates all 5.

## 5. Vocabulary Preview Audio — Required 15

Current mapping:

```text
m1-1 ... m1-5
m2-1 ... m2-5
m3-1 ... m3-5
```

Total: 15.

Use explicit JSON asset mapping rather than relying on folder order.

## 6. Formal Glossary Audio — 26 Unique

### Module 1
```text
boycott.wav
delivery.wav
revolutionary.wav
flat-packing.wav
assemble.wav
retailer.wav
```

### Module 2
```text
casing.wav
dual-screen-display.wav
integrated.wav
sturdy.wav
finish.wav
gondola-shelving.wav
adjustable.wav
durable.wav
open-front.wav
visibility.wav
premium.wav
asymmetrical.wav
eye-catching.wav
centerpiece.wav
```

`adjustable` is reused across two readings.

### Module 3
```text
greet.wav
scan.wav
verify.wav
payment-method.wav
insert.wav
attach.wav
```

Total unique:
26.

Formal occurrences:
27.

## 7. Prototype Audit Finding

Physical source contains:

```text
premium.wav
revolutionary.wav
```

An older web `AUDIO_MANIFEST` snapshot omitted these entries.

Flutter migration must use the canonical glossary target list and actual assets, not reproduce that manifest omission.

Do not add non-formal glossary requirements simply because extra WAV files exist.

## 8. Extra/Legacy Audio

Prototype contains extra pronunciation files beyond:
- 15 vocabulary;
- 26 formal glossary.

Classify each migrated asset:
- required;
- optional;
- unused.

Do not automatically bundle all legacy files.

## 9. Image Assets

Prototype has:
- module art;
- lesson art;
- branding;
- programmatic reading illustrations.

Flutter may:
- reuse raster art;
- rebuild simple programmatic illustrations if output remains visually equivalent.

No redesign without approval.

## 10. Image Optimization

Before release:
1. determine actual display size;
2. resize oversized source;
3. use WebP where quality is preserved;
4. compare visuals;
5. update references;
6. test low/mid-range device.

## 11. Audio Optimization

WAV is acceptable for initial migration.

Optional compression later only if:
- pronunciation remains clear;
- local playback remains reliable;
- all references update;
- full audio QA passes.

Never stream.

## 12. Font Offline Rule

Forbidden:

```text
https://fonts.googleapis.com/...
```

Use bundled Inter or documented system fallback.

## 13. Asset Validation

Automated validator should check:
- every module image path exists;
- 5 reading audio references exist;
- 15 vocabulary audio references exist;
- 26 unique formal glossary references exist;
- no duplicate content ID;
- all module JSON files load.

Release should fail CI/local validation if required asset is missing.

## 14. Offline QA

Airplane mode:
- launch;
- images;
- reading audio;
- pronunciation;
- content;
- assessment;
- save;
- restart.

No feature should show network loading for local content.
