# REFERENCE_BASELINE.md — Approved UI/UX Prototype

## 1. Reference Directory

```text
UI-APK PEMB B.INGGRIS/
```

This is the approved web prototype snapshot used as read-only baseline for Flutter.

## 2. Key Files

### `src/App.tsx`
Reference for:
- screen composition;
- navigation;
- ID/EN UI copy;
- progress behavior;
- result layout;
- practice interaction;
- audio controls;
- profile.

### `src/data.ts`
Reference for:
- 3 module model;
- theory mapping;
- vocabulary;
- readings/glossary;
- current prototype assessments;
- practice definitions;
- threshold.

### `src/index.css`
Reference for:
- colors;
- spacing;
- typography;
- cards;
- mobile breakpoints;
- bottom navigation;
- reading;
- result treatment.

### `UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx`
Canonical academic source.

### `src/imports/`
Approved visual assets.

### `public/audio/`
Audio source inventory.

## 3. Features Present

Prototype includes:
- splash;
- Home;
- 4-item bottom nav;
- Modules;
- Progress;
- Profile;
- Guide;
- Learning Outcomes;
- 3 unlocked modules;
- Objectives;
- 10 Pre/module;
- Theory;
- Vocabulary;
- Reading;
- Reading audio;
- Glossary;
- Pronunciation;
- 3 Practice/module;
- Post-test;
- Final Result;
- Retry;
- baseline/latest/best/history state concept;
- ID/EN;
- browser DnD + mobile pointer fallback.

Flutter reproduces intent, not browser implementation.

## 4. Current Reference Scoring

Prototype already represents:
- threshold 75;
- Pre raw /100;
- Practice /30;
- Post weighted /70;
- current-attempt gain;
- baseline;
- attempt history concept.

`SCORING_RULES.md` is final APK authority.

## 5. Web-only Patterns Not to Copy

- React Context;
- localStorage;
- browser routes;
- HTML drag/drop;
- PointerEvent DOM detection;
- CSS media queries;
- Google Fonts URL;
- Vercel config.

Use Flutter equivalents.

## 6. Known Reference Gaps

### Audio manifest
Physical files include `premium.wav` and `revolutionary.wav`, while an audited web manifest omitted them.

### Historical Markdown
Reference docs may contain obsolete rules.

### Mixed “Module”
Flutter should localize Modul/Module correctly.

### History UI
Prototype stores attempt history conceptually; final APK should expose it.

## 7. Customer Approval State

Customer indicated prototype is generally suitable to proceed, with possible material adjustments after academic supervision.

Therefore:
- visual direction is approved baseline;
- no redesign during Flutter implementation;
- academic content remains replaceable.

## 8. Comparison Method

For each Flutter screen:
1. open reference;
2. use comparable width;
3. implement;
4. compare hierarchy/density;
5. test Android touch;
6. adjust Flutter only.

## 9. Large Reference Contents

The reference ZIP may contain:
- `.git`;
- node_modules;
- dist;
- checkpoints.

Do not migrate these into Flutter.
