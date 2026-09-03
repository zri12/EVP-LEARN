# PRD.md — EVP Learn Android APK

## 1. Document Purpose

This PRD defines the final functional behavior of the Flutter Android implementation.

It replaces stale web-prototype PRD assumptions where they conflict with:
- customer-approved prototype behavior;
- latest customer decisions;
- `UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx`;
- the main project `DECISIONS.md`.

# 2. Product Requirements

## 2.1 Launch / Splash

Required:
- EVP Learn logo/icon;
- brand title;
- EVP/retail learning subtitle or equivalent approved prototype text;
- brief launch transition;
- no login prompt.

Behavior:
- launch directly into Home after a short intentional splash;
- do not require network initialization;
- do not block on database work longer than necessary;
- if database initialization fails, show a controlled recovery state rather than crashing.

# 3. Primary Navigation

Bottom navigation must contain exactly:

1. Beranda / Home
2. Modul / Modules
3. Progres / Progress
4. Profil / Profile

Rules:
- visible on primary root screens;
- selected state clearly highlighted;
- safe-area aware;
- no horizontal scrolling;
- preserve navigation state appropriately;
- lesson detail screens may use a back-oriented app bar rather than the full root-navigation emphasis.

# 4. Home

## New User State

Must show:
- EVP Learn identity;
- short invitation/introduction;
- Explore Modules CTA;
- overall progress = 0;
- 0 of 3 modules completed;
- module overview/preview;
- quick access to supporting pages if retained.

Must **not** show a fake Continue Learning card.

## Returning User State

May show:
- Continue Learning;
- actual last module/section;
- real module progress;
- overall progress;
- completed module count.

Continue Learning must navigate to the actual valid saved stage.

If the last module is completed, the UI should avoid misleading “continue” wording. It may use review wording or choose an in-progress module according to documented logic.

# 5. Modules

Display 3 module cards.

Each card includes:
- module number;
- title;
- subtitle;
- module illustration;
- state:
  - Not Started
  - In Progress
  - Completed
- progress;
- CTA:
  - Start Module
  - Continue Module
  - Review Module

All modules are available without lock/unlock prerequisites.

# 6. Module Overview

Must show:
- module number;
- title;
- subtitle;
- approved module visual identity;
- About This Module;
- short objective preview;
- learning journey/stepper;
- Start Module CTA.

The UI should closely follow the approved prototype hierarchy.

# 7. Learning Objectives

Display current module objectives in an easy-to-scan list.

Important:
- current objectives are prototype-derived;
- do not represent them as supervisor-approved academic final content unless explicitly approved later;
- objectives should be data-driven, not hardcoded in screen widgets.

CTA:
- Start Pre-test.

# 8. Pre-test

Purpose:
diagnostic baseline before learning.

Required:
- 10 questions per module;
- 4 options per MC question;
- one correct answer;
- question number/progress;
- previous/next navigation;
- answer selection;
- review/submit confirmation;
- all questions should be answerable before final submission.

Scoring:
- raw `/100`;
- excluded from final module score.

Result:
- starting score;
- correct/incorrect summary where available;
- note explaining that Pre-test does not directly affect final score;
- Continue to Learning.

Persistence:
The submitted Pre-test belongs to the current attempt.

First-ever submitted Pre-test for a module becomes the immutable baseline unless the product requirements are explicitly changed.

# 9. Theory

Each module theory screen must be content-driven.

### Module 1
- Definition & Purpose
- Generic Structure
- Key Language Features

### Module 2
- Definition & Purpose
- Identification / Description
- Key Language Features

### Module 3
- Definition & Purpose
- Goal / Materials / Steps
- Key Language Features

Use local lesson visuals consistent with the prototype.

CTA:
- Continue to Vocabulary.

# 10. Vocabulary Preview

Each module currently uses 5 primary Vocabulary Corner words.

Required:
- word;
- part of speech where applicable;
- Indonesian meaning;
- pronunciation control;
- local audio only;
- graceful handling if an expected asset is missing in development.

Do not display a fake playable button when the audio asset does not exist.

Release QA must guarantee expected assets are complete.

# 11. Reading

Required:
- title;
- subtitle/category context where applicable;
- illustration;
- structured reading content;
- section headings;
- local reading audio;
- progress/time display where retained from prototype;
- glossary-enabled highlighted terms;
- readable typography.

Module 2 has 3 selectable reading texts.

Reading audio inventory:
- M1: 1
- M2: 3
- M3: 1

Total: 5 reading tracks.

# 12. Interactive Glossary

When an eligible highlighted term is tapped:
- show bottom sheet/dialog behavior matching prototype intent;
- show word;
- part of speech;
- meaning;
- pronunciation audio when available;
- close affordance;
- accessible semantics.

Formal glossary targets are defined in `CONTENT_SPEC.md`.

Do not infer glossary targets merely because a word occurs in a reading.

# 13. Interactive Practice

Each module has 3 scored activities.

Total:
- 9 scored activities.

Required activity capabilities:
- matching;
- tap-to-match;
- real touch-friendly drag/drop;
- sequencing/reordering;
- per-activity feedback;
- partial credit;
- score maximum `/10` each.

## Matching

Must:
- permit one source ↔ one target;
- permit re-pairing;
- update pairing state deterministically;
- support tap fallback.

## Android drag/drop

Use Flutter-native interaction.

Prefer:
- `LongPressDraggable`
- `DragTarget`

Requirements:
- should not accidentally steal normal page scroll;
- clear active drag visual;
- clear valid target visual;
- works on narrow screens.

## Sequencing

Must permit reordering or accessible movement controls without requiring precision gestures.

# 14. Post-test

Requirements:
- 10 MC questions per module;
- 4 options;
- dynamic scoring;
- submit/review flow;
- raw score `/100`;
- weighted contribution maximum `/70`.

Post-test question bank remains prototype-derived until academic validation.

# 15. Final Result

Must show:
- Pre-test score for current attempt;
- Post-test raw score;
- learning gain;
- Post-test weighted score;
- Practice total;
- Final Score;
- pass/review status;
- Latest Score;
- Best Score.

Recommended:
- clear score visualization;
- status badge;
- Review Material;
- Try Again;
- Back to Home/Modules.

Threshold:
- default 75;
- centralized.

Completion and passing remain separate.

# 16. Retry

Retry starts a new learning attempt.

Must preserve:
- baseline;
- previous completed attempts;
- best score;
- history.

Must reset current attempt:
- Pre-test;
- temporary quiz answers;
- Practice results;
- Post-test;
- final result.

Return user to Objectives or the documented retry entry point.

# 17. Progress

Progress screen must show:
- overall progress;
- 3 module progress entries;
- state per module;
- Latest Score where completed;
- Best Score where completed;
- completed module count.

## Final APK addition: visible attempt history

The final APK should surface **evaluation attempt history** rather than only storing it internally.

At minimum, a user should be able to inspect completed attempts by module, including:
- timestamp/date;
- Pre-test;
- Practice;
- Post-test raw;
- final;
- learning gain;
- pass/review status.

This can be a detail screen or expandable section consistent with `DESIGN.md`.

# 18. Profile

Static profile screen.

Current prototype fields:
- Full Name;
- NIM;
- Study Program;
- Faculty;
- University;
- Supervisors;
- Research Title;
- Year.

This is not a user-account screen.

Final researcher spelling/content must be verified before release.

# 19. How to Use

Support screen should explain the journey in simple steps:

1. choose module;
2. complete Pre-test;
3. study theory;
4. learn vocabulary/audio;
5. read/listen;
6. complete interactive practice;
7. complete Post-test;
8. inspect progress/results.

Exact visual wording may be localized.

# 20. Learning Outcomes

Support screen may show:
- Kurikulum Merdeka;
- Phase E;
- Grade X SMK;
- reading/viewing context;
- learning outcomes approved for the prototype.

Treat broad outcomes as product-support copy unless the academic supervisor supplies exact final wording.

# 21. Localization

System UI:
- Indonesian default;
- English optional.

Language preference persists across restart.

Academic English content should remain English.

See `LOCALIZATION.md`.

# 22. Persistence

The following must survive app restart:
- language;
- module progress;
- last learning location;
- current attempt draft where designed;
- baseline;
- completed attempts;
- latest;
- best;
- final status.

Use SQLite for learning state/history.

# 23. Offline Requirement

With airplane mode enabled, user must still be able to:
- launch app;
- navigate all screens;
- load all content;
- display all images;
- play all required audio;
- complete assessments;
- calculate scores;
- save progress;
- restart and resume.

No core feature may wait for Internet.

# 24. Error Handling

Required controlled behaviors:
- missing/corrupt content JSON → developer-visible error in debug; safe user state in release;
- missing audio asset → non-crashing disabled state, but release QA must catch it before shipping;
- database migration issue → controlled migration/recovery strategy;
- corrupted local preference → fallback to safe default;
- invalid stored route → resume to nearest valid screen;
- incomplete current attempt → preserve valid state without fabricating results.

# 25. Accessibility / Mobile Usability

- touch targets should generally be at least ~44–48 logical pixels;
- semantic labels for icons and audio controls;
- adequate contrast;
- text scales reasonably;
- scroll remains usable;
- drag/drop has tap alternative;
- no critical interaction depends only on color;
- reduced-motion preference should not break comprehension.

# 26. Performance

Target:
- fast launch;
- smooth screen transitions;
- no visible frame drops on common Android devices;
- avoid decoding multiple huge images at full resolution;
- no loading spinner for local content that can be loaded immediately;
- only instantiate/play audio when needed.

Optimize imported prototype assets before release when safe.

# 27. Final Acceptance

See:
- `DEFINITION_OF_DONE.md`
- `QA_TEST_PLAN.md`
- `RELEASE.md`
