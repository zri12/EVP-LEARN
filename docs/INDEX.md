# Documentation Index — EVP Learn Android APK

This directory is the implementation baseline for the Flutter APK.

## Read first

| File | Purpose |
|---|---|
| `../AGENTS.md` | Mandatory Codex operating rules |
| `DECISIONS.md` | Final decisions and pending decisions |
| `PROJECT_SPEC.md` | Product identity, scope, users, goals |
| `PRD.md` | Complete functional requirements |
| `DESIGN.md` | Approved UI/UX translation from prototype to Flutter |

## Engineering

| File | Purpose |
|---|---|
| `ARCHITECTURE.md` | Feature architecture and layer boundaries |
| `TECH_STACK.md` | Selected Flutter packages/technology policy |
| `DATA_MODEL.md` | Local persistence schema |
| `OFFLINE_ASSETS.md` | Images/audio/fonts/content asset policy |
| `ASSET_MIGRATION_MAP.md` | Prototype-to-Flutter asset copy provenance |
| `LOCALIZATION.md` | Indonesian/English behavior |
| `LOCALIZATION_ACCESSIBILITY_POLISH.md` | Phase 10 localization, semantics, responsive and analyzer audit |
| `SECURITY_PRIVACY.md` | Privacy and local-only data principles |

## Product logic

| File | Purpose |
|---|---|
| `NAVIGATION_FLOW.md` | Screen map, route flow, resume behavior |
| `CONTENT_SPEC.md` | Academic source mapping and content status |
| `CONTENT_MIGRATION_MAP.md` | Phase 3 bundled content source, status, ID, and inventory mapping |
| `LEARNING_SCREEN_IMPLEMENTATION.md` | Phase 5 learning routes, audio lifecycle, glossary strategy, and limits |
| `ASSESSMENT_ENGINE_IMPLEMENTATION.md` | Phase 6 assessment session, Pre/Post UI, and scoring foundation |
| `PRACTICE_ENGINE_IMPLEMENTATION.md` | Phase 7 matching, sequence, in-memory flow, and persistence boundary |
| `PERSISTENCE_ATTEMPT_IMPLEMENTATION.md` | Phase 8 Drift persistence, attempt lifecycle, resume, retry, and finalization |
| `PROGRESS_HISTORY_IMPLEMENTATION.md` | Phase 9 progress root, completed evaluation history, and read-only attempt detail |
| `SCORING_RULES.md` | Scoring, gain, retry, baseline, attempts |

## Delivery workflow

| File | Purpose |
|---|---|
| `REFERENCE_BASELINE.md` | What the approved prototype represents |
| `MIGRATION_PLAN.md` | React prototype → Flutter implementation approach |
| `IMPLEMENTATION_ROADMAP.md` | Recommended development phases |
| `CODEX_WORKFLOW.md` | Codex-in-VS-Code task workflow |
| `QA_TEST_PLAN.md` | Automated and device test matrix |
| `DEFINITION_OF_DONE.md` | Completion gates |
| `RELEASE.md` | APK build/sign/release procedure |
| `KNOWN_ISSUES.md` | Items intentionally pending confirmation |

## Source-of-Truth Matrix

| Concern | Authority |
|---|---|
| Latest customer decision | latest explicit customer-approved requirement |
| Product decisions | `DECISIONS.md` |
| Academic material | `../UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx` |
| Visual behavior | actual approved prototype source/runtime |
| Scoring | `SCORING_RULES.md` |
| Final feature scope | `PRD.md` |
| Flutter design | `DESIGN.md` |
| Architecture | `ARCHITECTURE.md` |
| Stack | `TECH_STACK.md` |
| Persistence | `DATA_MODEL.md` |
| Offline assets | `OFFLINE_ASSETS.md` |

## Historical Warning

The reference prototype contains older Markdown such as its own `DESIGN.md`, `PRD.md`, Figma Make prompts, and archived specs. They may contain stale rules, including older navigation decisions.

Do not treat those historical files as more authoritative than this documentation pack.

The **implemented prototype** is the visual reference.  
`UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx` is the academic reference.  
The main project's `docs/` folder is the APK implementation reference.
