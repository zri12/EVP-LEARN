# ARCHITECTURE.md — Flutter Architecture

## 1. Objective

Provide a maintainable offline Flutter application where:
- UI can evolve without changing scoring;
- academic content can be replaced without rewriting widgets;
- local persistence is testable;
- retry/history logic is deterministic;
- features are not concentrated in one file.

## 2. Architectural Style

Use:

```text
Feature-first
+ Repository Pattern
+ Riverpod
+ Local-first data sources
```

High-level:

```text
Presentation
   ↓
Controller / Riverpod Notifier
   ↓
Repository
   ↓
Local data source
   ├── Bundled JSON/assets
   ├── Drift/SQLite
   └── Preferences
```

## 3. Recommended Project Structure

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── router.dart
│   └── theme/
│       ├── app_colors.dart
│       ├── app_spacing.dart
│       ├── app_radius.dart
│       ├── app_typography.dart
│       └── app_theme.dart
├── core/
│   ├── constants/
│   ├── errors/
│   ├── localization/
│   ├── utils/
│   └── widgets/
├── data/
│   ├── database/
│   │   ├── app_database.dart
│   │   ├── tables/
│   │   ├── daos/
│   │   └── migrations/
│   ├── content/
│   │   ├── content_loader.dart
│   │   └── content_validator.dart
│   ├── models/
│   ├── repositories/
│   └── sources/
├── domain/
│   ├── models/
│   └── scoring/
│       ├── scoring_engine.dart
│       └── progress_engine.dart
└── features/
    ├── splash/
    ├── home/
    ├── modules/
    ├── objectives/
    ├── assessment/
    ├── theory/
    ├── vocabulary/
    ├── reading/
    ├── glossary/
    ├── practice/
    ├── result/
    ├── progress/
    └── profile/
```

`domain/` may be lightweight. Do not create ceremonial layers with no purpose.

## 4. Feature Folder Pattern

Example:

```text
features/reading/
├── presentation/
│   ├── reading_screen.dart
│   └── widgets/
├── providers/
│   └── reading_provider.dart
└── models/
```

Repositories should remain shared when serving multiple features.

## 5. State Management

Selected: **Riverpod**

Use providers/notifiers for:
- language/settings;
- module progress;
- current attempt;
- quiz draft;
- practice state;
- audio state where shared;
- result history.

Avoid:
- global mutable singleton state;
- widget-local state for persistence-critical values;
- storing entire application state as an untyped map.

Widget-local state is fine for:
- current tab/index;
- temporary animation;
- selected visual item before persistence;
- ephemeral sheet visibility.

## 6. Navigation

Selected: **go_router**

Central route declarations.

Recommended conceptual routes:

```text
/
 /home
 /modules
 /progress
 /profile
 /guide
 /outcomes

 /module/:moduleId
 /module/:moduleId/objectives
 /module/:moduleId/pretest
 /module/:moduleId/pretest/quiz
 /module/:moduleId/pretest/result
 /module/:moduleId/theory
 /module/:moduleId/vocabulary
 /module/:moduleId/reading
 /module/:moduleId/practice
 /module/:moduleId/posttest
 /module/:moduleId/posttest/quiz
 /module/:moduleId/result
 /module/:moduleId/history
```

Flutter paths need not match web byte-for-byte, but semantics should.

## 7. Academic Content Architecture

Do not hardcode full academic modules in widget constructors.

Preferred:

```text
assets/data/modules/module_1.json
assets/data/modules/module_2.json
assets/data/modules/module_3.json
```

Content loader:
1. load local JSON;
2. parse typed models;
3. validate IDs/counts/required fields;
4. expose through repository/provider.

Suggested models:
- LearningModule
- TheoryContent
- VocabularyWord
- ReadingContent
- ReadingSection
- GlossaryWord
- Question
- PracticeDefinition

Keep answer keys in bundled data because app is fully local; never reveal them before submission.

## 8. Persistence Architecture

Use Drift/SQLite for mutable learning state.

Repositories:
- `ProgressRepository`
- `AttemptRepository`
- `AssessmentRepository`
- `SettingsRepository` or settings provider

Do not let UI widgets issue Drift queries.

Database operations should be:
- transactional where finalization writes multiple related values;
- idempotent;
- migration-safe.

## 9. Attempt Lifecycle

Recommended explicit lifecycle:

```text
Not Started
→ In Progress Attempt Created
→ Pre-test Submitted
→ Learning/Practice
→ Post-test Submitted
→ Attempt Finalized
```

Use a stable attempt ID created at attempt start, not only `DateTime.now()` at finalization.

This improves:
- idempotency;
- resume;
- retry;
- duplicate prevention.

Completed attempt rows should be immutable except controlled migration.

## 10. Scoring Engine

Place scoring in pure functions with no Flutter UI dependency.

Responsibilities:
- calculate quiz raw;
- calculate practice activity;
- calculate practice total;
- calculate Post-test weighted;
- calculate final;
- calculate gain;
- determine pass;
- derive latest/best.

Write unit tests before connecting UI.

No duplicated scoring formulas inside screens.

## 11. Progress Engine

Centralize progress mapping.

Input:
- completed milestones/attempt state.

Output:
- percent;
- status;
- resume destination.

Do not let each screen invent percentages.

## 12. Audio Architecture

Use one reusable audio service/controller around `just_audio`.

Goals:
- one active track at a time;
- play/pause;
- duration;
- elapsed position;
- safe dispose;
- local assets only;
- switching reading stops previous track.

Glossary/vocabulary pronunciation may reuse the same player or a controlled secondary player, but avoid overlapping speech.

## 13. Localization Architecture

Use Flutter localization generation with ARB:

```text
lib/l10n/app_id.arb
lib/l10n/app_en.arb
```

Do not create one huge manual translation map inside screens.

Academic content remains content data, not localization strings.

## 14. Error Strategy

Define safe error categories:
- content load error;
- asset missing;
- database error;
- migration error;
- invalid attempt state.

Debug:
- fail loudly enough to catch bad assets/content.

Release:
- avoid crash;
- show controlled recoverable UI;
- no remote crash reporting unless approved.

## 15. Database Migration Strategy

Database has explicit schema version.

Each release:
- increment only on schema changes;
- write migration;
- test upgrade;
- do not use destructive reset for customer data unless explicitly approved.

## 16. Dependency Direction

Allowed:

```text
features → domain/data abstractions
data → domain models
app → features/core
```

Avoid circular imports.

Avoid:
- feature A mutating feature B internals;
- UI importing database table implementation.

## 17. Testing Boundaries

Unit:
- scoring;
- progress;
- content parser;
- repository behavior with test DB.

Widget:
- navigation labels;
- quiz selection;
- result rendering;
- drag/tap matching;
- locale switching.

Integration/device:
- complete module;
- restart/resume;
- offline audio;
- retry/history.

## 18. Architecture Non-Goals

Do not introduce:
- microservices;
- BLoC and Riverpod simultaneously;
- GetX;
- Redux;
- backend abstraction with no backend;
- network repository “for future use”;
- excessive use-case classes.

Keep architecture robust and proportional.
