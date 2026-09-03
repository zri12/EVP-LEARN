# Learning Screen Implementation

## Phase 5 scope

The JSON-backed learning flow is available through these routes:

```text
/module/:moduleId
→ /objectives
→ /pretest
→ /theory
→ /vocabulary
→ /reading/:readingId
→ /practice
→ /posttest
→ /final
```

Overview, objectives, theory, vocabulary, reading, interactive Practice,
Post-test, and the in-memory Final Result are now implemented across Phases
5–7. Assessment and Practice state remain in memory until the Phase 8
persistence lifecycle is added.

## Content rendering

All learning content is loaded from the existing typed local JSON repository.
No academic passage, objective, theory, vocabulary, or glossary definition is
duplicated inside a feature widget.

## Audio lifecycle

`LearningAudioController` owns one `just_audio` player for the active learning
screen scope. Starting a reading, vocabulary, or glossary asset replaces the
previous asset, so overlapping tracks cannot play. Leaving a learning screen
stops the active player. Audio failures become a non-blocking error state and
never use a network or TTS fallback.

## Glossary strategy

Each reading uses only its associated formal JSON glossary. A deterministic,
case-insensitive phrase matcher sorts terms longest-first and renders the
matched occurrence as a dedicated tappable span. This supports multi-word
terms and keeps non-formal words, including `Genuine`, `Enter`, `Change`, and
`Hand over`, outside the glossary interaction.

## Phase 5 limitations

- Device speaker output and airplane-mode playback still require physical
  Android QA.
- Drift attempt persistence, retry, resume-after-process-death, and
  latest/best history remain deferred to later phases.
