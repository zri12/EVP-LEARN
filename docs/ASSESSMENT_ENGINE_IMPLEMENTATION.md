# Assessment Engine Implementation — Phase 6

Phase 6 implements the reusable in-memory assessment foundation for Pre-test and Post-test.

## Scope

- `AssessmentSessionController` keeps the module question bank, current index, answer selections, completion state, and one submitted result in Riverpod memory.
- Pre-test and Post-test use the same question renderer and answer identity (`questionId` plus option index).
- Selections remain available when moving next/back. Correctness is evaluated only at submission.
- Submission is refused while any question is unanswered; the UI displays answered/unanswered counts before submission.
- The controller is idempotent after the first successful submission.

## Scoring contract

- Raw assessment score: `round(correct / total × 100)`.
- Pre-test contributes zero to the final score and is diagnostic only.
- Post-test weighted score: `round(correct / total × 70)` (for ten questions this is `correct × 7`).
- Practice activity score: `round(correctItems / totalItems × 10)`; exactly three activity scores form a `/30` summary. Each activity is rounded independently.
- Final score: `postTestWeighted + practiceTotal`, maximum `/100`.
- Passing threshold: `75` (inclusive).
- Learning gain: current-attempt `postTestRaw - preTestRaw`; it may be negative.

## Deliberate non-scope

This phase does not add interactive Practice UI, Drift persistence, retry/history, or normal production access to a fabricated Final Result. `FinalResultPage` is fixture-capable for isolated UI verification only. Academic JSON, audio/assets, and the read-only prototype remain unchanged.
