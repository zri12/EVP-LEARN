# DATA_MODEL.md — Local Data Model

## 1. Principle

Immutable academic content lives in bundled JSON/assets.

Mutable learner/application state lives locally in SQLite.

Small non-critical preferences may use SharedPreferences.

## 2. Database Goals

Support:
- module progress;
- Continue Learning;
- current attempt;
- Pre-test;
- practice;
- Post-test;
- final;
- gain;
- baseline;
- history;
- latest/best;
- restart/resume;
- retry;
- future migrations.

## 3. Database Versioning

Start explicit:

```text
schemaVersion = 2
```

Increment only on schema change.

Rules:
- never silently drop history;
- test upgrade path;
- use transactions;
- keep completed attempts immutable.

# 4. Suggested Tables

## 4.1 `module_progress`

One row/module.

```text
module_id              INTEGER PRIMARY KEY
progress_percent       INTEGER NOT NULL DEFAULT 0
status                 TEXT NOT NULL
current_stage          TEXT
current_sub_index      INTEGER
current_attempt_id     TEXT
last_route_key         TEXT
updated_at             DATETIME NOT NULL
completed_at           DATETIME NULL
```

Status:
- `not_started`
- `in_progress`
- `completed`

Completed does not mean passed.

## 4.2 `learning_attempts`

```text
id                     TEXT PRIMARY KEY
module_id              INTEGER NOT NULL
attempt_number         INTEGER NOT NULL
status                 TEXT NOT NULL
content_version        INTEGER NOT NULL DEFAULT 1
current_stage          TEXT NOT NULL DEFAULT 'overview'
current_sub_index      INTEGER NULL
current_reading_id     TEXT NULL
last_route_key         TEXT NULL
started_at             DATETIME NOT NULL
completed_at           DATETIME NULL

pretest_raw             REAL NULL
pretest_correct         INTEGER NULL
pretest_incorrect       INTEGER NULL

practice_total          REAL NOT NULL DEFAULT 0

posttest_raw            REAL NULL
posttest_weighted       REAL NULL
posttest_correct        INTEGER NULL
posttest_incorrect      INTEGER NULL

final_score             REAL NULL
learning_gain           REAL NULL
passed                  BOOLEAN NULL
```

Status:
- `in_progress`
- `completed`

Create stable ID at attempt start, preferably UUID.

## 4.3 `practice_activity_results`

```text
id                     INTEGER PRIMARY KEY AUTOINCREMENT
attempt_id             TEXT NOT NULL
activity_index         INTEGER NOT NULL
activity_type          TEXT NOT NULL
correct_items          INTEGER NOT NULL
total_items            INTEGER NOT NULL
score                  INTEGER NOT NULL
completed              BOOLEAN NOT NULL
draft_json             TEXT NOT NULL DEFAULT '{}'
updated_at             DATETIME NOT NULL
```

Constraint:
unique `(attempt_id, activity_index)`.

Score 0–10 integer.

## 4.4 `assessment_sessions`

For Pre/Post draft persistence.

```text
id                     TEXT PRIMARY KEY
attempt_id             TEXT NOT NULL
assessment_type        TEXT NOT NULL
answers_json           TEXT NOT NULL
submitted              BOOLEAN NOT NULL DEFAULT FALSE
raw_score              REAL NULL
weighted_score         REAL NULL
correct_count          INTEGER NULL
incorrect_count        INTEGER NULL
started_at             DATETIME NOT NULL
submitted_at           DATETIME NULL
question_order_json    TEXT NOT NULL DEFAULT '[]'
current_question_index INTEGER NOT NULL DEFAULT 0
```

Assessment type:
- `pretest`
- `posttest`

Prefer answer mapping by stable question ID if available.

## 4.5 `module_baselines`

Phase 1 selects this explicit table approach so the first-ever submitted Pre-test remains independently preserved.

Optional explicit table:

```text
module_id              INTEGER PRIMARY KEY
attempt_id             TEXT NOT NULL
pretest_raw             REAL NOT NULL
correct_count          INTEGER
incorrect_count        INTEGER
created_at             DATETIME NOT NULL
```

Alternative: derive as earliest submitted Pre-test. If deriving, test it carefully.

## 4.6 Settings

Use SharedPreferences for:
- locale;
- simple one-time UI flags.

Do not duplicate one setting across SQLite and preferences without one authority.

# 5. Derived Values

Latest:
final of most recently completed attempt.

Best:
max completed final.

Attempts count:
count completed attempts.

Baseline:
explicit baseline or first submitted Pre-test.

Cache only if necessary.

# 6. Attempt Finalization Transaction

Pseudo:

```text
BEGIN

validate attempt is in_progress
validate Pre-test exists
validate 3 Practice results
validate Post-test submitted

calculate canonical scores

update learning_attempt
update module_progress to 100/completed
create baseline only if absent

COMMIT
```

On failure:
- do not create half-history;
- preserve recoverable state.

# 7. Idempotency

`finalizeAttempt(attemptId)` must be idempotent.

If already completed:
- return existing result;
- do not duplicate;
- do not mutate history.

# 8. Retry

Retry:
1. preserve completed attempts;
2. preserve baseline;
3. create new attempt;
4. reset current stage to retry entry;
5. attach all new assessment/practice data to new attempt.

# 9. Stable Content IDs

Examples:

```text
module_1
m1_pre_q01
m1_post_q01
m1_practice_01
m2_reading_03
m3_glossary_attach
```

Stable IDs improve drafts/tests/content changes.

# 10. Content Version

Recommended:

```json
{
  "contentVersion": 1,
  "academicSource": "UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx",
  "modules": []
}
```

If question/content IDs change:
- increment content version;
- decide behavior for unfinished drafts;
- never silently rewrite completed historical scores.

# 11. Repository API Sketch

```text
ProgressRepository
- getAllModuleProgress
- getModuleProgress
- updateMilestone
- getResumeTarget

AttemptRepository
- startAttempt
- getCurrentAttempt
- finalizeAttempt
- retryModule
- getAttempts
- getLatestScore
- getBestScore
- getBaseline

AssessmentRepository
- saveAnswer
- loadDraft
- submitPretest
- submitPosttest

PracticeRepository
- saveActivityResult
- getPracticeTotal
```

# 12. Validation

Validate:
- progress 0–100;
- module 1–3;
- activity index valid;
- activity score 0–10;
- final 0–100;
- raw 0–100;
- weighted 0–70.

Invalid stored data:
- avoid crash;
- recover safely;
- do not hide corruption by arbitrary clamping unless appropriate.

# 13. Privacy

Learning data remains local.

See `SECURITY_PRIVACY.md`.
