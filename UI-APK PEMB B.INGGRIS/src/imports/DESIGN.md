# DESIGN.md — UI/UX Specification
## APK Media Pembelajaran Bahasa Inggris EVP Retail

> **Status:** FINAL DESIGN SPECIFICATION v1.0
> **Purpose:** Source of truth untuk UI/UX, Figma AI Make, designer, dan implementation handoff.
> **Relationship:** `PRD.md` mengatur product behavior/scope. `DESIGN.md` mengatur visual, interaction, layout, component, motion, dan responsive behavior.
> **Target:** Android mobile application, offline-first, modern educational experience untuk Kelas X SMK.
> **Primary tool:** Figma AI Make
> **Important:** Jangan mengubah scope, feature, scoring, flow, atau content dari `PRD.md`. Jika ada konflik, `PRD.md` menang untuk behavior; `DESIGN.md` menang untuk visual/interface.

---

# 1. DESIGN OBJECTIVE

Desain harus menghasilkan aplikasi pembelajaran Bahasa Inggris yang:
- modern;
- clean;
- profesional;
- youthful tetapi tidak childish;
- cocok untuk siswa Kelas X SMK;
- mudah dipahami dalam beberapa detik;
- nyaman untuk membaca teks panjang;
- mendukung fokus;
- interaktif tanpa terasa seperti game anak-anak;
- memiliki visual identity yang konsisten;
- terasa seperti aplikasi edukasi modern, bukan template sekolah lama;
- tidak terlalu corporate;
- tidak terlalu ramai;
- tidak menggunakan efek visual berlebihan;
- tidak bergantung pada internet;
- mudah diterjemahkan ke Flutter setelah desain selesai.

---

# 2. DESIGN PRINCIPLES

## 2.1 Clarity First
Setiap screen harus langsung menjawab:
- user sedang berada di mana;
- user harus melakukan apa;
- progress user sudah sejauh mana;
- action utama apa yang harus ditekan.

## 2.2 Reading First
Karena fokus pembelajaran adalah Reading–Viewing:
- readability lebih penting daripada dekorasi;
- body text tidak boleh terlalu kecil;
- line spacing nyaman;
- tidak ada background animation yang mengganggu;
- tidak ada floating element yang menutupi teks.

## 2.3 Consistency
Semua screen menggunakan:
- color system yang sama;
- typography scale yang sama;
- radius yang sama;
- spacing scale yang sama;
- icon style yang sama;
- button hierarchy yang sama;
- transition style yang sama.

## 2.4 Progressive Disclosure
Jangan tampilkan terlalu banyak informasi sekaligus.
- Home hanya menampilkan ringkasan.
- Detail materi muncul setelah module dipilih.
- Glossary muncul saat kata diklik.
- Score breakdown muncul di result.

## 2.5 Friendly Professional
Tone visual:
- approachable;
- calm;
- optimistic;
- structured.

Hindari:
- visual terlalu formal seperti sistem administrasi;
- warna neon;
- ilustrasi anak kecil;
- emoji berlebihan;
- dashboard seperti ERP.

---

# 3. TARGET USER VISUAL PROFILE

Target:
- siswa Kelas X SMK;
- familiar dengan aplikasi mobile modern;
- menggunakan Android;
- usia remaja;
- membutuhkan interface yang cepat dipahami.

Desain harus terasa:
- lebih mature daripada aplikasi SD/SMP;
- lebih ringan daripada LMS formal;
- lebih modern daripada tampilan e-learning tradisional.

---

# 4. VISUAL DIRECTION

## 4.1 Style Name
**Modern Educational — Soft Professional**

## 4.2 Visual Keywords
- clean
- editorial
- modern
- soft
- structured
- readable
- spacious
- rounded
- calm
- educational
- mobile-first
- interactive

## 4.3 Avoid
Jangan gunakan:
- glassmorphism berat;
- neon gradient;
- cyberpunk;
- skeuomorphic;
- 3D glossy UI;
- excessive shadows;
- game-style HUD;
- overly playful cartoon;
- excessive blob shapes;
- moving backgrounds;
- auto carousel;
- multiple competing gradients;
- heavy texture.

---

# 5. COLOR SYSTEM

## 5.1 Core Palette

### Primary Blue
`#2563EB`

Usage:
- primary CTA;
- active navigation;
- selected quiz;
- progress;
- important icon;
- primary link.

### Primary Dark
`#1E40AF`

Usage:
- pressed state;
- selected dark accent;
- emphasized title element.

### Primary Soft
`#EFF6FF`

Usage:
- selected card background;
- info panel;
- module accent background.

### Navy / Main Text
`#0F172A`

Usage:
- heading;
- primary body;
- main navigation text.

### Secondary Text
`#64748B`

Usage:
- subtitle;
- helper text;
- metadata.

### Muted Text
`#94A3B8`

Usage:
- disabled;
- placeholder;
- tertiary text.

### App Background
`#F8FAFC`

### Surface
`#FFFFFF`

### Border
`#E2E8F0`

### Divider
`#EEF2F7`

---

# 6. SECONDARY ACCENT

## Teal
`#14B8A6`

Usage:
- vocabulary;
- audio;
- secondary educational elements;
- optional module accent.

Soft Teal:
`#F0FDFA`

Dark Teal:
`#0F766E`

Do not make teal compete with blue primary.

---

# 7. SEMANTIC COLORS

## Success
Primary: `#16A34A`
Soft: `#F0FDF4`

Use:
- correct;
- completed;
- tuntas;
- success icon.

## Warning
Primary: `#F59E0B`
Soft: `#FFFBEB`

Use:
- review needed;
- attention;
- pending.

## Error
Primary: `#EF4444`
Soft: `#FEF2F2`

Use:
- incorrect;
- destructive warning;
- error.

## Info
Use Primary Blue.

---

# 8. MODULE ACCENT COLORS

Primary app tetap blue.

Module accent hanya sebagai visual differentiation ringan.

## Module 1 — Narrative
Accent: `#2563EB`
Soft: `#EFF6FF`

## Module 2 — Descriptive
Accent: `#7C3AED`
Soft: `#F5F3FF`

## Module 3 — Procedure
Accent: `#0F766E`
Soft: `#F0FDFA`

Module colors digunakan hanya pada:
- small badge;
- illustration accent;
- module icon;
- hero highlight;
- progress detail.

Jangan mengganti seluruh theme per module.

---

# 9. TYPOGRAPHY

## 9.1 Font Recommendation
Primary:
**Inter**

Alternative:
**Plus Jakarta Sans**

Recommended final:
- Inter untuk semua UI;
atau
- Plus Jakarta Sans heading + Inter body.

Untuk konsistensi implementation paling sederhana:
**Inter only**.

## 9.2 Typography Scale

### Display
- 30 px
- weight 700
- line height 36

### H1
- 26 px
- weight 700
- line height 32

### H2
- 22 px
- weight 700
- line height 28

### H3
- 18 px
- weight 600
- line height 24

### Body Large
- 17 px
- weight 400
- line height 27

### Body
- 16 px
- weight 400
- line height 25

### Body Medium
- 15 px
- weight 500
- line height 22

### Small
- 14 px
- weight 400
- line height 20

### Caption
- 12–13 px
- weight 500
- line height 18

## 9.3 Reading Text
Reading passage:
- minimum 16 px;
- recommended 17 px;
- line height 1.55–1.65;
- max visual line length nyaman;
- jangan justified;
- gunakan left aligned.

---

# 10. SPACING SYSTEM

Gunakan 4-point grid.

Core spacing:
- 4
- 8
- 12
- 16
- 20
- 24
- 32
- 40
- 48

Recommended:
- screen horizontal padding: 20 px
- compact screen padding: minimum 16 px
- section gap: 24–32 px
- card inner padding: 16–20 px
- list item gap: 12–16 px

---

# 11. RADIUS SYSTEM

### Small
8 px

### Medium
12 px

### Card
16 px

### Large Card / Hero
20 px

### Bottom Sheet
24 px top radius

### Pill
999 px

Jangan random radius.

---

# 12. SHADOW SYSTEM

Gunakan sangat halus.

### Card Shadow
- low elevation;
- soft blur;
- opacity rendah.

Visual goal:
card terlihat separated dari background tanpa floating berlebihan.

Sebagian card cukup menggunakan border `#E2E8F0` tanpa shadow.

---

# 13. ICON SYSTEM

Gunakan satu family icon saja.

Recommended:
- Lucide
- Material Symbols Rounded
- Phosphor Rounded

Style:
- rounded outline;
- consistent stroke;
- 20–24 px.

Jangan campur:
- emoji;
- filled icon;
- 3D icon;
- outline icon random.

---

# 14. ILLUSTRATION STYLE

## 14.1 Main Style
**Modern editorial semi-flat illustration**

Characteristics:
- clean shapes;
- subtle depth;
- soft shadow;
- realistic proportions;
- modern retail context;
- not childish.

## 14.2 Product Visual
Untuk POS, Gondola, Jacket:
- semi-realistic product illustration;
- clean background;
- recognizable object;
- educational;
- no advertising style.

## 14.3 Avoid
- stock-photo watermark;
- inconsistent illustration styles;
- anime;
- cartoon kid style;
- hyper-realistic visual yang tidak matching dengan UI.

---

# 15. IMAGE FRAME

Default image container:
- ratio 16:9 atau 4:3 sesuai content;
- radius 16 px;
- clip content;
- light neutral background.

Hero image:
- may use larger 16:10 ratio.

---

# 16. APP SHELL

## 16.1 Mobile Frame

Design baseline:
- 360 × 800
- 390 × 844
- 412 × 915

Figma main frame recommendation:
**390 × 844**

Semua screen harus adaptif ke:
- small Android width 360;
- common Android 390/412.

## 16.2 Safe Area
Respect:
- top status bar;
- bottom gesture/nav bar.

---

# 17. NAVIGATION MODEL

Primary bottom navigation:
1. Home
2. Modules
3. Progress

Do not add:
- Petunjuk
- CP
- Profile

ke bottom nav.

Petunjuk, CP, Profile masuk Quick Access di Home.

---

# 18. BOTTOM NAV DESIGN

Height:
- 72–80 px including safe area.

Style:
- white surface;
- subtle top border;
- optional tiny shadow.

Active:
- primary blue icon;
- blue label;
- optional soft-blue active pill/background.

Inactive:
- gray icon;
- secondary text.

Use:
- icon + label.

---

# 19. TOP APP BAR

Standard:
- 56–64 px height;
- background app background atau white;
- title;
- back button;
- optional action.

Do not use heavy shadow.

---

# 20. BUTTON SYSTEM

## Primary Button
- blue background;
- white text;
- height 52 px;
- radius 14–16 px;
- medium/semibold;
- full width for learning flow CTA.

Example:
`Start Pre-test`

## Secondary Button
- white background;
- blue text;
- blue/light border.

## Tertiary/Text Button
- transparent;
- blue text.

## Disabled
- muted background;
- muted text.

## Destructive
Use red only for destructive confirmation.

---

# 21. BUTTON STATES

Need:
- default
- pressed
- disabled
- loading

Pressed:
- slightly darker;
- scale optional 0.98.

Loading:
- spinner kecil;
- preserve width.

---

# 22. CARD SYSTEM

## 22.1 Standard Card
- white;
- radius 16;
- border soft;
- padding 16–20.

## 22.2 Module Card
Includes:
- module number badge;
- title;
- subtitle;
- image/icon;
- progress;
- status;
- CTA.

## 22.3 Info Card
Soft blue background.

## 22.4 Score Card
Large number + label.

---

# 23. CHIP / BADGE SYSTEM

Use pill for:
- Module 01
- In Progress
- Completed
- Narrative
- Descriptive
- Procedure

Height:
24–30 px.

Keep subtle.

---

# 24. PROGRESS COMPONENTS

## Linear Progress
Height:
6–8 px.

Track:
soft gray.

Fill:
primary/module accent.

## Circular Score
Use on final result only.

Avoid multiple donut charts.

---

# 25. MASTER SCREEN LIST

Design must cover:
1. Splash
2. Home
3. Modules
4. Module Overview
5. Learning Objectives
6. Pre-test Intro
7. Pre-test Question
8. Pre-test Submit Confirmation
9. Pre-test Result
10. Theory
11. Vocabulary Preview
12. Reading
13. Glossary Bottom Sheet
14. Interactive Practice — Matching
15. Interactive Practice — Drag & Drop
16. Interactive Practice — Sequencing
17. Practice Feedback Correct
18. Practice Feedback Incorrect
19. Post-test Intro
20. Post-test Question
21. Post-test Submit Confirmation
22. Final Result
23. Score Comparison
24. Progress
25. Petunjuk
26. Capaian Pembelajaran
27. Profile
28. Empty State
29. Error State
30. Continue Learning State on Home

Screen variant dapat reuse template.

---

# 26. SPLASH SCREEN

## Layout
Centered vertically.

Elements:
- logo placeholder;
- app name;
- short subtitle;
- subtle loading indicator.

Background:
- off-white or very soft blue;
- optional minimal abstract shape.

## Motion
Logo:
- fade in;
- slight scale 0.96 → 1.0.

Duration:
500–700 ms.

No elaborate intro.

---

# 27. HOME SCREEN

## Goal
Memberikan:
- orientation;
- Continue Learning;
- progress summary;
- access to modules;
- quick access.

## Layout Order
1. Greeting/header
2. Continue Learning card
3. Learning Progress summary
4. Your Modules
5. Quick Access
6. Bottom Navigation

## Header Copy
Recommended:
`Ready to learn?`

Subtitle:
`Continue your English learning journey.`

Do not invent student name.

---

# 28. CONTINUE LEARNING CARD

Prominent but not full-screen.

Elements:
- small label `Continue Learning`;
- module title;
- current section;
- progress bar;
- CTA `Continue`.

Use module accent.

If no progress:
- hide;
atau
- replace with `Start Learning`.

---

# 29. HOME PROGRESS SUMMARY

Example:
`2 of 3 Modules Completed`

Linear progress.

Optional:
`67% overall progress`

Do not use analytics dashboard style.

---

# 30. HOME MODULE PREVIEW

Show all 3 compact cards atau horizontal scroll only if needed.

Recommended:
vertical stacked compact card atau 2-column if comfortable.

Prefer no auto carousel.

---

# 31. QUICK ACCESS

Cards:
- Petunjuk
- Capaian
- Profil

Progress sudah di bottom nav.

Icon + label.

---

# 32. MODULES SCREEN

Header:
`Learning Modules`

Subtitle:
`Choose any module to start learning.`

All modules unlocked.

Each card:
- Module number;
- accent;
- title;
- subtitle;
- status;
- progress;
- CTA.

---

# 33. MODULE CARD SPEC

Example:

```text
[01]   Narrative Text

Inspirational Business &
Brand Stories

[illustration]

██████░░░░ 60%

In Progress

Continue →
```

Completed:
- green check;
- `Completed`;
- final score optional.

Not Started:
- no progress fill;
- CTA `Start`.

---

# 34. MODULE OVERVIEW

## Hero
- Module badge
- Title
- Subtitle
- Hero illustration

## Sections

### About This Module
Short description.

### You Will Learn
3–5 bullet/objective highlights.

### Learning Journey
1. Pre-test
2. Learn
3. Practice
4. Post-test

Show vertical stepper.

## CTA
`Start Module`
or
`Continue Module`.

---

# 35. LEARNING JOURNEY COMPONENT

Vertical timeline.

State:
- Upcoming: gray
- Current: primary blue
- Completed: green

Do not lock modules, but within selected module journey may show current stage.

---

# 36. LEARNING OBJECTIVES SCREEN

Header:
`Learning Objectives`

Intro:
`After completing this module, you will be able to:`

Each objective:
- number;
- short heading;
- description.

Use vertical cards or list.

CTA bottom:
`Start Pre-test`.

---

# 37. PRE-TEST INTRO

Visual mood:
calm, diagnostic, non-threatening.

Elements:
- icon illustration;
- title `Diagnostic Pre-test`;
- description;
- metadata:
  - 10 questions
  - multiple choice
  - estimated duration optional
- info card:
  `Your pre-test score does not affect your final module score.`

CTA:
`Start Pre-test`.

---

# 38. ASSESSMENT QUESTION TEMPLATE

Used by Pre-test and Post-test.

## Top
- assessment type;
- question counter;
- progress bar.

## Body
Question text.

## Options
4 option cards.

## Bottom
Previous / Next.

## Option Card
Height flexible;
padding 16;
radius 14;
border.

Selected:
- soft blue background;
- blue border;
- blue letter badge.

Unselected:
- white;
- neutral border.

---

# 39. QUESTION OPTION LETTER

A/B/C/D rendered in 32–36 px circular/square badge.

Unselected:
soft gray.

Selected:
primary blue.

---

# 40. ASSESSMENT NAVIGATION

Top indicator:
`Question 3 of 10`

Linear progress.

Previous:
secondary/text style.

Next:
primary.

On last:
`Review & Submit`.

---

# 41. SUBMIT CONFIRMATION

Use bottom sheet or dialog.

Title:
`Submit your answers?`

Body:
`Make sure you have answered all questions.`

Actions:
- `Review Answers`
- `Submit`

If unanswered:
show warning and count.

---

# 42. PRE-TEST RESULT

Hero:
large score.

Example:
`60 / 100`

Supporting:
- 6 correct
- 4 incorrect

Info:
`This score represents your starting knowledge.`

CTA:
`Continue to Learning`

Do not show celebratory confetti.

---

# 43. THEORY SCREEN

## Top
Module context:
`Module 1 · Narrative Text`

Small journey indicator:
`Learn · Step 2 of 4`

## Content
- Definition & Purpose
- Generic Structure
- Key Language Features

Use:
- section headers;
- cards;
- timeline;
- examples.

Avoid:
- one giant text block.

---

# 44. GENERIC STRUCTURE VISUAL

Use vertical step/timeline.

Narrative:
- Orientation
- Complication
- Resolution
- Re-orientation

Procedure:
- Goal
- Materials
- Steps

Descriptive:
- Identification
- Description

Each item:
- title
- short description
- icon or number.

---

# 45. VOCABULARY PREVIEW

Header:
`Vocabulary Preview`

Subtitle:
`Learn these words before reading.`

Each card:
- word;
- part of speech;
- Indonesian meaning;
- speaker icon.

Recommended:
1-column list.

---

# 46. VOCABULARY AUDIO BUTTON

Speaker icon:
- 40–44 px touch target;
- soft teal background.

Playing:
- subtle pulse ring once or small animated sound bars.

Do not autoplay.

---

# 47. READING SCREEN

This is a high-priority screen.

## Top
- module context
- reading title
- optional hero image

## Audio Card
`Listen to Reading`

Controls:
- play/pause;
- restart;
- progress;
- current / total duration.

## Text
Section headings:
- Orientation
- Complication
etc.

Body:
17 px recommended.

Interactive vocabulary highlighted.

---

# 48. READING AUDIO CARD

Style:
- soft teal or soft blue;
- compact;
- radius 16.

Controls:
- Play/Pause large 44 px
- Restart 40 px
- timeline
- duration

No waveform-heavy visualization.

---

# 49. CLICKABLE GLOSSARY WORD

Target word style:
- subtle underline;
- soft tinted background optional;
- medium weight.

Must still look like part of reading.

Do not make every keyword blue link.

---

# 50. GLOSSARY BOTTOM SHEET

Open from bottom.

Top handle.

Content:
- Word
- part of speech
- pronunciation icon
- Indonesian meaning
- optional example sentence if master content provides

CTA:
`Close` optional.

Radius top:
24 px.

---

# 51. GLOSSARY MOTION

Bottom sheet:
- slide up;
- fade;
- 250–300 ms.

Backdrop:
- subtle dark overlay.

---

# 52. INTERACTIVE PRACTICE INTRO

Optional compact intro.

Title:
`Interactive Practice`

Subtitle:
`Apply what you have learned.`

Show:
- 3 activities
- max score 30

CTA:
`Start Practice`.

---

# 53. MATCHING PRACTICE

Layout mobile:
- items and targets clearly separated;
- avoid tiny columns.

Preferred interaction:
tap-to-match can coexist with drag if drag difficult.

States:
- idle
- selected
- matched
- correct
- incorrect.

---

# 54. DRAG & DROP PRACTICE

Draggable card:
- grip icon;
- clear label;
- shadow while dragging.

Drop zone:
- dashed border;
- soft background;
- changes on hover/drag over.

Successful drop:
- snap animation;
- green check.

---

# 55. SEQUENCING PRACTICE

List card:
- drag handle;
- sequence number;
- text.

Dragging:
- elevated card;
- subtle shadow.

Drop:
- smooth reorder.

---

# 56. PRACTICE PROGRESS

Top:
`Activity 2 of 3`

Progress:
linear.

Score optional:
do not show final score while dragging unless helpful.

---

# 57. PRACTICE CORRECT FEEDBACK

Use bottom sheet/card.

Visual:
- green check;
- title `Great job!`
- body `That's correct.`

CTA:
`Continue`

Motion:
check scale 0.8 → 1.

No full-screen confetti.

---

# 58. PRACTICE INCORRECT FEEDBACK

Use:
- warning/error soft card;
- title `Not quite yet`
- helper:
`Try reviewing the sentence again.`

CTA:
`Try Again`

Optional:
single subtle shake on incorrect item.

Avoid harsh red full screen.

---

# 59. POST-TEST INTRO

More achievement-oriented than pre-test.

Title:
`Post-test`

Subtitle:
`You're almost there!`

Metadata:
- 10 questions
- maximum 70 points

CTA:
`Start Post-test`.

---

# 60. POST-TEST QUESTION

Reuse exact assessment template.

Only differences:
- label;
- copy;
- completion messaging.

Consistency is mandatory.

---

# 61. FINAL RESULT SCREEN

High visual priority.

## Hero
- circular score ring;
- final score large;
- status:
  - Tuntas
  - Perlu Review

Example:
`83 / 100`

## Breakdown
- Pre-test /100
- Post-test raw /100
- Post-test weighted /70
- Practice /30
- Final /100
- Learning Gain

## Additional
- Latest Score
- Best Score

## CTA
Primary:
`Review Material`

Secondary:
`Try Again`

Tertiary:
`Back to Modules`

---

# 62. SCORE RING

Animation:
0 → final score.

Duration:
700–900 ms.

Use primary or success depending status.

No spinning loop.

---

# 63. LEARNING GAIN VISUAL

Example:
`Pre-test 50 → Post-test 80`

Below:
`+30 improvement`

Use compact horizontal comparison.

Positive:
green.

Negative:
neutral/warning, not shaming.

---

# 64. COMPLETION CELEBRATION

Only after module completion.

Allowed:
- small burst/confetti particles;
- once;
- max 1 second;
- subtle.

Avoid:
- looping particles;
- loud animation;
- full game celebration.

---

# 65. PROGRESS SCREEN

Header:
`Your Progress`

Overall:
`2 of 3 Modules Completed`

Progress bar.

Then module list.

Each module card:
- title
- status
- progress
- latest/final score if available
- best score optional
- CTA.

---

# 66. PROGRESS STATUS

## Not Started
Gray.

## In Progress
Blue.

## Completed
Green.

Tuntas status can be separate small label.

---

# 67. PETUNJUK SCREEN

Title:
`How to Use the App`

Use numbered steps:
1. Choose a Module
2. Complete Pre-test
3. Study the Material
4. Explore Vocabulary & Audio
5. Complete Interactive Practice
6. Take Post-test
7. Check Your Progress

Each:
- number;
- icon;
- short description.

---

# 68. CAPAIAN PEMBELAJARAN SCREEN

Formal but still modern.

Header:
`Learning Outcomes`

Metadata card:
- Kurikulum Merdeka
- Phase E
- Grade X SMK
- Reading–Viewing

Then competency cards.

Avoid giant plain paragraph.

---

# 69. PROFILE SCREEN

Hero:
- photo placeholder/final;
- name;
- role label:
  `Researcher / Developer`

Information sections:
- NIM
- Program Studi
- Fakultas
- Universitas
- Dosen Pembimbing
- Judul Penelitian
- Tahun

Do not make it social-profile style.

---

# 70. EMPTY STATE

Illustration simple.

Example:
`No learning progress yet.`

CTA:
`Start Learning`

---

# 71. ERROR STATE

Example:
`Something went wrong.`

Helper:
`Please try again.`

CTA:
`Retry`

For missing asset:
use inline graceful fallback.

---

# 72. AUDIO MISSING STATE

Button disabled.

Small text:
`Audio is currently unavailable.`

Do not block reading.

---

# 73. OFFLINE INDICATOR

Because app is offline-first, do not constantly show "Offline".

Optional small info in Petunjuk:
`All core learning content works without internet.`

No network banner unless technically necessary.

---

# 74. MOTION SYSTEM

Motion should:
- reinforce hierarchy;
- provide feedback;
- not distract.

## Duration
Fast:
120–180 ms

Standard:
220–280 ms

Modal:
250–320 ms

Hero/result:
500–900 ms

---

# 75. PAGE TRANSITION

Forward:
- slide slightly from right;
- fade.

Back:
- reverse.

Duration:
220–280 ms.

Do not use:
- flip;
- spin;
- zoom aggressive.

---

# 76. CARD TAP MOTION

Pressed:
scale 1.00 → 0.98.

Duration:
100–150 ms.

---

# 77. QUIZ OPTION MOTION

Selection:
- border color transition;
- soft background;
- check/selected badge.

150–180 ms.

---

# 78. DRAG MOTION

While drag:
- card lifts;
- scale 1.02;
- subtle shadow.

On drop:
- snap;
- color state.

---

# 79. PROGRESS MOTION

Linear progress:
animate from previous value.

Duration:
400–600 ms.

No repeating animation.

---

# 80. RESULT MOTION

- score count-up;
- ring fill;
- status fade in;
- optional tiny celebration.

Sequence:
1. ring;
2. score;
3. status;
4. breakdown.

---

# 81. ACCESSIBILITY

Minimum requirements:
- contrast sufficient;
- body ≥ 15–16 px;
- touch target 44–48 px;
- do not rely only on color;
- selected state uses icon/border/text;
- success/error use icon + text;
- support text scaling;
- scrolling always available;
- no clipped CTA.

---

# 82. RESPONSIVE RULES

## Width 360
- horizontal padding 16;
- 1-column cards;
- buttons full width;
- avoid 2-column vocabulary.

## Width 390–412
- horizontal padding 20;
- 1-column learning cards;
- quick menu may use 3-column if fit.

## Large Android
Maintain max content width visually comfortable.

No stretched giant buttons/text.

---

# 83. LANDSCAPE

App primary orientation tetap portrait.

Landscape must:
- not crash;
- allow scroll;
- not overlap.

No need special tablet dashboard for v1.

---

# 84. CONTENT DENSITY

Per screen:
- max 1 dominant CTA;
- secondary actions below;
- avoid >3 different card styles.

Long learning content should use sections.

---

# 85. COPY STYLE

UI copy should be:
- simple English;
- short;
- positive;
- clear;
- consistent.

Example:
- `Start Module`
- `Continue Learning`
- `Review Material`
- `Try Again`
- `Great job!`

Avoid over-formal English.

---

# 86. LANGUAGE POLICY

Materi utama mengikuti master content.

UI:
English-first sesuai konteks aplikasi pembelajaran.

Indonesian meaning tetap muncul pada glossary/vocabulary sesuai content.

Do not randomly mix Indonesian-English on navigation unless product owner later decides.

---

# 87. DESIGN TOKEN SUMMARY

```text
Primary           #2563EB
Primary Dark      #1E40AF
Primary Soft      #EFF6FF
Navy              #0F172A
Text Secondary    #64748B
Muted             #94A3B8
Background        #F8FAFC
Surface           #FFFFFF
Border            #E2E8F0
Teal              #14B8A6
Success           #16A34A
Warning           #F59E0B
Error             #EF4444

Radius Small      8
Radius Medium     12
Radius Card       16
Radius Large      20
Bottom Sheet      24

Screen Padding    20
Card Padding      16–20
Section Gap       24–32
```

---

# 88. COMPONENT INVENTORY

Figma component set should contain:
- AppBar
- BottomNav
- PrimaryButton
- SecondaryButton
- TextButton
- IconButton
- ModuleCard
- ContinueLearningCard
- ProgressCard
- QuickAccessCard
- StatusBadge
- ModuleBadge
- LinearProgress
- CircularScore
- ObjectiveCard
- JourneyStepper
- VocabularyCard
- AudioCard
- GlossaryWord
- GlossaryBottomSheet
- QuizOption
- QuestionProgress
- DragItem
- DropZone
- SequenceItem
- FeedbackCard
- ResultMetricCard
- InfoBanner
- WarningBanner
- EmptyState
- ErrorState
- ConfirmationSheet

Create variants.

---

# 89. FIGMA COMPONENT VARIANTS

## Button
- Primary / default
- Primary / pressed
- Primary / disabled
- Primary / loading
- Secondary / default
- Secondary / pressed

## Module Card
- Not Started
- In Progress
- Completed

## Quiz Option
- Default
- Selected
- Correct
- Incorrect
- Disabled

## Status Badge
- Not Started
- In Progress
- Completed
- Tuntas
- Perlu Review

## Audio
- Idle
- Playing
- Paused
- Disabled

---

# 90. AUTO LAYOUT

Figma must use Auto Layout extensively.

Rules:
- screen content vertical auto layout;
- card internal auto layout;
- buttons stretch;
- text wraps;
- no unnecessary absolute positioning;
- avoid fixed heights for long text.

Exception:
illustrative hero composition.

---

# 91. FIGMA NAMING

Pages:
```text
00 Foundations
01 Components
02 Splash
03 Home
04 Modules
05 Learning
06 Assessments
07 Practice
08 Results
09 Progress
10 Support
11 Prototype
```

Frame naming:
```text
Home_Default
Home_WithProgress
Modules_Default
ModuleOverview_M1
Pretest_Intro
Pretest_Question
Pretest_Result
Theory_M1
Reading_M1
Glossary_Open
Practice_Matching
Posttest_Question
Result_Tuntas
Result_Review
Progress_Default
```

---

# 92. DESIGN SYSTEM PAGE

Must include:
- colors;
- typography;
- spacing;
- radius;
- shadows;
- icons;
- buttons;
- cards;
- status;
- form/quiz elements;
- motion notes.

---

# 93. PROTOTYPE FLOW

Figma prototype must demonstrate at minimum:

```text
Splash
→ Home
→ Module 1
→ Overview
→ Objectives
→ Pre-test Intro
→ Question
→ Result
→ Theory
→ Vocabulary
→ Reading
→ Glossary
→ Practice
→ Post-test
→ Final Result
→ Progress
```

Also:
- Home → Petunjuk
- Home → CP
- Home → Profile

---

# 94. INTERACTION NOTES FOR FIGMA AI MAKE

AI Make should simulate:
- button transitions;
- card press;
- bottom nav;
- question selection;
- question next/back;
- glossary bottom sheet;
- audio playing state;
- drag/drop concept;
- result animation concept;
- progress updates.

No need to implement real backend.

---

# 95. UI STATES TO DESIGN

Must include:
- fresh user;
- progress exists;
- module not started;
- module in progress;
- completed;
- correct answer;
- incorrect answer;
- no audio;
- empty progress;
- result tuntas;
- result perlu review.

---

# 96. HOME FRESH USER VARIANT

No Continue Learning.

Show hero:
`Start your learning journey`

CTA:
`Explore Modules`

Progress:
0/3.

---

# 97. HOME RETURNING USER VARIANT

Show Continue Learning prominently.

Example:
`Module 2 · Reading`

Progress:
65%.

CTA:
`Continue`.

---

# 98. RESULT TUNTAS VARIANT

- success accent;
- check icon;
- status `Tuntas`;
- positive but restrained.

---

# 99. RESULT PERLU REVIEW VARIANT

- warning accent;
- title `Keep Going`;
- status `Perlu Review`;
- CTA `Review Material`.

Do not use red failure screen.

---

# 100. DO NOT DO — VISUAL

Figma AI Make must NOT:
- invent login/register;
- invent teacher dashboard;
- invent class code;
- invent web admin;
- add online sync UI;
- add leaderboard;
- add chat;
- add streak/gamification unless explicitly added later;
- use dark mode as default;
- use neon gradient;
- use glassmorphism heavy;
- use huge decorative illustration that pushes content below fold excessively;
- use more than 3 main navigation items;
- use random card radii;
- use emoji as primary icons;
- create desktop web layout;
- use mobile design resembling e-commerce;
- overuse purple/teal;
- create children cartoon style;
- introduce features not in PRD.

---

# 101. DO NOT DO — UX

Do not:
- force user through all modules sequentially;
- lock Module 2/3;
- require sign in;
- require internet;
- hide progress;
- autoplay audio;
- show immediate detailed answer discussion in pre-test;
- submit assessment without confirmation;
- compare weighted post-test 70 directly against pre-test 100;
- make back navigation confusing.

---

# 102. ABOVE-THE-FOLD PRIORITY

## Home
- heading
- Continue Learning or Start Learning
- progress

## Module Overview
- module identity
- about
- primary CTA visible or nearly visible

## Assessment
- counter
- question
- options

## Reading
- title
- audio
- start text

## Result
- final score
- status
- improvement

---

# 103. EDUCATIONAL VISUAL HIERARCHY

Priority:
1. task/instruction;
2. content;
3. interaction;
4. feedback;
5. decoration.

Never decoration > content.

---

# 104. MODULE 1 VISUAL DIRECTION

Theme:
business story / innovation.

Hero:
- furniture / flat-pack / retail story.

Accent:
blue.

Illustrations:
- founder context;
- flat-pack;
- assembling;
- warehouse/supplier.

---

# 105. MODULE 2 VISUAL DIRECTION

Theme:
retail products & fixtures.

Accent:
purple.

Hero:
- POS + shelving/product composition.

Submaterial images:
- POS terminal
- Gondola
- Jacket

Use product-centric cards.

---

# 106. MODULE 3 VISUAL DIRECTION

Theme:
store checkout procedure.

Accent:
teal.

Hero:
- cashier checkout / POS.

Use step visual:
1–6.

---

# 107. MICROCOPY EXAMPLES

## Home
`Ready to learn?`

## Module
`Choose any module to start learning.`

## Pre-test
`Let's see what you already know.`

## Theory
`Learn the key concepts before reading.`

## Vocabulary
`Tap the speaker icon to hear the pronunciation.`

## Reading
`Tap highlighted words to view the glossary.`

## Practice
`Apply what you have learned.`

## Post-test
`You're almost there!`

## Result
`Great progress!`

---

# 108. FEEDBACK TONE

Correct:
- `Great job!`
- `Correct!`
- `Well done!`

Incorrect:
- `Not quite yet.`
- `Try again.`
- `Review the sentence and try once more.`

Avoid:
- `Wrong!`
- `Failed!`
- `Bad score!`

---

# 109. VISUAL QA CHECKLIST

Before UI/UX considered final:
- [ ] Primary blue consistent.
- [ ] Typography consistent.
- [ ] Screen padding consistent.
- [ ] Card radius consistent.
- [ ] Icon family consistent.
- [ ] Bottom nav only 3 items.
- [ ] All CTA clear.
- [ ] Reading readable.
- [ ] Quiz options large enough.
- [ ] Glossary interaction visible.
- [ ] Audio controls clear.
- [ ] Progress clear.
- [ ] Result score clear.
- [ ] Module accents subtle.
- [ ] No excessive gradient.
- [ ] No visual overflow.
- [ ] Small Android width tested.
- [ ] Fresh user state designed.
- [ ] Returning user state designed.
- [ ] Error/empty states designed.
- [ ] Tuntas/Review states designed.

---

# 110. FIGMA AI MAKE EXECUTION ORDER

AI Make should produce designs in this order:
1. Foundations
2. Core Components
3. Splash
4. Home
5. Modules
6. Module Overview
7. Learning Objectives
8. Pre-test
9. Theory
10. Vocabulary
11. Reading
12. Glossary
13. Practice
14. Post-test
15. Results
16. Progress
17. Petunjuk
18. CP
19. Profile
20. State variants
21. Prototype connections
22. Visual consistency audit

Do not attempt random screen generation.

---

# 111. DESIGN PRIORITY IF AI MAKE MUST CHOOSE

If any layout decision is ambiguous:
1. Follow PRD flow.
2. Prioritize readability.
3. Prioritize mobile usability.
4. Reuse existing components.
5. Keep visual clean.
6. Avoid adding new features.
7. Use smallest reasonable visual complexity.

---

# 112. SOURCE OF TRUTH RULE

`PRD.md`
= feature, scope, system, scoring, behavior.

`DESIGN.md`
= visual, component, screen layout, interaction, motion.

If a design suggestion would violate PRD:
**do not apply it.**

If PRD has feature but DESIGN does not define exact layout:
use closest reusable pattern from DESIGN.

---

# 113. DESIGN COMPLETION DEFINITION

UI/UX is considered ready for development when:
- design foundations exist;
- reusable components exist;
- all primary screens designed;
- all key states designed;
- navigation prototype works;
- Module 1 full user journey can be prototyped;
- Module 2/3 reuse same templates consistently;
- responsive behavior documented;
- motion notes documented;
- no feature outside PRD appears;
- developer can implement without inventing layout.

---

# 114. FINAL DIRECTIVE TO FIGMA AI MAKE

> Read both `PRD.md` and `DESIGN.md` before generating or revising any interface.
>
> Treat `PRD.md` as the source of truth for features, behavior, scope, scoring, and learning flow.
>
> Treat `DESIGN.md` as the source of truth for visual style, components, layout, motion, interaction, responsive behavior, and UI states.
>
> Build a modern educational Android mobile interface for Grade X vocational students.
>
> Keep the visual style clean, modern, soft-professional, and reading-focused.
>
> Use blue as the primary application color with limited module-specific accents.
>
> Use a consistent spacing system, typography scale, rounded cards, subtle shadows, and one icon family.
>
> Keep the bottom navigation limited to Home, Modules, and Progress.
>
> Use subtle slide/fade transitions and restrained micro-interactions.
>
> Design all learning screens so long English reading content remains highly readable.
>
> Reuse one assessment design for both Pre-test and Post-test.
>
> Reuse one module structure for all three modules while allowing content-specific imagery and accent colors.
>
> Do not create login, register, teacher/student roles, classroom, online database, backend, leaderboard, web admin, or any feature outside `PRD.md`.
>
> Do not invent academic content or change assessment logic.
>
> Do not create a childish, neon, overly gamified, or corporate administrative interface.
>
> Before considering the design complete, verify consistency across the complete flow from Splash → Home → Module → Pre-test → Learn → Practice → Post-test → Result → Progress.
