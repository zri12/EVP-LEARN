# MIGRATION_PLAN.md — Approved Prototype to Flutter

## 1. Principle

This is **not source-code conversion**.

Do not:
- mechanically convert JSX to Dart;
- embed React build;
- use WebView as final;
- copy localStorage architecture literally.

Use:

```text
Approved React prototype
        ↓
extract visual/behavior/content requirements
        ↓
implement equivalent Flutter feature
        ↓
validate side-by-side
```

## 2. Reference Mapping

| Prototype | Flutter target |
|---|---|
| `HomePage` | `HomeScreen` |
| `ModulesPage` | `ModulesScreen` |
| `Overview` | `ModuleOverviewScreen` |
| `Objectives` | `ObjectivesScreen` |
| `AssessmentIntro` | `AssessmentIntroScreen` |
| `Quiz` | reusable `QuizScreen` |
| `PreResult` | `PretestResultScreen` |
| `Theory` | `TheoryScreen` |
| `Vocabulary` | `VocabularyScreen` |
| `Reading` | `ReadingScreen` |
| `GlossarySheet` | modal bottom sheet |
| `Practice` | `PracticeScreen` |
| `FinalResult` | `FinalResultScreen` |
| `ProgressPage` | `ProgressScreen` |
| `GuidePage` | `GuideScreen` |
| `OutcomesPage` | `OutcomesScreen` |
| `ProfilePage` | `ProfileScreen` |

## 3. State Mapping

Prototype:
- React Context;
- localStorage.

Flutter:
- Riverpod;
- Drift/SQLite;
- SharedPreferences for locale.

Preserve behavior, not storage implementation.

## 4. Styling Mapping

Prototype:
- CSS tokens/classes.

Flutter:
- Theme + design token classes.

Extract from `DESIGN.md`.

Do not hardcode colors repeatedly in widgets.

## 5. Content Mapping

Prototype:
- `src/data.ts`.

Flutter:
- local JSON + typed Dart.

Academic verification:
- `UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx`.

If `data.ts` and source differ, follow documented authority.

## 6. Audio Mapping

Prototype:
- `/public/audio/...`.

Flutter:
- `assets/audio/...`.

Use semantic asset paths in JSON.

## 7. Illustration Mapping

Prototype:
- PNG imports;
- React illustration component.

Flutter:
- local images;
- custom painter/widget where appropriate.

Visual result must remain approved.

## 8. Drag/Drop Mapping

Prototype:
- HTML drag;
- pointer events;
- tap fallback.

Flutter:
- LongPressDraggable/Draggable;
- DragTarget;
- tap fallback.

Do not port DOM event code.

## 9. Migration Sequence

A. Reference freeze  
B. Flutter scaffold  
C. Static shell/root screens  
D. Content JSON/models  
E. Assets/audio  
F. Learning screens  
G. Assessment engine  
H. Practice  
I. Persistence/retry/history  
J. QA  
K. Release

See `IMPLEMENTATION_ROADMAP.md`.

## 10. Side-by-Side Validation

For each screen:
1. open prototype;
2. match comparable width;
3. implement Flutter;
4. compare hierarchy/spacing/type/color/content;
5. test Android interaction;
6. adjust Flutter only.

## 11. Web Issues Not to Reproduce

Do not copy:
- stale old Markdown;
- favicon issue;
- web manifest omission of Premium/Revolutionary audio;
- hardcoded English “Module” labels in ID;
- localStorage;
- browser-specific DnD constraints.

Preserve intended behavior, not bugs.

## 12. Academic Changes During Migration

If customer sends revisions:
- update JSON;
- record source;
- keep architecture stable;
- update related audio only if necessary;
- run content validation.

Do not redesign.
