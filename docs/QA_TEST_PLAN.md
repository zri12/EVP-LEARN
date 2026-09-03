# QA_TEST_PLAN.md — EVP Learn Android

## 1. QA Goal

Prove:
- features work;
- scoring is correct;
- offline behavior is real;
- persistence is reliable;
- Android touch interactions are usable;
- UI remains consistent;
- no result/history loss occurs during normal restart/retry.

## 2. Automated Test Layers

### Unit
Required:
- scoring engine;
- progress engine;
- attempt lifecycle;
- repository logic;
- content parser;
- content/asset reference validator.

### Widget
Recommended:
- bottom navigation;
- module cards;
- quiz selection;
- result rendering;
- locale switching;
- glossary sheet;
- matching tap behavior;
- practice feedback.

### Integration
Critical:
- fresh install → complete module;
- restart/resume;
- retry;
- history;
- offline audio.

## 3. Device Width Matrix

At minimum:

```text
360 logical px
390 logical px
412 logical px
```

Also test one larger Android phone.

Do not rely exclusively on desktop resize.

## 4. Physical Device Requirement

Before customer release, test at least one real Android device:
- audio;
- touch;
- drag/drop;
- scroll;
- Android back;
- install/update;
- close/reopen.

## 5. Fresh Install

Expected:
- launch;
- splash;
- Indonesian default;
- Home progress 0;
- 0/3 complete;
- no fake Continue;
- all modules accessible.

## 6. Root Navigation

Test:
- Home;
- Modules;
- Progress;
- Profile.

Verify:
- active state;
- no duplicated stack;
- back predictable;
- localized labels.

## 7. Module 1 End-to-End

Test:
- Overview;
- Objectives;
- 10-question Pre-test;
- result;
- Theory;
- 5 vocabulary audio;
- IKEA reading;
- reading audio;
- all 6 formal glossary terms;
- pronunciation;
- 3 Practice;
- Post-test;
- final;
- history.

## 8. Module 2 End-to-End

Test:
- theory/vocabulary;
- POS reading/audio;
- Gondola reading/audio;
- Jacket reading/audio;
- selectors;
- 15 glossary occurrences / 14 unique terms;
- Premium audio;
- Adjustable reused correctly;
- 3 Practice;
- assessment/result.

## 9. Module 3 End-to-End

Test:
- theory;
- vocabulary;
- procedure reading/audio;
- 6 formal glossary targets;
- 3 Practice;
- assessment/result.

Ensure Enter/Hand over are not incorrectly required formal glossary targets.

## 10. Audio QA

Required:
- reading 5/5;
- Vocabulary Preview 15/15;
- formal glossary 26/26 unique.

Check:
- play;
- pause;
- replay;
- switching stops old;
- no overlap;
- duration/position;
- screen change behavior.

Airplane mode ON.

## 11. Drag & Drop QA

Physical Android.

For matching:
- long-press/drag source;
- target highlights;
- drop;
- pair created;
- re-pair;
- occupied target reassign;
- one-to-one invariant;
- feedback resets after edit;
- scroll remains possible;
- tap source → target works.

Test narrow and normal widths.

## 12. Sequence QA

Verify:
- reorder/move;
- correct score;
- partial score;
- boundaries;
- no duplicate/lost item;
- accessible non-drag method if provided.

## 13. Scoring Regression Matrix

Pre:
- 0/10
- 4/10
- 8/10
- 10/10

Practice:
- partial combinations
- max 30

Post:
- 0/10
- 7/10
- 8/10
- 10/10

Threshold:
- 74 → Needs Review
- 75 → Passed
- 100 → Passed

## 14. Learning Gain Retry

Attempt 1:

```text
Pre 40
Post 70
Gain +30
```

Attempt 2:

```text
Pre 70
Post 80
Gain +10
```

Verify:
- baseline 40;
- history preserved;
- Attempt 2 gain +10.

## 15. Latest / Best

Attempt 1 final 80  
Attempt 2 final 70

Expected:
- Latest 70
- Best 80

Attempt 3 final 90:
- Latest 90
- Best 90.

## 16. Idempotency

Try:
- double submit;
- navigate result twice;
- rebuild/background around finalization.

Expected:
- one completed attempt only.

## 17. Persistence

During module:
- close;
- force stop;
- reopen.

Expected:
- valid progress remains;
- resume works;
- submitted results remain;
- no phantom completion.

## 18. Corruption / Recovery

Development tests:
- missing preference;
- unknown locale;
- invalid progress;
- invalid route key;
- missing draft;
- DB migration.

No crash for recoverable state.

## 19. Offline Test

Airplane mode before launch.

Must pass:
- splash;
- root;
- modules;
- images;
- audio;
- quiz;
- practice;
- scoring;
- save;
- restart.

## 20. Localization

Indonesian:
- nav;
- buttons;
- status;
- result;
- profile labels.

English:
same.

Academic reading remains English.

Switching does not reset progress.

## 21. Accessibility / Usability

Check:
- semantics for key controls;
- audio buttons labeled;
- back/close labeled;
- drag instruction available;
- no color-only critical status;
- text scaling;
- touch targets.

## 22. Visual Regression

Compare prototype and Flutter:
- Splash
- Home fresh
- Home returning
- Modules
- Overview
- Objectives
- Quiz
- Theory
- Vocabulary
- Reading
- Glossary
- Practice
- Result
- Progress
- Profile

At 390×844 primary, plus 360/412.

## 23. Release APK

- clean install;
- no debug banner;
- no development URL;
- airplane mode;
- complete smoke flow;
- audio;
- persistence;
- no unnecessary permission prompt.

## 24. Final QA Report Template

```text
BUILD
Flutter:
APK:
Device:
Android:

FUNCTIONAL
Home:
Modules:
Progress:
Profile:
M1:
M2:
M3:

AUDIO
Reading 5/5:
Vocabulary 15/15:
Glossary 26/26:

ASSESSMENT
Pre:
Practice:
Post:
Final:
Gain:
Retry:
History:

OFFLINE
Airplane-mode flow:

MOBILE
360:
390:
412:
Physical DnD:

AUTOMATED
flutter analyze:
flutter test:
release build:

OPEN ISSUES:
```
