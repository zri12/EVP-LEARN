# Content Migration Map

## Sources

- Canonical academic source (read-only):
  `UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx`
- Approved prototype-derived source (read-only):
  `UI-APK PEMB B.INGGRIS/src/data.ts`

## Bundled Content

| JSON | Module | Source-final content | Prototype-derived content |
|---|---|---|---|
| `assets/data/modules/module_1.json` | Narrative Text | theory, vocabulary, IKEA reading, glossary | objectives, 10 Pre, 10 Post, 3 practices |
| `assets/data/modules/module_2.json` | Descriptive Text | theory, vocabulary, 3 readings, glossaries | objectives, 10 Pre, 10 Post, 3 practices |
| `assets/data/modules/module_3.json` | Procedure Text | theory, vocabulary, checkout reading, glossary | objectives, 10 Pre, 10 Post, 3 practices |

Every JSON document uses `schemaVersion: 1` and `contentVersion: 1`. Immutable
academic data remains in bundled JSON; learner progress, answers, scores, and
attempt history are deliberately excluded.

## Status and IDs

- `source_final`: directly present in the canonical DOCX.
- `prototype_derived`: current approved prototype content needing academic review.
- `pending_validation`: content retained exactly while awaiting confirmation.

IDs are deterministic and human-readable: `module_1`, `m1_objective_01`,
`m2_reading_03`, `m3_pre_q01`, and `m1_practice_01`. Glossary IDs identify
individual occurrences; duplicate **Adjustable** entries use distinct occurrence
IDs but share the semantic audio key `adjustable`.

## Inventory

- 3 modules, 12 objectives, 15 vocabulary items, and 5 readings.
- 27 formal glossary occurrences / 26 semantic terms and logical audio keys.
- 30 Pre-test questions, 30 Post-test questions, and 9 practice definitions.

## Pending Items

- Module 1 retains approved visible subtitle `Inspirational Business Stories`;
  the DOCX says `Inspirational Business & Brand Stories`.
- Flat-packing retains canonical source wording `Pengemasan barang secara pipih/dUS`.
- Objectives and all question/practice banks remain prototype-derived until
  academic validation.
- Logical audio keys are included, but no physical audio is migrated in Phase 3.
