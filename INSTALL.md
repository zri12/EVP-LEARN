# INSTALL.md — Place This Documentation Pack Into the Main Project

This ZIP is designed to be extracted into:

```text
PROJECT APK PEMBELAJARAN B.INGGRIS/
```

Expected result:

```text
PROJECT APK PEMBELAJARAN B.INGGRIS/
├── AGENTS.md
├── CLAUDE.md
├── CODEX.md
├── DESIGN.md
├── PRD.md
├── ARCHITECTURE.md
├── README.md
├── INSTALL.md
├── docs/
│   └── ...
└── UI-APK PEMB B.INGGRIS/
    ├── AGENTS.md   # read-only guard from this pack
    ├── src/
    ├── public/
    ├── src/imports/MATERI_AFRIDA.docx
    └── ...
```

## Important

The pack intentionally contains:

```text
UI-APK PEMB B.INGGRIS/AGENTS.md
```

to replace the old Figma-Make-oriented AGENTS instructions in the reference subtree.

Its purpose is to tell Codex:
- the reference project is read-only;
- the active project is Flutter;
- parent project documentation has authority.

It does **not** modify the prototype source code.

## After Extraction

In VS Code:

1. open the main project folder, not the nested prototype folder;
2. start Codex from the main project workspace;
3. ask Codex to read `AGENTS.md` and `docs/INDEX.md`;
4. only then initialize/build the Flutter application.

Recommended first Codex task:

```text
Read AGENTS.md and all documentation under docs/ that is relevant to project initialization.
Inspect UI-APK PEMB B.INGGRIS only as a read-only reference.
Do not code yet.
Report the final implementation rules, open decisions, and proposed Flutter initialization plan.
```
