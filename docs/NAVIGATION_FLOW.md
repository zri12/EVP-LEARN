# NAVIGATION_FLOW.md — Navigation and Learning State

## 1. Root Navigation

```text
Splash
  ↓
Home
├── Modules
├── Progress
├── Profile
├── Guide
└── Learning Outcomes
```

Bottom navigation root destinations:

```text
/home
/modules
/progress
/profile
```

Flutter route names may differ but semantics must match.

## 2. Module Entry

From Home or Modules:

```text
Module Overview
```

If new:
- CTA = Start Module.

If in progress:
- CTA = Continue Module.

If complete:
- CTA = Review Module.

All modules are independently accessible.

## 3. Canonical Learning Flow

```text
Module Overview
  ↓
Learning Objectives
  ↓
Pre-test Intro
  ↓
Pre-test Quiz
  ↓
Pre-test Submit/Review
  ↓
Pre-test Result
  ↓
Theory
  ↓
Vocabulary Preview
  ↓
Reading
  ↓
Interactive Practice (1/3)
  ↓
Interactive Practice (2/3)
  ↓
Interactive Practice (3/3)
  ↓
Post-test Intro
  ↓
Post-test Quiz
  ↓
Post-test Submit/Review
  ↓
Final Result
```

## 4. Progress Milestones

```text
0    Not Started
10   Objectives
20   Theory entry after Pre-test
35   Vocabulary entry
45   Reading entry
65   Practice entry
80   Post-test entry
100  Finalized module
```

Progress must never move backward during an active attempt except an explicit retry creates a new attempt while preserving history.

## 5. Continue Learning

Persist:
- module ID;
- current stage;
- optional sub-index;
- current attempt ID.

Resume logic:
1. validate saved module exists;
2. validate current attempt/state;
3. map stage to safe route;
4. navigate.

If route/state is invalid:
- recover to nearest safe stage;
- never fabricate score/result.

## 6. Home Continue Card Logic

New user:
- no Continue card.

Returning user:
- show only meaningful real state.

Recommended priority:
1. current in-progress module;
2. last in-progress module;
3. if all complete, use review-oriented wording.

## 7. Back Navigation

- Android back moves to previous logical screen;
- root tabs do not create duplicate deep stacks;
- leaving quiz does not silently submit;
- persisted drafts restore where designed;
- destructive reset requires confirmation if added.

## 8. Quiz Navigation

- Previous preserves answer;
- Next follows current prototype requirement;
- final question → Review & Submit;
- submit creates result once;
- result screen requires valid submitted session.

## 9. Reading Navigation

M1: one reading.  
M2: three subtexts.  
M3: one reading.

M2 selector:
- no new attempt;
- preserve module progress;
- stop/switch audio cleanly.

After reading requirement:
- Practice.

## 10. Practice Navigation

3 activities per module.

- results belong to current attempt;
- previous scores remain while moving forward;
- editing a checked answer resets feedback until checked again;
- Activity 3 completion → Post-test.

## 11. Final Result Actions

Review Material:
→ Theory; does not erase completed attempt.

Try Again:
→ new attempt → Objectives.

Back:
→ root.

## 12. Retry State

Retry:
- create new stable attempt ID;
- empty current Pre/Practice/Post;
- keep baseline/history/best;
- module state becomes In Progress.

## 13. Attempt History

Recommended from Progress:
- module → History/detail.

List completed attempts newest first.

No edit/delete in normal student UX.

## 14. Root Tab State

A shell route may preserve root tab state if useful.

Primary requirements:
- predictable back;
- no duplicate root screens;
- progress refreshes after finalization.

## 15. Route Guards

No auth guard.

Validate:
- module ID;
- result state;
- attempt state;
- history module.

Invalid state → safe Modules/Home recovery.

Never lock a module based on another module.
