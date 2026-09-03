# AGENTS.md — EVP Learn Android APK

> **Primary AI agent:** OpenAI Codex in VS Code  
> **Project type:** Flutter/Dart Android application  
> **Product:** EVP Learn — English for Vocational Purposes (Retail)  
> **Final runtime:** Android APK, fully offline  
> **Reference prototype:** `./UI-APK PEMB B.INGGRIS/`

This file is the highest-level operating instruction for Codex when working in the main APK project. Read it before modifying code.

---

## 1. Mission

Build a production-quality Android application that reproduces the customer-approved EVP Learn web prototype as a proper Flutter application.

The current React/Vite prototype is **not** the final application. It is the approved visual, interaction, content-mapping, and behavior reference used to implement the Flutter APK.

The final APK must:
- feel visually consistent with the approved prototype;
- work fully offline after installation;
- preserve the approved learning flow;
- preserve scoring rules exactly;
- use local images, audio, fonts, and academic content;
- persist learning progress and attempt history locally;
- support Indonesian and English system UI;
- run reliably on Android phones;
- not depend on a backend, login, Firebase, Supabase, cloud APIs, or an Internet connection.

---

## 2. Mandatory Read Order

Before starting a meaningful task, read only the documents relevant to that task, beginning with:

1. `AGENTS.md`
2. `docs/INDEX.md`
3. `docs/DECISIONS.md`
4. `docs/PROJECT_SPEC.md`
5. task-specific documents:
   - UI work → `docs/DESIGN.md`
   - feature requirements → `docs/PRD.md`
   - architecture → `docs/ARCHITECTURE.md`
   - dependencies → `docs/TECH_STACK.md`
   - navigation → `docs/NAVIGATION_FLOW.md`
   - academic content → `docs/CONTENT_SPEC.md`
   - persistence → `docs/DATA_MODEL.md`
   - scoring → `docs/SCORING_RULES.md`
   - assets/audio → `docs/OFFLINE_ASSETS.md`
   - localization → `docs/LOCALIZATION.md`
   - migration → `docs/MIGRATION_PLAN.md`
   - QA → `docs/QA_TEST_PLAN.md`
   - release → `docs/RELEASE.md`

Do not blindly scan `.git`, `node_modules`, `dist`, generated build folders, or the entire reference project.

---

## 3. Authority / Source-of-Truth Precedence

When information conflicts, use this order:

1. **Latest explicit customer-approved requirement**
2. `docs/DECISIONS.md`
3. `docs/SCORING_RULES.md` for scoring/state invariants
4. `UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx` for canonical academic material
5. actual approved prototype implementation:
   - `UI-APK PEMB B.INGGRIS/src/App.tsx`
   - `UI-APK PEMB B.INGGRIS/src/data.ts`
   - `UI-APK PEMB B.INGGRIS/src/index.css`
   - its local image/audio assets
6. `docs/PRD.md`
7. `docs/DESIGN.md`
8. `docs/ARCHITECTURE.md`
9. existing Flutter implementation

### Critical exception

Old Markdown inside the reference prototype may contain stale rules. In particular, old `DESIGN.md`, `PRD.md`, Figma Make instructions, pasted prompts, and archived specs inside `UI-APK PEMB B.INGGRIS/` do **not** override the main-project documentation.

For visual truth, inspect the **actual implemented prototype**, not stale prose.

---

## 4. Reference Prototype Is Read-Only

Directory:

```text
./UI-APK PEMB B.INGGRIS/
```

is a **READ-ONLY REFERENCE**.

Codex must not:
- redesign or refactor it;
- upgrade its React dependencies;
- modify its source;
- fix its web-only bugs unless the user explicitly asks;
- delete or rename its assets;
- turn it into the Flutter application;
- package the web application with Capacitor/WebView as the final APK;
- use its `node_modules`, `.git`, `dist`, or old generated files as application dependencies.

Allowed uses:
- inspect `App.tsx` for approved behavior/flow;
- inspect `data.ts` for current prototype content structures;
- inspect `index.css` for visual tokens;
- inspect images and audio as migration sources;
- inspect `UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx` for academic content.

A nested guard `UI-APK PEMB B.INGGRIS/AGENTS.md` is provided to reinforce this.

---

## 5. Final Technology Direction

Selected stack:

```text
Framework       Flutter
Language        Dart
Target          Android
Architecture    Feature-first + repository pattern
State           Riverpod
Navigation      go_router
Persistence     SQLite via Drift
Preferences     shared_preferences
Audio           just_audio
Localization    Flutter gen_l10n / ARB + intl where needed
Content         bundled local JSON + typed Dart models
Images          local bundled assets
Fonts           local Inter font files or approved local system fallback
Backend         NONE
Cloud           NONE
Authentication  NONE
Analytics       NONE unless explicitly approved later
```

Do not replace this stack casually. If a package is incompatible with the current Flutter toolchain, explain the problem and propose the smallest compatible adjustment before changing architecture.

---

## 6. Product Scope — Hard Constraints

### In scope
- splash/launch;
- Home;
- Modules;
- Progress;
- Profile;
- 3 unlocked learning modules;
- module overview;
- learning objectives;
- diagnostic Pre-test;
- Pre-test result;
- theory;
- vocabulary preview + pronunciation;
- reading + local reading audio;
- interactive glossary + pronunciation;
- 3 scored practice activities per module;
- matching;
- real drag-and-drop on Android;
- tap-to-match fallback;
- sequencing;
- Post-test;
- final result;
- retry;
- latest score;
- best score;
- visible attempt/evaluation history in final APK;
- Continue Learning / resume;
- local persistence;
- bilingual system UI;
- offline operation.

### Out of scope
Unless the customer explicitly expands scope:
- login/register;
- user accounts;
- teacher account;
- student account;
- admin dashboard;
- Firebase;
- Supabase;
- REST API;
- backend;
- cloud sync;
- online classroom;
- remote content management;
- chat;
- AI tutor;
- push notifications;
- payment;
- ads;
- leaderboard;
- multi-user synchronization;
- server analytics;
- WebView as final architecture.

---

## 7. Approved Navigation

Final bottom navigation has **exactly four primary items**:

1. Beranda / Home
2. Modul / Modules
3. Progres / Progress
4. Profil / Profile

Do **not** revert to the older 3-item design.

Learning flow:

```text
Module Overview
→ Learning Objectives
→ Pre-test
→ Pre-test Result
→ Theory
→ Vocabulary Preview
→ Reading
→ Interactive Practice
→ Post-test
→ Final Result
```

Modules are not sequentially locked.

---

## 8. Academic Content Rules

Canonical academic source:

```text
UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx
```

Do not silently:
- add academic facts;
- rewrite reading passages;
- correct source text;
- change glossary terms;
- replace terminology;
- invent official learning objectives;
- invent “final” official questions.

Current learning objectives and Pre/Post-test banks are prototype-derived unless later academically approved.

Known source issue:
- `Flat-packing` meaning contains `pipih/dUS` in the supplied source. Treat this as **pending confirmation**. Do not silently correct it.

Academic content changes must follow `docs/CONTENT_SPEC.md`.

---

## 9. Scoring Invariants — Never Change Without Explicit Approval

### Pre-test
- 10 MC questions per module;
- raw score `/100`;
- baseline/diagnostic;
- excluded from final score.

### Interactive Practice
- 3 scored activities per module;
- each activity maximum `/10`;
- per-activity formula:

```text
round((correctItems / totalItems) × 10)
```

- total maximum `/30`.

### Post-test
- 10 MC questions per module;
- raw score `/100`;
- weighted score maximum `/70`.

For 10 questions:

```text
weighted = correctAnswers × 7
```

General equivalent:

```text
weighted = (correctAnswers / totalQuestions) × 70
```

### Final
```text
finalScore = postTestWeighted + practiceScore
maximum = 100
```

### Passing threshold
```text
75
```

Threshold is centralized and must be easy to change if the school/customer later confirms another value.

### Learning gain
```text
currentAttempt.postTestRaw - currentAttempt.preTestRaw
```

Do not calculate retry gain against the first-ever baseline.

### Baseline
First-ever Pre-test is preserved separately.

### Completion vs passing
`completed` and `passed` are different concepts.

A module can be:
- completed and passed;
- completed but needs review.

### Retry
Retry must:
- preserve baseline;
- preserve prior completed attempt history;
- start a new current attempt;
- clear current attempt Pre-test/Practice/Post-test data;
- not erase best/latest history.

See `docs/SCORING_RULES.md`.

---

## 10. Progress Invariants

Current approved prototype milestones:

```text
0    Not Started
10   Objectives entered
20   Pre-test completed / Theory entered
35   Theory completed / Vocabulary entered
45   Vocabulary completed / Reading entered
65   Reading completed / Practice entered
80   Practice completed / Post-test entered
100  Module completed
```

Flutter may model progress more semantically, but displayed progress must be deterministic and consistent with this approved flow.

Continue Learning must point to the real last valid learning location, not a fake/hardcoded screen.

---

## 11. Offline-First Rules

Final release must remain useful in airplane mode.

All required runtime resources must be bundled:
- module JSON;
- question banks;
- glossary data;
- images;
- reading audio;
- pronunciation audio;
- fonts.

Forbidden runtime dependencies:
- Google Fonts HTTP import;
- remote image URLs;
- remote audio URLs;
- external CDN;
- API calls required for learning;
- server-side scoring.

If a remote resource is added for development convenience, it must not be required by the release APK.

---

## 12. Data Ownership

Use:
- local JSON/assets for immutable academic content;
- SQLite for learner progress, attempts, answers, and results;
- shared preferences only for small settings such as language and one-time UI flags.

Do not store complex attempt history solely in shared preferences.

Do not copy the web prototype's localStorage design literally. Preserve behavior, not storage technology.

---

## 13. Flutter Architecture Rules

Use feature-first structure. Avoid a monolithic `main.dart`.

UI widgets must not directly execute raw database queries.

Preferred direction:

```text
Presentation/UI
→ Provider/Controller
→ Repository
→ Local data source / Drift database
```

Academic content:

```text
Bundled JSON
→ Content data source
→ Repository/model
→ UI
```

Keep scoring in pure/testable domain functions.

Keep navigation centralized.

Keep theme tokens centralized.

Keep localization strings out of feature widgets when they are system UI text.

---

## 14. Design Preservation Rules

The approved prototype is the visual baseline.

Codex must preserve:
- clean educational style;
- blue primary identity;
- navy typography;
- light neutral background;
- rounded cards;
- clear spacing hierarchy;
- 4-item bottom nav;
- sticky/top app-bar feel;
- readable 17 px-equivalent reading typography;
- module accent identities;
- simple professional illustrations;
- score/result hierarchy;
- glossary bottom-sheet interaction;
- large mobile touch targets.

Do not:
- redesign into Material defaults without matching the prototype;
- introduce neon/glassmorphism;
- add random gradients;
- replace the visual system with a generic template;
- make it childish;
- make it overly corporate;
- add unnecessary animations.

Flutter-native adaptations are allowed only when they improve Android usability without changing approved intent.

---

## 15. Drag & Drop Requirements

For matching practice on Android:
- use Flutter-native drag/drop, preferably `LongPressDraggable`/`Draggable` + `DragTarget`;
- preserve tap-to-match fallback;
- allow re-pairing;
- enforce one source ↔ one target;
- provide clear drag-over visual feedback;
- do not break vertical scrolling;
- test on narrow devices;
- do not reuse browser DOM/pointer code.

Sequence activity may use accessible reorder controls or an approved reorder interaction, but behavior must stay consistent.

---

## 16. Localization Rules

Default locale: Indonesian.

System UI supports:
- `id`
- `en`

Academic English material must remain English unless the academic source explicitly provides translated content.

Do not translate:
- reading passages;
- official titles inside the academic source;
- English vocabulary target words.

Do localize:
- navigation;
- buttons;
- screen labels;
- progress states;
- instructions where localization exists;
- accessibility labels.

---

## 17. Codex Editing Discipline

Before editing:
1. identify task scope;
2. read relevant docs;
3. inspect only relevant reference files;
4. inspect current Flutter implementation;
5. maintain a small plan when task is non-trivial.

During editing:
- prefer minimal focused changes;
- do not perform unrelated refactors;
- do not mass-format unrelated files;
- do not alter academic data unless task requires it;
- do not modify scoring unless task explicitly targets scoring;
- do not add dependencies without need;
- do not edit generated files directly when source generation exists.

After editing:
1. `dart format` changed Dart files;
2. `flutter analyze`;
3. run relevant unit/widget tests;
4. `flutter test`;
5. build APK when task affects integration/release-critical code;
6. inspect `git diff`;
7. report exactly what changed and what was actually verified.

Never claim PASS if not run/verified.

---

## 18. Minimum Validation Gates

For normal code tasks:

```bash
dart format .
flutter analyze
flutter test
```

For navigation, persistence, audio, assets, database, release, or broad UI work:

```bash
flutter analyze
flutter test
flutter build apk --debug
```

Before customer release:

```bash
flutter analyze
flutter test
flutter build apk --release
```

Also perform device/manual QA defined in `docs/QA_TEST_PLAN.md`.

---

## 19. Git Discipline

Unless the user explicitly asks otherwise:
- do not force-push;
- do not rewrite shared history;
- do not delete branches;
- do not commit generated build folders;
- do not commit signing secrets;
- do not commit `.env` secrets;
- do not include reference `node_modules` in new commits.

When the user explicitly asks Codex to commit:
- inspect diff first;
- use a focused message;
- report commit SHA;
- push only if explicitly requested.

---

## 20. Documentation Maintenance

If implementation intentionally changes a documented final decision, update relevant docs in the same task.

Typical mapping:
- feature behavior → `PRD.md`
- UI token/layout → `DESIGN.md`
- package/architecture → `TECH_STACK.md`, `ARCHITECTURE.md`
- database → `DATA_MODEL.md`
- score formula → `SCORING_RULES.md`
- customer decision → `DECISIONS.md`
- open issue → `KNOWN_ISSUES.md`

Do not silently let docs and code diverge.

---

## 21. Definition of Done

A task is not complete merely because code compiles.

It is complete when:
- requested behavior is implemented;
- no unrelated behavior is changed;
- relevant automated checks pass;
- necessary device/manual checks are reported;
- offline constraints remain intact;
- academic content remains correct;
- state/scoring invariants remain intact;
- documentation is updated when required.

See `docs/DEFINITION_OF_DONE.md`.

---

## 22. Required Final Report From Codex

For substantial tasks, report:

```text
SUMMARY
- ...

FILES CHANGED
- ...

BEHAVIOR
- ...

VALIDATION
dart format: PASS/FAIL/NOT RUN
flutter analyze: PASS/FAIL/NOT RUN
flutter test: PASS/FAIL/NOT RUN
APK build: PASS/FAIL/NOT RUN
device test: PASS/FAIL/NOT RUN

REGRESSION NOTES
- ...

OPEN ISSUES
- ...

GIT
commit: ...
push: ...
```

Be factual. `NOT RUN` is preferable to an invented `PASS`.
