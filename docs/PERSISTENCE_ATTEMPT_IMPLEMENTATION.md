# Phase 8 — Persistence & Attempt Lifecycle

Phase 8 connects the accepted learning flow to the existing Drift/SQLite
database. Immutable bundled content and scoring functions remain unchanged.

## Database

The schema is version 2. The migration is additive: it adds attempt stage,
content-version, reading/route resume metadata, assessment order/index metadata,
and practice draft JSON. It never drops tables, deletes rows, or resets learner
data. Completed attempts are treated as immutable application records.

## Lifecycle

`AttemptRepository.startAttempt(moduleId)` creates a collision-safe stable ID,
increments the attempt number, and transactionally marks the module in progress.
If an in-progress row already exists it is returned instead of creating a
duplicate. `updateStage` writes the stage and module milestone together.

The first submitted Pre-test is written to `module_baselines` only when no
baseline exists. Retries create a new attempt ID and preserve completed rows and
the baseline. `finalizeAttempt` validates submitted Pre/Post sessions and all
three completed practice activities, then atomically writes the canonical result,
gain, pass flag, completion time, and module completion state. Repeating it after
completion returns the existing immutable result.

## Draft and resume data

Assessment sessions store stable question IDs, answer maps, and current index in
JSON/columns. This makes exact question order survive provider disposal or a
process restart. Practice rows store matching pairings and sequence order in
`draft_json`; completed activity scores are separate durable values. Malformed
JSON or invalid stable IDs raise a controlled persistence-data error; corrupted
resume state is never silently replaced with an empty or reshuffled draft.

`getCompletedAttempts(moduleId)` returns newest-first history data. Latest is the
most recent completed final score; best is the maximum completed final score.
Ordering is `completedAt DESC`, then `startedAt DESC`, then `attemptNumber DESC`.
Active retries do not affect either value.

There may be one active attempt per module, so several modules can be active at
once. The Home Continue card chooses the active row with the newest
`updatedAt` (module ID descending is the deterministic tie-breaker); module cards remain independent resume entries. A module's current
status becomes In Progress during a retry, while the Home completed count stays
historical (true when that module has any completed attempt).

## UI wiring

Starting a module now creates/resumes its durable attempt, and the root dashboard
loads persisted module progress, completion count, latest/best values, and the
active resume target. The durable repository is the source of truth; Riverpod
controllers hydrate from it after reconstruction and write through meaningful
learner actions.
