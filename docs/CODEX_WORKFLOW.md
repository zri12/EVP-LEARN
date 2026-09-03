# CODEX_WORKFLOW.md — Codex in VS Code

## 1. Purpose

This project is expected to be developed primarily with **OpenAI Codex inside VS Code**.

The goal is to keep each Codex session:
- scoped;
- reproducible;
- consistent with customer-approved UI;
- safe around academic/scoring logic.

## 2. Session Startup

For every meaningful task:

1. Read root `AGENTS.md`.
2. Read `docs/INDEX.md`.
3. Read `docs/DECISIONS.md`.
4. Read only task-relevant docs.
5. Inspect current Flutter code.
6. Inspect only equivalent prototype files if visual/behavior comparison is required.

Do not begin by indexing the entire large prototype/reference folder.

## 3. Efficient Reference Inspection

Prefer targeted tools:
- `rg`
- `grep`
- direct file reads
- small code searches

Useful reference:

```text
UI-APK PEMB B.INGGRIS/src/App.tsx
UI-APK PEMB B.INGGRIS/src/data.ts
UI-APK PEMB B.INGGRIS/src/index.css
```

Avoid scanning:
- `.git`
- `node_modules`
- `dist`
- `.codex-checkpoint-uiux`
- old pasted prompts

unless specifically needed.

## 4. Task Classification

### UI task
Read:
- DESIGN
- NAVIGATION
- REFERENCE_BASELINE

### Academic/content
Read:
- CONTENT_SPEC
- KNOWN_ISSUES

### Scoring
Read:
- SCORING_RULES
- DATA_MODEL

### Persistence
Read:
- DATA_MODEL
- ARCHITECTURE
- SCORING_RULES

### Audio/assets
Read:
- OFFLINE_ASSETS
- CONTENT_SPEC

### Release
Read:
- RELEASE
- QA
- SECURITY_PRIVACY

## 5. Planning

For non-trivial task, make a short outcome-based plan.

Good:

```text
1. Inspect approved practice behavior
2. Implement reusable matching state
3. Add LongPressDraggable + DragTarget
4. Preserve tap fallback and scoring
5. Add tests
6. Analyze/test
```

Avoid vague file-only plans.

## 6. Change Scope

A focused request does not authorize:
- unrelated refactors;
- broad dependency upgrades;
- redesign;
- academic rewrites;
- mass rename;
- architecture replacement.

If an outside-scope blocker appears:
- report;
- make smallest essential fix only if necessary;
- otherwise separate task.

## 7. Reference Folder Safety

Never edit:

```text
UI-APK PEMB B.INGGRIS/
```

during normal APK work.

Only read.

## 8. Git Checkpoints

Recommended phase commits:

```text
chore: initialize flutter app architecture
feat: implement app shell and navigation
feat: migrate academic content
feat: implement assessment engine
feat: add offline audio and glossary
feat: implement interactive practice
feat: add local progress and attempt history
test: complete offline regression coverage
chore: prepare android release
```

Use actual changes for final messages.

## 9. Validation

After Dart changes:

```bash
dart format .
flutter analyze
flutter test
```

Integration-critical:

```bash
flutter build apk --debug
```

Final:

```bash
flutter build apk --release
```

Do not claim physical-device interaction PASS without testing it.

## 10. Diff Review

Before commit:

```bash
git status
git diff --stat
git diff
```

Confirm:
- no reference changes;
- no secrets;
- no build outputs;
- no unrelated changes;
- no academic/scoring accident.

## 11. Codex Report Style

```text
Implemented:
- ...

Preserved:
- scoring unchanged
- academic content unchanged

Validation:
- flutter analyze: PASS
- flutter test: PASS
- apk debug build: PASS

Not verified:
- physical-device touch drag

Files:
- ...

Open:
- ...
```

Never say “fully verified” when only static/build tests ran.

## 12. When Codex Must Stop or Ask

If:
- academic source conflicts;
- scoring change is implied but not explicit;
- app ID/signing identity unknown at release;
- source wording looks wrong but no correction approval;
- backend/cloud requirement appears;
- scope materially expands.

Do not invent customer decisions.

## 13. Documentation Update

Decision change → update docs/code/tests together.

Example threshold changes:
- SCORING_RULES
- DECISIONS
- tests
- implementation.

## 14. Completion Gate

Use `DEFINITION_OF_DONE.md`, not “it builds”.
