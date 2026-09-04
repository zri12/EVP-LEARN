# KNOWN_ISSUES.md — Pending Confirmations / Migration Notes

## KI-001 — Learning Objectives
Status: pending academic validation.

Current objectives are derived because canonical DOCX does not provide a clearly separated final objective list matching the UI.

## KI-002 — Pre-test Banks
Status: prototype-derived.

10/module currently; no official complete final bank in canonical source.

## KI-003 — Post-test Banks
Status: prototype-derived.

10/module currently.

## KI-004 — Passing Threshold
75 is current product default; pending school/customer confirmation.

## KI-005 — Flat-packing Meaning
Source contains:

```text
Pengemasan barang secara pipih/dUS
```

Do not silently correct.

## KI-006 — Researcher Full Name
Prototype shows `AFRIDA DWI RAHMAWATI`.

A customer chat snapshot showed `RAHMAWATI`.

Verify final full-name spelling before release.

## KI-007 — Prototype Glossary Manifest
Physical source contains:
- `premium.wav`
- `revolutionary.wav`

Older web manifest omitted them.

Flutter must include both.

## KI-008 — Attempt History UI
Status: resolved in Phase 9.

The final APK exposes completed evaluation history from Progress, including
read-only attempt detail.

## KI-009 — Mobile Drag
Browser reference has narrow-layout constraints.

Flutter uses native touch DnD; human long-press drag, drop, re-pair, and
scrolling were accepted on the Galaxy A15 during Phase 11D.

## KI-010 — Old Reference Markdown
Reference contains stale docs/instructions.

Main docs and nested reference guard override.

## KI-011 — Asset Size
Images/WAV are relatively large.

Optimize only after migration and quality comparison.

## KI-012 — App ID / Signing
Not finalized.

Confirm before production release.

## KI-013 — Content Changes After Supervision
Customer indicated possible academic material adjustment after supervision.

Keep content separate from logic.

## KI-014 — Phase 11D Physical QA
Status: resolved for the submitted human acceptance run (2026-09-04).

The final debug APK was tested offline on Samsung Galaxy A15 (SM-A155F,
Android 16/API 36, `RR8X204QF0J`). Human acceptance reported PASS for the
launcher, splash, all 46 audio clips and replay/lifecycle checks, matching and
sequence gestures, Activity 3 → Summary → Post-test, full Module 1–3 flows,
resume, retry/history, Progress, Android Back, and offline operation. No
unresolved blocker or major was reported. See `docs/ANDROID_DEVICE_QA.md`.
