# DESIGN.md — EVP Learn Flutter UI/UX Specification

## 1. Design Authority

The approved React/Vite prototype located at:

```text
./UI-APK PEMB B.INGGRIS/
```

is the canonical visual and behavioral reference for the Flutter UI.

Key files:
- `src/App.tsx`
- `src/index.css`
- `src/data.ts`
- `src/imports/`
- `public/audio/`

The Flutter implementation should reproduce the **intent, hierarchy, density, proportions, and interaction model** of that prototype.

This document deliberately replaces stale prototype-era design Markdown.

---

# 2. Design Goal

The UI should feel:

- modern;
- clean;
- educational;
- mobile-first;
- friendly but professional;
- readable for long English texts;
- appropriate for Grade X vocational students;
- consistent across 3 modules.

Avoid:
- childish gamification;
- excessive badges;
- crowded dashboards;
- dark corporate styling;
- neon/glass effects;
- unnecessary gradients;
- generic unstyled Material screens;
- large decorative elements that reduce reading space.

---

# 3. Core Visual Tokens

## 3.1 Primary Palette

| Token | Value | Purpose |
|---|---|---|
| Primary Blue | `#2563EB` | buttons, links, active state |
| Primary Dark | `#1E40AF` | emphasis |
| Deep/Navy Text | `#0F172A` | main text/headings |
| Background | `#F8FAFC` | app background |
| Surface | `#FFFFFF` | cards/sheets |
| Secondary Text | `#64748B` | supporting copy |
| Muted Text | `#94A3B8` | metadata |
| Border | `#E2E8F0` | card/input separators |
| Soft Blue | `#EFF6FF` | selected/soft surfaces |
| Light Blue | `#DBEAFE` | subtle highlight |
| Teal | `#14B8A6` | optional secondary accent |

## 3.2 Semantic Colors

| Meaning | Reference |
|---|---|
| Success | `#22C55E` / green soft surfaces |
| Warning / Needs Review | `#F59E0B` |
| Error / Incorrect | `#EF4444` / red soft |
| Info | primary blue |

Use semantic colors sparingly and never as the sole source of meaning.

---

# 4. Module Identities

### Module 1 — Narrative
- accent: `#2563EB`
- tint: `#EFF6FF`

### Module 2 — Descriptive
- accent: `#7C3AED`
- tint: `#F5F3FF`

### Module 3 — Procedure
- accent: `#0F766E`
- tint: `#F0FDFA`

These accents differentiate modules without changing the global design system.

---

# 5. Typography

## Font

Use **Inter** as a bundled local asset if source files are available and approved.

If local Inter is unavailable during early implementation:
- use a close Android/system fallback temporarily;
- do not add runtime Google Fonts dependency;
- final release should use approved local font assets or a documented fallback.

## Reference scale

Approximate prototype equivalents:

| Role | Size |
|---|---:|
| H1 | 26 logical px |
| H2 | 18 |
| H3 | 16 |
| Body | 14–15 |
| Button | 15 |
| Small/meta | 11–13 |
| Reading | 17 |

### Reading text
Target:
- ~17 logical px;
- line-height around 1.6–1.65;
- high contrast;
- generous vertical rhythm.

Do not reduce reading text simply to fit more content on one screen.

---

# 6. Spacing

Use an 8-point-friendly spacing rhythm.

Typical:
- 4: micro
- 8: compact
- 10–12: small internal gap
- 14–16: card internal gap
- 18–20: standard horizontal page padding
- 24: section spacing
- 32: major spacing

Reference screen horizontal padding: around **20 px**.

---

# 7. Radius

Reference:
- small controls: 8–12;
- buttons: ~14;
- standard cards: 14–18;
- module/hero cards: 20;
- bottom sheet top corners: 24;
- pills: full/capsule when appropriate.

Do not flatten the interface into square Material defaults.

---

# 8. Elevation / Shadow

Use subtle shadows only.

Reference:
- thin borders for most cards;
- soft shadow for selected/important areas;
- bottom navigation has subtle upper shadow;
- no heavy floating-card effect.

---

# 9. Application Shell

## Portrait-first

Primary experience is Android portrait phone.

Prototype reference:
- width 100%;
- max visual reference ~480 px;
- page background `#F8FAFC`.

Flutter should use actual device width rather than hard-capping at 480, but preserve the same density and readable content width.

On tablets/large phones:
- do not stretch reading paragraphs excessively;
- use a centered/max readable content width if necessary.

## Safe areas

Respect:
- Android status bar;
- gesture navigation;
- display cutouts;
- bottom safe area.

---

# 10. Top App Bar

Reference:
- ~64 px height;
- white/near-white background;
- dark text;
- subtle bottom separation;
- back button on detail screens;
- title centered/visually balanced;
- brand mark/controls when appropriate.

Flutter may use a custom `AppBar` or safe-area header, but should match the prototype rather than look like generic Material boilerplate.

---

# 11. Bottom Navigation

## Final — exactly 4 items

1. Beranda / Home
2. Modul / Modules
3. Progres / Progress
4. Profil / Profile

Reference:
- white surface;
- subtle top border;
- active item blue;
- inactive muted;
- icon + small label;
- equal width;
- safe-area aware.

Do **not** use older 3-item navigation.

---

# 12. Button System

## Primary
- blue background;
- white text;
- ~52 px minimum height;
- radius ~14;
- clear pressed state;
- full width in primary learning flow.

## Secondary
- white/light surface;
- border;
- dark text.

## Text/Tertiary
- blue text;
- minimal background.

## Disabled
- visibly disabled;
- never use disabled opacity so low that text becomes unreadable.

Touch target should remain usable even when visual button is compact.

---

# 13. Card System

Common card qualities:
- white surface;
- light border;
- 14–20 radius;
- restrained shadow;
- predictable internal padding.

Use cards for:
- modules;
- vocabulary;
- metadata;
- scores;
- practice;
- quick access.

Avoid nesting too many cards inside cards.

---

# 14. Splash Screen

Must visually preserve:
- EVP Learn logo;
- EVP name;
- English for Vocational Purposes identity;
- simple brand-focused composition.

Current prototype uses a short automatic transition.

Flutter:
- keep launch experience lightweight;
- do not add login or permission prompts before Home.

---

# 15. Home Screen

Key visual areas:
- prominent blue hero;
- EVP Learn identity/greeting;
- Explore Modules or Continue Learning depending state;
- learning progress summary;
- module preview;
- quick access.

Current prototype hero uses a blue gradient:
`#1E3A8A → #3B82F6`.

This gradient is part of the approved Home identity and may be reproduced.

### New user
No fake Continue Learning card.

### Returning user
Continue card must reflect real saved state.

---

# 16. Modules Screen

Each module card:
- module number;
- status;
- title;
- subtitle;
- large illustration;
- progress bar;
- progress text;
- Start/Continue/Review CTA.

Use module accent/tint consistently.

Cards should remain visually spacious on 360 px devices.

---

# 17. Module Overview

Hero area:
- module number;
- title;
- subtitle;
- accent-tinted background;
- module icon/art.

Sections:
- About This Module;
- Learning Objectives preview;
- Learning Journey stepper;
- Start Module CTA.

Learning journey reference:
- Pre-test
- Learn
- Practice
- Post-test

Detailed flow remains defined by navigation docs.

---

# 18. Objectives

Screen:
- module eyebrow;
- “Learning Objectives” title;
- concise intro;
- numbered objective cards;
- Start Pre-test CTA.

Objective cards:
- white;
- thin border;
- numbered accent;
- readable multi-line text.

---

# 19. Assessment Intro

Use:
- centered assessment icon;
- module context;
- Pre-test/Post-test title;
- concise description;
- metadata chips:
  - 10 questions
  - Multiple Choice
- info note for diagnostic Pre-test.

Do not overdecorate.

---

# 20. Quiz Screen

Required visual hierarchy:
1. assessment label;
2. question count;
3. progress bar;
4. optional contextual image/visual;
5. question;
6. 4 options;
7. Previous / Next or Review & Submit controls.

Option:
- minimum touch-friendly height;
- clear selected state;
- letter label A–D;
- no accidental answer reveal during active assessment.

The screen must remain usable with longer option text.

---

# 21. Pre-test Result

Tone should be calm, not overly celebratory or punitive.

Show:
- starting score `/100`;
- correct/incorrect count where available;
- note that diagnostic Pre-test does not affect final score;
- Continue to Material.

---

# 22. Theory Screen

Content should be visually broken into:
- Definition & Purpose;
- Generic Structure;
- Key Language Features.

Use:
- lesson illustration;
- section headings;
- clear cards/lists;
- adequate whitespace.

Do not turn theory into long dense paragraphs.

---

# 23. Vocabulary Screen

Each word card should present:
- target word;
- part of speech;
- Indonesian meaning;
- pronunciation audio button.

Recommended:
- single-column cards;
- clear audio state;
- no fake loading/network spinner.

CTA:
- Continue to Reading.

---

# 24. Reading Screen

Reading is a central product experience.

Required:
- module context;
- reading selector for M2 (1–3);
- title;
- subtitle;
- illustration;
- audio player;
- structured text;
- clickable glossary highlights.

Reference reading text:
- ~17 px;
- line-height ~1.65;
- dark text;
- blue section headings;
- ample paragraph spacing.

### Module 2
Provide a compact selector for the three texts without resetting unrelated module progress.

---

# 25. Audio Player

Approved prototype is compact:
- audio icon;
- title;
- local-audio label;
- play/pause;
- progress line;
- elapsed/duration.

Flutter:
- use local asset playback;
- preserve one active reading/pronunciation behavior sensibly;
- prevent multiple tracks from playing simultaneously unless explicitly designed.

---

# 26. Glossary Bottom Sheet

Reference:
- dark translucent backdrop;
- white sheet from bottom;
- rounded top corners;
- handle;
- close button;
- part of speech;
- large term;
- pronunciation button;
- meaning.

Must:
- support device safe area;
- close by button/back;
- preserve reading position.

---

# 27. Practice Screen

Visual:
- Activity X of 3;
- title;
- instruction;
- progress;
- interaction area;
- feedback;
- Check Answer / Continue.

## Matching
Reference visual:
- source cards;
- target cards;
- pair indication;
- correct/incorrect feedback.

Flutter adaptation:
- on normal phone widths, preserve an easy spatial relationship;
- do not force a two-column layout if it becomes unreadable;
- if stacked layout is used, drag/drop must remain usable;
- tap-to-match is mandatory fallback.

## Drag handle
A subtle grip affordance is acceptable.

## Feedback
Correct:
- success semantics.

Partial:
- clear partial credit.

Incorrect:
- supportive “review/try” semantics.

Show activity score if retained.

---

# 28. Sequence Activity

Prototype uses explicit movement controls.

Flutter may use:
- reorderable list;
- drag handle;
- move-up/down controls.

At least one accessible method must remain available.

Do not make sequence dependent on a fragile gesture.

---

# 29. Final Result

Reference hierarchy:
- large score ring/score emphasis;
- Tuntas / Perlu Review;
- learning summary;
- score breakdown;
- Latest;
- Best;
- Review Material;
- Try Again;
- Back.

Score breakdown:
- Pre-test;
- Post-test raw;
- improvement/gain;
- Post-test weighted;
- Practice;
- Final.

Green indicates passing. Amber indicates needs review.

---

# 30. Progress Screen

Must clearly show:
- overall progress;
- completed module count;
- module cards/rows;
- status;
- progress;
- Latest/Best when available.

Final APK should add **attempt history access** while preserving the same visual language.

Recommended:
- module card → “Riwayat” / “History” action;
- modal/bottom sheet/detail screen with attempts.

Do not overcrowd the main Progress screen with all raw history rows.

---

# 31. Attempt History Design

Each attempt item should show:
- attempt number/date;
- Pre-test;
- Practice;
- Post-test;
- Final;
- Gain;
- status.

Use a compact card/list.

Do not expose internal database IDs.

Chronology:
- newest first in UI;
- immutable completed records.

---

# 32. Profile Screen

Static researcher profile.

Reference:
- large profile icon/avatar;
- title/subtitle;
- labeled fields;
- multi-line supervisors;
- research title.

Do not add:
- edit profile;
- sign out;
- account settings.

---

# 33. Language Selector

Must feel consistent with prototype:
- ID / EN choice;
- clear selected state;
- preference persists.

Root screens should remain consistently localizable, including Profile.

---

# 34. Status Labels

Indonesian:
- Belum Dimulai
- Sedang Dipelajari
- Selesai
- Tuntas
- Perlu Review

English:
- Not Started
- In Progress
- Completed
- Passed
- Needs Review

Do not conflate Completed with Passed.

---

# 35. Motion

Use subtle motion:
- page transition;
- score reveal;
- sheet entrance;
- button press.

Avoid:
- long blocking animations;
- confetti by default;
- motion that interferes with reading.

Respect reduced-motion accessibility where practical.

---

# 36. Responsive / Device Targets

Critical widths for visual QA:
- 360
- 390
- 412 logical px

Also test larger Android devices.

At 360:
- no horizontal overflow;
- options wrap cleanly;
- bottom nav labels fit;
- matching remains usable;
- reading stays comfortable.

---

# 37. Android-Native Adaptation Policy

Allowed:
- SafeArea;
- Flutter-native drag/drop;
- Android back handling;
- native accessibility semantics;
- local asset preload/caching;
- ReorderableListView when it preserves approved sequence behavior.

Not allowed without approval:
- new navigation model;
- new theme;
- new dashboard concept;
- new module lock logic;
- different assessment flow;
- generic Material redesign.

---

# 38. Design QA Checklist

Before a screen is considered migrated:

- [ ] hierarchy matches prototype
- [ ] colors/tokens match
- [ ] typography density matches
- [ ] spacing is consistent
- [ ] touch targets are usable
- [ ] no overflow at 360/390/412
- [ ] Indonesian labels are correctly localized
- [ ] English mode works
- [ ] loading/empty/error states are intentional
- [ ] no network-dependent design element
- [ ] dark/unapproved styles were not introduced
