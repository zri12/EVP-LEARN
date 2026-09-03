# PROJECT_SPEC.md — EVP Learn Android APK

## 1. Product Identity

**Product name:** EVP Learn  
**Expanded context:** English for Vocational Purposes  
**Domain:** Retail / vocational English learning  
**Platform:** Android  
**Delivery:** Installable APK; AAB may be produced later if Play Store distribution is needed  
**Mode:** Offline-first / fully usable offline  
**Primary target:** Grade X SMK, Kurikulum Merdeka Phase E

The application is a mobile teaching material designed around English text types and retail contexts.

## 2. Research Context

Current prototype profile information:

- Researcher: **AFRIDA DWI RAHMAWATI** — verify final spelling before release
- NIM: **805230006**
- Study Program: **Tadris Bahasa Inggris**
- Faculty/Program: **Pascasarjana**
- University: **Universitas Islam Negeri Sulthan Thaha Saifuddin Jambi**
- Supervisors:
  1. Prof. Dr. Martinis, M.Pd
  2. Tartila, M.Pd, Ed.D
- Current research title:
  **The development of Android-based Teaching Materials in English Language Learning for Vocational High Schools**
- Year: **2026**

These profile fields are static researcher/developer information, not a user account.

## 3. Problem the Product Solves

The product provides a structured, self-contained English learning experience for vocational students without requiring:
- an Internet connection;
- account creation;
- school server infrastructure;
- a teacher dashboard;
- cloud services.

It combines:
- theory;
- vocabulary;
- contextual reading;
- pronunciation/audio;
- interactive practice;
- diagnostic and final assessment;
- local progress tracking.

## 4. Product Goals

### G1 — Deliver a coherent learning journey
Students should be able to move from initial diagnosis to theory, vocabulary, reading, practice, and evaluation without confusion.

### G2 — Work offline
All core learning functions must remain available in airplane mode.

### G3 — Be appropriate for SMK learners
The interface should be clear, modern, professional, and friendly without being childish.

### G4 — Support research/evaluation
The application should preserve:
- baseline Pre-test;
- current attempt scores;
- learning gain;
- latest score;
- best score;
- attempt history;
- timestamps.

### G5 — Make academic content replaceable
When the customer/supervisor changes material or questions, content should be replaceable without rewriting navigation or scoring logic.

### G6 — Preserve approved UI/UX
Flutter implementation should reproduce the approved prototype rather than introducing a new visual direction.

## 5. Non-Goals

This release is not:
- a school LMS;
- a classroom management platform;
- a cloud assessment platform;
- a multi-user system;
- a social learning network;
- an AI tutor;
- a content management system;
- a teacher analytics dashboard.

No authentication is required.

## 6. Primary User

### Grade X Vocational Student

Needs:
- simple navigation;
- readable text;
- clear instructions;
- reliable audio;
- immediate interaction feedback;
- understandable result screens;
- the ability to retry;
- progress that remains after closing the app.

Assumptions:
- mostly portrait phone usage;
- varying device widths;
- possible intermittent/no Internet;
- touch is the primary interaction method.

## 7. Secondary User

### Researcher / Developer

Needs:
- static profile display;
- consistent assessment logic;
- local result history;
- replaceable academic content;
- a stable APK for demonstration/research.

The researcher is not an authenticated app user.

## 8. Information Architecture

Primary navigation:

```text
Home
Modules
Progress
Profile
```

Secondary/support pages:
- How to Use
- Learning Outcomes

Learning hierarchy:

```text
App
└── Module
    ├── Overview
    ├── Objectives
    ├── Pre-test
    ├── Pre-test Result
    ├── Theory
    ├── Vocabulary
    ├── Reading
    ├── Practice
    ├── Post-test
    └── Final Result
```

## 9. Final Module Set

### Module 1
**Narrative Text — Inspirational Business Stories**  
Primary reading: **The Story of IKEA**

### Module 2
**Descriptive Text — Retail Products & Store Fixtures**

Readings:
1. Modern Touchscreen POS Terminal
2. Heavy-Duty Supermarket Gondola Shelving
3. Vintage Leather Biker Jacket

### Module 3
**Procedure Text — Store Standard Operating Procedures**

Reading:
**How to Process Customer Checkout Using a POS Terminal**

All 3 modules remain unlocked.

## 10. Assessment Inventory

Current prototype baseline:

| Type | Per module | 3 modules |
|---|---:|---:|
| Pre-test MC | 10 | 30 |
| Post-test MC | 10 | 30 |
| Interactive practice | 3 | 9 |

Total MC questions currently represented: **60**.

The current question banks are prototype-derived and require academic validation if the customer later supplies official questions.

## 11. Offline Data Split

### Bundled, immutable content
- theory;
- vocabulary;
- readings;
- glossary;
- question bank;
- practice definitions;
- images;
- audio;
- localization resources.

### Mutable local data
- language preference;
- current route/stage;
- module progress;
- current attempt;
- assessment drafts;
- practice results;
- completed attempts;
- latest score;
- best score;
- baseline Pre-test.

Mutable data is stored locally on the device.

## 12. Completion Definition

A module is **Completed** after the user completes the Post-test and a valid final result is stored.

Completion does not imply passing.

Possible result:
- `Completed + Passed`
- `Completed + Needs Review`

## 13. Product Acceptance Summary

The final Android release is acceptable when:
- all 3 modules work end-to-end;
- all required audio is local and playable;
- academic content matches the approved source;
- progress survives app restart;
- scoring matches `SCORING_RULES.md`;
- retry preserves history and baseline;
- drag/drop works on physical Android;
- tap fallback remains available;
- UI matches approved prototype;
- no Internet is required;
- release APK installs and launches normally.

See `DEFINITION_OF_DONE.md` and `QA_TEST_PLAN.md` for full gates.
