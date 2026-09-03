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
Prototype stores history conceptually but full history is not prominently rendered.

Final APK should expose history from Progress.

## KI-009 — Mobile Drag
Browser reference has narrow-layout constraints.

Flutter must use native touch DnD and be tested physically.

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
