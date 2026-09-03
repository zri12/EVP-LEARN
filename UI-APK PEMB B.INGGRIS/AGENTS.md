# AGENTS.md — READ-ONLY APPROVED PROTOTYPE REFERENCE

This directory is **not the active Flutter application**.

It is the customer-approved React/Vite UI/UX prototype retained only as a migration/reference source for the parent Android APK project.

## Mandatory Rule

DO NOT modify files in this directory during normal Flutter APK development.

Do not:
- refactor React;
- update Vite/React packages;
- fix prototype CSS;
- change academic content here;
- change assets here;
- migrate in place;
- package this app as final WebView;
- follow old Figma Make instructions as current APK architecture.

## Allowed Inspection

- `src/App.tsx` — approved screen/interaction behavior
- `src/data.ts` — prototype content/question/practice snapshot
- `src/index.css` — visual tokens
- `src/imports/` — visual assets
- `public/audio/` — audio source
- `src/imports/MATERI_AFRIDA.docx` — canonical academic source

## Parent Documentation Authority

Use:

```text
../AGENTS.md
../docs/
```

Old:
- `DESIGN.md`
- `PRD.md`
- imported Markdown
- pasted prompts
- Figma Make metadata

inside this reference tree may be stale and must not override parent-project documentation.

If the user explicitly asks to edit the web prototype, treat it as a separate scoped task.
