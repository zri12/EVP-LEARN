# Progress, Evaluation History & Attempt Detail

Phase 9 adds the learner-facing progress surfaces backed by the Phase 8 Drift
database. The root Progress screen shows deterministic module completion,
current progress, and Latest/Best scores. Each module opens a detail route:

```text
/progress/:moduleId
/progress/:moduleId/attempt/:attemptId
```

Module history reads completed attempts only, in the repository's newest-first
order. Cards use the stored attempt number, completion date, status (Passed or
Needs Review), pre-test raw score, practice total, post-test raw score, and
learning gain. Completed attempt details are read-only and validate that the
attempt exists, belongs to the route module, and is completed.

An active attempt is shown separately with its persisted stage and Continue
Learning action. It is excluded from history and does not reduce historical
module completion. Retry/resume and score/lifecycle semantics remain owned by
the Phase 8 repositories; this feature does not recalculate scores.

Fresh modules show zero progress and an empty-history state. The same surfaces
support Indonesian and English system UI and remain local/offline.
