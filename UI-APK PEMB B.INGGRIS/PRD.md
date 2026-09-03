# PRD — APK Media Pembelajaran Bahasa Inggris EVP Retail

## 1. Informasi Dokumen

**Nama Dokumen:** Product Requirements Document (PRD)  
**Nama Project:** APK Media Pembelajaran Bahasa Inggris EVP Retail  
**Platform:** Android (.APK)  
**Target Pengguna:** Peserta didik Fase E / Kelas X SMK  
**Konteks:** English for Vocational Purposes (EVP) — Retail Context  
**Model Penggunaan:** Pembelajaran membaca mandiri, interaktif, dan dapat digunakan offline  
**Versi PRD:** 1.0  
**Status:** Baseline untuk tahap Struktur & Alur Aplikasi  
**Baseline Materi:** `Materi_Afrida_Revisi_Final_Siap_Aplikasi` versi 1.0  
**Scope Harga Project:** Rp3.500.000  
**Metode Penyimpanan:** Local storage / SQLite  
**Backend:** Tidak digunakan pada scope saat ini  
**Login/Register:** Tidak digunakan pada scope saat ini  
**Web Admin:** Tidak digunakan pada scope saat ini  

---

# 2. Latar Belakang

Project ini adalah aplikasi mobile Android berbentuk installer `.APK` yang dirancang sebagai media pembelajaran Bahasa Inggris berbasis **English for Vocational Purposes (EVP)** dalam konteks pekerjaan ritel untuk peserta didik Kelas X SMK Fase E.

Aplikasi berfokus pada pembelajaran membaca mandiri melalui tiga jenis teks utama:

1. **Narrative Text** — Inspirational Business & Brand Stories
2. **Descriptive Text** — Retail Products & Store Fixtures
3. **Procedure Text** — Store Standard Operating Procedures

Materi utama telah disusun dan direvisi menjadi master content yang memuat teori, tujuan pembelajaran, reading text, vocabulary preview, interactive glossary, multiple choice, interactive practice / drag & drop, kunci jawaban, feedback, scoring, progress, serta kebutuhan aset visual dan audio.

PRD ini berfungsi sebagai acuan utama untuk membangun struktur aplikasi, alur pengguna, hubungan antarhalaman, aturan data, aturan interaksi, serta acceptance criteria sebelum tahap UI/UX dan development dimulai.

---

# 3. Tujuan Produk

## 3.1 Tujuan Utama

Membangun aplikasi Android yang:

- membantu peserta didik mempelajari materi Bahasa Inggris berbasis konteks vokasional ritel;
- mendukung kegiatan belajar membaca secara mandiri;
- memberikan pengalaman belajar interaktif melalui audio, glossary, quiz, dan drag & drop;
- menyediakan feedback dan skor otomatis;
- menyimpan progress belajar secara lokal;
- tetap dapat digunakan tanpa koneksi internet;
- dapat digunakan sebagai media dalam penelitian R&D.

## 3.2 Tujuan Pembelajaran Produk

Aplikasi harus membantu peserta didik untuk:

1. mengidentifikasi tujuan komunikatif teks;
2. mengenali generic structure;
3. mengenali language features;
4. menemukan ide pokok dan informasi rinci;
5. memahami vocabulary ritel;
6. memahami konteks pekerjaan ritel;
7. mengerjakan latihan pemahaman;
8. melihat hasil evaluasi secara langsung;
9. mengulang materi secara mandiri;
10. melanjutkan progress belajar dari penggunaan sebelumnya.

---

# 4. Non-Goals / Di Luar Scope Saat Ini

Fitur berikut **tidak termasuk scope utama versi 1.0**, kecuali disepakati sebagai perubahan scope:

- login / register;
- akun siswa;
- akun guru;
- multi-user;
- sinkronisasi progress antarperangkat;
- database online;
- web admin;
- CMS materi;
- upload materi melalui dashboard online;
- push notification;
- chat;
- forum diskusi;
- ranking kelas;
- leaderboard online;
- integrasi Google Classroom;
- integrasi LMS;
- integrasi Firebase Auth;
- integrasi Supabase Auth;
- pembayaran;
- subscription;
- ads;
- dashboard analytics online;
- server API;
- cloud backup;
- pre-test/post-test formal berbasis server;
- portal guru;
- export nilai satu kelas secara online.

---

# 5. Keputusan Produk Utama

## 5.1 Arsitektur

Aplikasi dibuat sebagai aplikasi Android offline-first.

**Rekomendasi implementasi:**
- Flutter
- SQLite / local database
- local asset storage
- local audio files
- local images
- local JSON / structured content bila diperlukan

## 5.2 Mode Offline

Semua materi inti harus dapat digunakan tanpa internet setelah aplikasi terpasang.

Yang harus tersedia offline:

- teks materi;
- learning objectives;
- vocabulary preview;
- glossary;
- gambar;
- audio;
- multiple choice;
- drag & drop;
- feedback;
- score;
- progress;
- petunjuk penggunaan;
- capaian pembelajaran;
- profil pengembang setelah datanya diisi.

## 5.3 Akses Modul

Default PRD versi 1.0:

- seluruh Modul 1–3 dapat dibuka langsung;
- tidak ada hard-lock antar modul;
- aplikasi tetap menyimpan status tiap modul;
- secara visual, modul dapat memiliki status:
  - Not Started
  - In Progress
  - Completed

Alasan: konsep utama adalah pembelajaran membaca mandiri.

Jika penelitian kemudian membutuhkan urutan wajib, sistem dapat dikembangkan agar modul berikutnya terkunci sampai modul sebelumnya selesai.

---

# 6. Target Pengguna

## 6.1 Primary User

Peserta didik:
- Kelas X SMK;
- Fase E;
- mempelajari Bahasa Inggris;
- membutuhkan konteks pembelajaran retail;
- menggunakan smartphone Android;
- dapat belajar sendiri tanpa guru terus-menerus.

## 6.2 Secondary User

Peneliti / pengembang media:
- menggunakan aplikasi sebagai media penelitian;
- memvalidasi apakah materi, visual, audio, dan interaksi berjalan sesuai desain;
- menguji aplikasi pada peserta didik.

---

# 7. Persona Singkat

## Persona A — Siswa

**Tujuan:**
- membaca materi;
- mendengarkan pronunciation;
- mengetahui arti vocabulary;
- mengerjakan quiz;
- mengetahui nilai;
- mengulang materi bila belum paham.

**Kebutuhan:**
- navigasi sederhana;
- tampilan tidak terlalu padat;
- teks mudah dibaca;
- tombol audio jelas;
- feedback langsung;
- progress mudah dipahami.

## Persona B — Peneliti

**Tujuan:**
- memastikan materi sesuai desain;
- memastikan aktivitas evaluasi berjalan;
- memastikan aplikasi dapat dipakai offline;
- memastikan tidak ada ketergantungan internet;
- mendapatkan produk APK yang stabil.

---

# 8. Struktur Informasi Aplikasi

## 8.1 Level 0 — Splash / Launch

1. Splash Screen
2. Initial Data Load
3. Home / Dashboard

## 8.2 Level 1 — Dashboard

Menu utama:

1. Modul
2. Petunjuk
3. Capaian Pembelajaran
4. Profil Pengembang

Elemen tambahan yang direkomendasikan:

- Continue Learning
- Progress Summary
- Last Opened Module

## 8.3 Level 2 — Modul

- Modul 1 — Narrative Text
- Modul 2 — Descriptive Text
- Modul 3 — Procedure Text

## 8.4 Level 3 — Isi Modul

Setiap modul menggunakan pola:

1. Module Overview
2. Learning Objectives
3. Theory
4. Vocabulary Preview
5. Reading / Main Content
6. Audio
7. Interactive Glossary
8. Interactive Practice
9. Multiple Choice Quiz
10. Result
11. Review
12. Completion

---

# 9. Sitemap Aplikasi

```text
Splash Screen
└── Dashboard / Home
    ├── Continue Learning
    ├── Progress Summary
    ├── Modul
    │   ├── Modul 1 — Narrative Text
    │   │   ├── Overview
    │   │   ├── Learning Objectives
    │   │   ├── Definition & Purpose
    │   │   ├── Generic Structure
    │   │   ├── Key Language Features
    │   │   ├── Vocabulary Preview
    │   │   ├── Reading: The Story of IKEA
    │   │   ├── Interactive Glossary
    │   │   ├── Audio Reading
    │   │   ├── Multiple Choice
    │   │   ├── Drag & Drop / Matching
    │   │   ├── Result & Feedback
    │   │   └── Module Completion
    │   │
    │   ├── Modul 2 — Descriptive Text
    │   │   ├── Overview
    │   │   ├── Learning Objectives
    │   │   ├── Definition & Purpose
    │   │   ├── Generic Structure
    │   │   ├── Key Language Features
    │   │   ├── Vocabulary Preview
    │   │   ├── Submaterial 1 — POS Terminal
    │   │   ├── Submaterial 2 — Gondola Shelving
    │   │   ├── Submaterial 3 — Biker Jacket
    │   │   ├── Interactive Glossary
    │   │   ├── Audio Reading
    │   │   ├── Multiple Choice
    │   │   ├── Drag & Drop / Matching
    │   │   ├── Result & Feedback
    │   │   └── Module Completion
    │   │
    │   └── Modul 3 — Procedure Text
    │       ├── Overview
    │       ├── Learning Objectives
    │       ├── Definition & Purpose
    │       ├── Generic Structure
    │       ├── Key Language Features
    │       ├── Vocabulary Preview
    │       ├── Procedure Reading
    │       ├── Interactive Glossary
    │       ├── Audio Reading
    │       ├── Multiple Choice
    │       ├── Sequencing / Drag & Drop
    │       ├── Result & Feedback
    │       └── Module Completion
    │
    ├── Petunjuk Penggunaan
    ├── Capaian Pembelajaran
    └── Profil Pengembang
```

---

# 10. Alur Utama Pengguna

## 10.1 First Launch

```text
User membuka APK
→ Splash Screen
→ Load data lokal
→ Jika belum ada database:
   → Seed master content
   → Seed quiz
   → Seed glossary
   → Seed progress default
→ Dashboard
```

## 10.2 Returning User

```text
User membuka APK
→ Splash Screen
→ Load database lokal
→ Ambil last opened module
→ Ambil progress
→ Dashboard
→ Tampilkan Continue Learning jika ada progress
```

## 10.3 Alur Belajar

```text
Dashboard
→ Modul
→ Pilih Modul
→ Overview
→ Learning Objectives
→ Theory
→ Vocabulary Preview
→ Reading
→ Audio / Glossary
→ Interactive Practice
→ Multiple Choice
→ Result
→ Review atau Complete
→ Progress disimpan
```

---

# 11. Detailed Screen Requirements

# 11.1 Splash Screen

## Tujuan

Memberi identitas awal aplikasi dan waktu untuk memuat data lokal.

## Elemen

- logo aplikasi;
- nama aplikasi;
- subtitle EVP Retail;
- loading indicator opsional.

## Behavior

- tampil ±1–3 detik atau sampai data siap;
- tidak boleh terlalu lama;
- jika asset belum final, developer dapat menggunakan placeholder branding.

## Acceptance Criteria

- aplikasi tidak stuck;
- tidak crash;
- berpindah ke Dashboard otomatis;
- data lokal selesai diinisialisasi.

---

# 11.2 Dashboard / Home

## Tujuan

Menjadi pusat navigasi utama.

## Elemen Wajib

- greeting / title;
- tombol Modul;
- tombol Petunjuk;
- tombol Capaian Pembelajaran;
- tombol Profil Pengembang.

## Elemen Direkomendasikan

- Continue Learning;
- Overall Progress;
- jumlah modul selesai;
- Last Score / Best Score;
- last opened module.

## State

### State A — New User

- Progress: 0/3
- Continue Learning tidak ditampilkan atau diarahkan ke Modul 1

### State B — Existing User

- Progress sesuai database
- Continue Learning mengarah ke halaman terakhir

## Acceptance Criteria

- semua menu dapat dibuka;
- tidak ada menu mati;
- progress sinkron dengan local storage;
- UI tetap usable pada layar Android umum.

---

# 11.3 Halaman Daftar Modul

## Tujuan

Menampilkan seluruh modul.

## Card Modul

Setiap card berisi:

- nomor modul;
- nama modul;
- tipe teks;
- deskripsi singkat;
- progress percentage;
- status;
- tombol Open / Continue / Review.

## Modul

### Modul 1
Narrative Text — Inspirational Business & Brand Stories

### Modul 2
Descriptive Text — Retail Products & Store Fixtures

### Modul 3
Procedure Text — Store Standard Operating Procedures

## Status

- Not Started
- In Progress
- Completed

## Acceptance Criteria

- semua modul dapat dibuka;
- status tampil benar;
- progress berubah setelah aktivitas selesai.

---

# 11.4 Module Overview

Setiap modul harus memiliki halaman overview.

## Isi

- Module Number
- Module Title
- Short Introduction
- Learning Objectives
- estimasi activity sederhana, opsional
- Start Learning button

## Behavior

Saat user menekan Start Learning:

- module status berubah dari Not Started ke In Progress;
- `lastOpenedModule` disimpan;
- user diarahkan ke theory.

---

# 12. Struktur Modul 1

# 12.1 Modul 1 — Narrative Text

**Title:** Inspirational Business & Brand Stories  
**Reading:** The Story of IKEA: Innovation in Furniture Retail

## Subsections

1. Introduction
2. Learning Objectives
3. Definition & Purpose
4. Generic Structure
5. Key Language Features
6. Vocabulary Preview
7. Reading
8. Historical Note
9. Interactive Glossary
10. Audio
11. Multiple Choice
12. Drag & Drop
13. Result
14. Completion

---

# 12.2 Theory Screen — Narrative

Harus memuat:

- definition;
- purpose;
- orientation;
- complication;
- resolution;
- re-orientation;
- simple past tense;
- action verbs;
- time connectives;
- descriptive / evaluative words.

## Generic Structure UI

Direkomendasikan menggunakan card:

- Orientation
- Complication
- Resolution
- Re-orientation

---

# 12.3 Vocabulary Preview — Narrative

Vocabulary preview:

- Founder
- Venture
- Crisis
- Breakthrough
- Retailer

Setiap item dapat memiliki:

- word;
- part of speech;
- Indonesian meaning;
- audio pronunciation button.

---

# 12.4 Reading Screen — IKEA

Reading dibagi menjadi:

- Orientation
- Complication
- Resolution
- Re-orientation

## Target Interactive Glossary

- Boycott
- Supplier
- Affordable
- Delivery
- Flat-pack
- Assemble
- Retailer

## Behavior

Saat kata target ditekan:

```text
Tap highlighted word
→ Open glossary bottom sheet / modal
→ Show:
   word
   part of speech
   Indonesian meaning
   pronunciation
→ User dapat close
```

## Highlight

- hanya target vocabulary yang interaktif;
- highlight tidak boleh membuat teks sulit dibaca;
- tidak semua kata sulit menjadi interactive.

---

# 12.5 Audio Reading — IKEA

## Function

- play;
- pause;
- restart;
- progress indicator.

## Optional

- jump ±10 seconds tidak wajib;
- speed control tidak wajib pada scope v1.0.

## Offline

Audio disimpan di asset lokal.

---

# 12.6 Narrative Multiple Choice

Total: 10 soal.

## Scoring

- 7 poin per soal;
- maksimum 70.

## Required Behavior

- user memilih satu jawaban;
- pilihan aktif terlihat;
- tombol Next;
- user dapat melihat progress soal;
- setelah submit final, jawaban tidak hilang sebelum result tersimpan.

---

# 12.7 Narrative Drag & Drop

Aktivitas:

### A. Structure Match
Match:
- Orientation
- Complication
- Resolution
- Re-orientation

### B. Vocabulary Match
Match:
- Boycott
- Supplier
- Flat-pack
- Assemble
- Delivery

### C. Event Sequencing
Urutkan:
- IKEA founded
- furniture business expands
- supplier/transport challenge
- flat-pack/self-assembly
- global growth

---

# 13. Struktur Modul 2

# 13.1 Modul 2 — Descriptive Text

**Title:** Retail Products & Store Fixtures

Submaterial:

1. Modern Touchscreen POS Terminal
2. Heavy-Duty Supermarket Gondola Shelving
3. Urban Rider — Vintage Leather Biker Jacket

---

# 13.2 Theory Screen — Descriptive

Isi:

- definition;
- purpose;
- Identification;
- Description;
- Simple Present;
- Adjectives;
- Noun Phrases;
- Specific Details.

---

# 13.3 Vocabulary Preview — Descriptive

- Merchandise
- Durable
- Adjustable
- Display
- Sleek

Masing-masing:

- part of speech;
- meaning;
- pronunciation.

---

# 13.4 Submaterial 1 — POS Terminal

## Display

- Title
- Product category / label
- Illustration
- Identification
- Description
- Audio
- Glossary

## Glossary

- Casing
- Dual-screen display
- Integrated
- Sturdy
- Finish

---

# 13.5 Submaterial 2 — Gondola Shelving

## Glossary

- Gondola shelving
- Adjustable
- Durable
- Open-front
- Visibility

## Visual

Menampilkan visual rak gondola yang sesuai dengan deskripsi.

---

# 13.6 Submaterial 3 — Biker Jacket

## Glossary

- Genuine
- Asymmetrical
- Adjustable
- Eye-catching
- Centerpiece

## Visual

Biker jacket pada retail window display.

---

# 13.7 Descriptive Multiple Choice

Total 10 soal.

Scoring:
- 10 × 7 = 70.

---

# 13.8 Descriptive Interactive Practice

### Activity A — Product Match

Feature → Object

### Activity B — Vocabulary Match

Vocabulary → Meaning

### Activity C — Structure Sort

Sentence → Identification / Description

### Activity D — Image Feature Match

Visual hotspot → descriptive phrase

Catatan:

Untuk scoring v1.0, hanya tiga aktivitas utama yang masuk skor akhir. Activity D dapat:
- dijadikan bagian salah satu aktivitas;
- atau dijadikan latihan tanpa skor;
- keputusan final dapat diterapkan saat UI/UX.

---

# 14. Struktur Modul 3

# 14.1 Modul 3 — Procedure Text

**Title:** Store Standard Operating Procedures (SOP)

Reading:
**How to Process Customer Checkout Using a POS Terminal**

---

# 14.2 Theory Screen — Procedure

Isi:

- definition;
- purpose;
- Goal / Aim;
- Materials / Equipment;
- Steps / Methods;
- Imperative Verbs;
- Sequence Adverbs;
- Conditional Instruction.

---

# 14.3 Vocabulary Preview — Procedure

- Scan
- Receipt
- Checkout
- Verify
- Cash drawer

---

# 14.4 Procedure Reading

## Sections

### Goal / Aim

### Materials / Equipment

1. POS terminal
2. Cash drawer
3. Barcode scanner
4. Thermal receipt paper
5. Customer merchandise
6. payment device / QR display if used

### Steps

1. Greet
2. Scan
3. Verify
4. Ask payment method
5. Process payment
6. Print / provide receipt and hand over items

---

# 14.5 Interactive Glossary — Procedure

- Greet
- Scan
- Verify
- Payment method
- Enter
- Change
- Receipt
- Hand over

---

# 14.6 Procedure Multiple Choice

Total: 10 soal.

---

# 14.7 Procedure Drag & Drop

### Activity A — Sequence Checkout

Greet → Scan → Verify → Ask payment → Process payment → Receipt/hand over

### Activity B — Equipment Match

- Scanner → Scan
- POS → Transaction
- Receipt printer → Receipt
- Cash drawer → Cash

### Activity C — Connector Match

- First
- Next
- Then
- After that
- Finally

---

# 15. Interactive Glossary System

## 15.1 Tujuan

Membantu user memahami vocabulary tanpa meninggalkan reading.

## 15.2 Trigger

User menekan highlighted word.

## 15.3 Popup Content

- word;
- part of speech;
- meaning in Indonesian;
- pronunciation button.

## 15.4 Behavior

- popup tidak mengganti halaman;
- audio dapat dimainkan dari popup;
- user dapat close;
- satu popup pada satu waktu;
- jika audio sedang berjalan lalu user membuka audio lain, audio lama berhenti.

## 15.5 Data Structure

Contoh:

```json
{
  "id": "m1_glossary_001",
  "module_id": "module_1",
  "word": "assemble",
  "part_of_speech": "verb",
  "meaning_id": "Merakit / menyusun bagian produk",
  "audio_asset": "audio/vocab/assemble.mp3"
}
```

---

# 16. Audio System

## 16.1 Jenis Audio

### Reading Audio

5 track utama:

1. IKEA Story
2. POS Terminal
3. Gondola Shelving
4. Biker Jacket
5. Customer Checkout Procedure

### Vocabulary Audio

Pronunciation seluruh target vocabulary.

### UI Sound

Opsional:
- correct;
- incorrect;
- complete.

---

# 16.2 Audio Behavior

- satu audio aktif pada satu waktu;
- play/pause;
- restart;
- progress;
- tidak autoplay saat membuka halaman;
- tidak overlap;
- audio berhenti jika user meninggalkan halaman bila diperlukan;
- state audio tidak perlu disimpan setelah aplikasi ditutup.

---

# 16.3 Audio Pending

Pilihan accent:
- American English
- British English

Keputusan dapat difinalkan kemudian dan tidak menghambat struktur aplikasi.

---

# 17. Multiple Choice System

## 17.1 General Rule

Setiap modul:
- 10 soal;
- 4 pilihan;
- satu jawaban benar.

## 17.2 State

- unanswered;
- answered;
- current;
- completed.

## 17.3 Flow

```text
Quiz Intro
→ Question 1
→ ...
→ Question 10
→ Submit
→ Calculate
→ Save
→ Result
```

## 17.4 Validation

Jika user belum memilih jawaban:

- tombol Next tetap dapat dinonaktifkan;
atau
- tampil message "Pilih salah satu jawaban."

Rekomendasi:
- tombol Next disabled sampai jawaban dipilih.

## 17.5 Navigation

Untuk mengurangi perubahan jawaban tidak sengaja:
- user boleh Previous sebelum Final Submit;
- setelah Final Submit, semua jawaban dikunci untuk attempt tersebut.

---

# 18. Drag & Drop / Interactive Practice System

## 18.1 General

Setiap modul memiliki 3 aktivitas scored utama.

## 18.2 Maksimum

Total 30 poin.

## 18.3 Default Scoring

- Activity 1 = 10
- Activity 2 = 10
- Activity 3 = 10

## 18.4 Partial Score

Default:
- per item dapat memperoleh partial score;
- skor aktivitas = `(correctItems / totalItems) × 10`;
- hasil dibulatkan sesuai implementasi.

Contoh:

5 item
4 benar
→ 4/5 × 10 = 8 poin

## 18.5 Behavior

- item dapat dipindahkan sebelum check;
- setelah Check Answer:
  - correct item diberi indicator benar;
  - incorrect diberi indicator salah;
- user dapat Retry.

---

# 19. Score System

## 19.1 Maximum

Per modul = 100.

### Multiple Choice
70

### Interactive Practice
30

---

# 19.2 Formula

```text
finalScore = multipleChoiceScore + interactivePracticeScore
```

---

# 19.3 Status

Default:

```text
score >= 75 → Completed / Tuntas
score < 75 → Needs Review
```

Nilai 75 bersifat sementara sampai KKTP/KKM dikonfirmasi.

---

# 19.4 Score Stored

Aplikasi menyimpan:

- latest score;
- best score;
- last attempt date;
- number of attempts;
- completion status.

---

# 20. Result Screen

## Elemen

- Final Score
- MC Score
- Practice Score
- Correct count
- Incorrect count
- Status
- Feedback
- Review Material
- Retry Quiz
- Back to Modules

## Jika Tuntas

Feedback:
- positive;
- concise;
- user dapat tetap mengulang.

## Jika Belum Tuntas

Feedback:
- Needs Review;
- arahkan ke Review Material.

---

# 21. Progress System

## 21.1 Status

### Not Started
Belum pernah membuka module.

### In Progress
Sudah membuka tetapi belum complete.

### Completed
Selesai evaluasi dan memenuhi threshold.

---

# 21.2 Progress Percentage

Rekomendasi formula:

- Overview/Theory = 20%
- Reading = 30%
- Practice = 20%
- Quiz = 30%

Total = 100%.

Atau dapat dibuat milestone-based.

## 21.3 Simpler Recommended Implementation

Gunakan checkpoint:

1. module opened = 10%
2. theory finished = 25%
3. reading finished = 50%
4. practice finished = 70%
5. quiz submitted = 100%

Completion status tetap berdasarkan score threshold.

---

# 21.4 Continue Learning

Aplikasi menyimpan:

- last module;
- last section.

Saat Dashboard:

`Continue Learning` → membuka section terakhir.

---

# 22. Local Database Requirements

## 22.1 Database Type

SQLite.

## 22.2 Main Tables

### modules

```text
id
code
title
type
description
order_index
```

### lessons

```text
id
module_id
title
section_type
content
order_index
```

### glossary

```text
id
module_id
lesson_id
word
part_of_speech
meaning
audio_path
```

### questions

```text
id
module_id
question_text
option_a
option_b
option_c
option_d
correct_option
feedback
order_index
```

### practice_activities

```text
id
module_id
type
title
instruction
max_score
```

### practice_items

```text
id
activity_id
source
target
correct_mapping
order_index
```

### module_progress

```text
id
module_id
status
progress_percent
last_section
last_opened_at
completed_at
```

### quiz_attempts

```text
id
module_id
score_mc
score_practice
score_total
correct_count
incorrect_count
attempt_number
created_at
```

### user_settings

```text
id
audio_enabled
ui_sound_enabled
last_module_id
last_section
```

---

# 23. Content Storage Strategy

## 23.1 Static Content

Materi utama dapat disimpan sebagai:

- local JSON;
- Dart constants;
- pre-seeded SQLite.

Rekomendasi:
- content structured in JSON;
- progress/attempts in SQLite.

## 23.2 Assets

Folder:

```text
assets/
├── images/
│   ├── module1/
│   ├── module2/
│   ├── module3/
│   └── ui/
├── audio/
│   ├── reading/
│   ├── vocabulary/
│   └── ui/
└── data/
    ├── modules.json
    ├── questions.json
    └── glossary.json
```

---

# 24. Navigation Requirements

## 24.1 Primary Navigation

Dashboard sebagai root.

## 24.2 Back Behavior

- Android back harus konsisten;
- dari subhalaman kembali ke parent;
- tidak langsung menutup aplikasi kecuali dari root.

## 24.3 Deep Navigation

Tidak ada deep linking online.

---

# 25. State Management

Aplikasi minimal menangani state:

- current module;
- current section;
- audio playback;
- quiz answers;
- quiz result;
- drag/drop state;
- progress;
- loading;
- error.

State quiz yang belum disubmit dapat:
- disimpan sementara;
atau
- direset jika user keluar.

Rekomendasi:
- simpan draft attempt agar tidak hilang jika aplikasi tertutup tiba-tiba.

---

# 26. Error Handling

## 26.1 Audio Missing

Jika file audio gagal:

- jangan crash;
- disable button;
- tampilkan message ringan:
  `Audio belum tersedia.`

## 26.2 Image Missing

- gunakan placeholder;
- jangan crash.

## 26.3 Local DB Error

- tampilkan retry;
- log error lokal;
- jika seed gagal, lakukan fallback data initialization.

## 26.4 Corrupt Progress

- reset progress table saja;
- jangan menghapus seluruh materi.

---

# 27. Empty States

## Dashboard No Progress

Tampilkan:
- "Belum ada modul yang dimulai."
- tombol "Mulai Belajar"

## No Score

Tampilkan:
- `Belum ada nilai.`

## No Profile Data

Sementara:
- placeholder / hidden field sampai data final diberikan.

---

# 28. Petunjuk Penggunaan

Halaman harus memuat:

1. memilih modul;
2. membaca learning objectives;
3. menggunakan vocabulary preview;
4. memainkan audio;
5. membuka glossary;
6. mengerjakan multiple choice;
7. mengerjakan drag & drop;
8. melihat score;
9. review;
10. melanjutkan progress.

---

# 29. Capaian Pembelajaran

Halaman menampilkan:

- konteks Fase E;
- fokus Membaca–Memirsa;
- tujuan pembelajaran umum media.

Tidak perlu terlalu panjang.

---

# 30. Profil Pengembang

Status sekarang:
pending data.

Struktur halaman disiapkan:

- foto;
- nama;
- NIM;
- program studi;
- fakultas;
- universitas;
- pembimbing;
- judul penelitian;
- tahun.

Jika data belum ada pada build awal:
- gunakan placeholder hanya di development;
- build customer review sebaiknya meminta data.

---

# 31. Asset Visual Requirements

## Modul 1

- founder / business start illustration;
- mail order / catalogue;
- supplier / warehouse;
- flat-pack;
- assembling furniture.

## Modul 2

### POS
- touchscreen POS;
- dual screen;
- receipt printer;
- casing;
- stand.

### Gondola
- supermarket gondola;
- aisle;
- shelf.

### Jacket
- black biker jacket;
- retail window display.

## Modul 3

- POS;
- barcode scanner;
- cash drawer;
- receipt;
- products;
- cash/card/QR payment;
- checkout flow.

---

# 32. UI/UX Principles

Tahap UI/UX berikutnya harus mengikuti:

- clean;
- modern;
- educational;
- tidak terlalu childish;
- cocok untuk kelas X SMK;
- readable;
- mobile-first;
- large touch target;
- hierarchy jelas;
- penggunaan card konsisten;
- progress jelas;
- status warna tidak hanya mengandalkan warna;
- audio button mudah ditemukan.

---

# 33. Accessibility Requirements

Minimal:

- font body mudah dibaca;
- contrast cukup;
- button minimal touch area ±44–48dp;
- icon diberi label bila ambigu;
- jangan hanya mengandalkan warna untuk correct/incorrect;
- correct menggunakan icon/check + text;
- incorrect menggunakan icon/cross + text;
- audio tidak autoplay;
- teks dapat di-scroll.

---

# 34. Responsive Requirements

Target:
- smartphone Android portrait sebagai fokus utama;
- landscape optional tetapi UI tidak boleh rusak;
- ukuran kecil tetap usable;
- tablet tidak menjadi target utama tetapi layout tidak boleh crash.

---

# 35. Performance Requirements

- cold start wajar;
- navigasi cepat;
- audio lokal tidak buffering internet;
- tidak ada loading panjang;
- gambar dioptimasi;
- audio dikompresi wajar;
- APK tidak membengkak tanpa alasan;
- database query ringan.

---

# 36. Privacy & Security

Karena tidak ada login dan server:

- tidak mengumpulkan data pribadi secara online;
- tidak meminta permission yang tidak perlu;
- tidak meminta lokasi;
- tidak meminta kontak;
- tidak meminta kamera kecuali fitur baru;
- progress tersimpan lokal;
- tidak ada tracking analytics eksternal pada scope default.

---

# 37. Permissions

Default:

- tidak memerlukan internet;
- tidak memerlukan location;
- tidak memerlukan contacts;
- tidak memerlukan camera;
- tidak memerlukan microphone.

Jika Android membutuhkan permission storage tertentu untuk export tambahan, fitur tersebut bukan requirement utama v1.0.

---

# 38. Acceptance Criteria Global

Aplikasi dianggap memenuhi PRD jika:

1. dapat di-install sebagai APK;
2. dapat dibuka tanpa crash;
3. dashboard tampil;
4. 3 modul dapat dibuka;
5. materi sesuai master content;
6. glossary dapat diklik;
7. audio bekerja;
8. multiple choice bekerja;
9. drag & drop bekerja;
10. score dihitung otomatis;
11. feedback tampil;
12. progress disimpan;
13. aplikasi tetap berfungsi setelah restart;
14. seluruh fungsi utama dapat digunakan offline;
15. navigation back benar;
16. tidak ada dead button;
17. tidak ada placeholder developer yang tertinggal pada final;
18. APK final lolos testing internal;
19. source code dapat dibuild ulang;
20. customer dapat melakukan review sebelum final.

---

# 39. Acceptance Criteria Modul 1

- theory lengkap;
- IKEA text terbagi per generic structure;
- 7 glossary target dapat dibuka;
- reading audio tersedia;
- 10 MC tersedia;
- 3 interactive practice tersedia;
- score dapat dihitung;
- progress tersimpan.

---

# 40. Acceptance Criteria Modul 2

- 3 submaterial tersedia;
- setiap submaterial memiliki gambar;
- glossary masing-masing berfungsi;
- audio reading tersedia;
- 10 MC tersedia;
- practice feature matching/sorting bekerja;
- score tersimpan.

---

# 41. Acceptance Criteria Modul 3

- procedure text lengkap;
- equipment list tampil;
- 6 step tampil;
- glossary berfungsi;
- audio reading tersedia;
- 10 MC tersedia;
- sequencing bekerja;
- score tersimpan.

---

# 42. Quiz Data Integrity

Setiap question wajib memiliki:

- unique ID;
- module;
- text;
- 4 options;
- correct answer;
- feedback;
- order.

Tidak boleh:
- dua jawaban benar;
- opsi kosong;
- question tanpa answer key.

---

# 43. Glossary Data Integrity

Setiap glossary wajib:

- unique;
- memiliki word;
- part of speech;
- meaning;
- asset path jika audio ada.

Duplicate word dapat menggunakan audio sama.

---

# 44. Offline Acceptance Test

Test wajib:

1. install APK;
2. buka aplikasi;
3. matikan internet;
4. buka Modul 1;
5. play audio;
6. buka glossary;
7. kerjakan quiz;
8. kerjakan drag/drop;
9. submit;
10. tutup aplikasi;
11. buka kembali;
12. verify progress masih ada.

Jika semua lolos:
Offline PASS.

---

# 45. Progress Acceptance Test

Scenario:

```text
Fresh Install
→ Module 1 = Not Started
→ Open Module 1
→ In Progress
→ Complete Reading
→ progress meningkat
→ Complete Quiz
→ score tersimpan
→ jika >= threshold
→ Completed
→ restart app
→ status tetap Completed
```

---

# 46. Retry Flow

```text
Result
→ Retry
→ New attempt
→ Previous best score tetap disimpan
→ latest score diperbarui
→ best score hanya berubah jika latest lebih tinggi
```

---

# 47. Review Flow

```text
Result < threshold
→ Needs Review
→ Review Material
→ kembali ke reading/theory
→ user dapat membuka quiz kembali
```

---

# 48. Data Reset

Untuk v1.0:

Reset progress bukan requirement utama dashboard.

Namun developer dapat menyiapkan hidden/dev reset selama testing.

Jika fitur user-facing reset ditambahkan:

- confirmation dialog wajib;
- hanya progress/score yang dihapus;
- materi tidak dihapus.

---

# 49. Customer Review Build

APK review harus:

- memiliki fitur utama;
- menggunakan materi final;
- boleh menggunakan sebagian placeholder aset yang sudah disepakati hanya jika asset belum final;
- jelas diberi versi build.

Contoh:
`v0.9.0-review`

---

# 50. Release Build

Final:
`v1.0.0`

Requirements:

- no debug banner;
- no placeholder;
- no broken links;
- no unused button;
- correct app icon;
- signed APK;
- source buildable.

---

# 51. Versioning

Recommended:

- `0.1.x` — project skeleton
- `0.2.x` — UI core
- `0.3.x` — module 1
- `0.4.x` — module 2
- `0.5.x` — module 3
- `0.6.x` — quiz
- `0.7.x` — practice
- `0.8.x` — offline/progress
- `0.9.x` — customer review
- `1.0.0` — final

---

# 52. Development Milestone Mapping

## Milestone 1 — App Structure

- routes;
- data models;
- local database;
- base shell.

## Milestone 2 — Core UI

- splash;
- dashboard;
- module list;
- generic lesson layout.

## Milestone 3 — Module Content

- Module 1;
- Module 2;
- Module 3.

## Milestone 4 — Interactivity

- glossary;
- audio;
- MC;
- drag & drop.

## Milestone 5 — Evaluation

- scoring;
- feedback;
- progress;
- retry.

## Milestone 6 — Offline

- local asset;
- persistence;
- restart test.

## Milestone 7 — QA

- internal testing;
- review APK;
- customer revisions.

## Milestone 8 — Final

- final testing;
- signed APK;
- source;
- documentation.

---

# 53. Pending Items yang Sengaja Ditunda

Item berikut **tidak menghalangi mulai UI/UX dan development**:

- nama final aplikasi;
- logo/icon final;
- data profil peneliti;
- foto peneliti;
- KKTP/KKM final;
- pilihan American/British accent;
- validasi ahli.

Semua dibuat configurable atau placeholder di development.

---

# 54. Open Questions Non-Blocking

1. Apakah nama aplikasi memiliki branding khusus?
2. American atau British accent?
3. Threshold final tetap 75 atau mengikuti sekolah?
4. Apakah best score ingin ditampilkan ke siswa?
5. Apakah modul berikutnya suatu saat perlu lock?
6. Apakah UI sound correct/incorrect dipakai?
7. Apakah profile page menampilkan dosen pembimbing?

Pertanyaan di atas dapat dijawab kemudian tanpa menghentikan tahap struktur aplikasi.

---

# 55. Assumption Register

## A1
Aplikasi digunakan oleh satu siswa pada satu perangkat.

## A2
Tidak ada authentication.

## A3
Tidak ada sync online.

## A4
Materi tidak berubah dari server.

## A5
Semua content core masuk APK.

## A6
Progress hanya lokal.

## A7
Customer memberikan data identitas sebelum final.

## A8
Audio dapat diganti tanpa mengubah architecture.

## A9
Nilai threshold configurable.

---

# 56. Scope Control

Permintaan berikut tergolong perubahan scope jika diminta setelah PRD disepakati:

- login/register;
- admin;
- server;
- cloud sync;
- penambahan modul besar;
- lebih banyak role;
- teacher dashboard;
- leaderboard;
- export central database;
- online class management;
- push notifications;
- AI tutor;
- speech recognition;
- recording user pronunciation;
- camera-based exercise;
- online exam proctoring.

Perubahan materi kecil dan revisi UI yang masih sesuai 3 modul tidak otomatis dianggap perubahan scope.

---

# 57. Definition of Done — Struktur & Alur

Tahap **Penyusunan Struktur & Alur Aplikasi** dianggap selesai jika:

- sitemap final tersedia;
- seluruh halaman sudah teridentifikasi;
- route flow jelas;
- alur belajar jelas;
- struktur Modul 1–3 jelas;
- quiz flow jelas;
- drag/drop flow jelas;
- scoring flow jelas;
- progress flow jelas;
- offline strategy jelas;
- local data strategy jelas;
- error/empty/loading states jelas;
- acceptance criteria tersedia;
- pending/non-blocking item ditandai;
- PRD ini disetujui sebagai baseline UI/UX.

---

# 58. Output Tahap Berikutnya

Setelah PRD ini difinalkan, tahap berikutnya adalah:

## Perancangan UI/UX

Dokumen/UI yang perlu dibuat:

1. design direction;
2. color system;
3. typography;
4. spacing;
5. component system;
6. splash design;
7. dashboard;
8. module list;
9. module overview;
10. theory page;
11. vocabulary preview;
12. reading page;
13. glossary popup;
14. audio player;
15. MC quiz;
16. drag/drop;
17. result screen;
18. progress UI;
19. petunjuk;
20. capaian pembelajaran;
21. profil pengembang;
22. loading / empty / error states.

---

# 59. Traceability Matrix

| Requirement | Modul/Fitur | Status PRD |
|---|---|---|
| APK Android | Global | Defined |
| Dashboard | Global | Defined |
| Modul | Global | Defined |
| Petunjuk | Global | Defined |
| Capaian Pembelajaran | Global | Defined |
| Profil Pengembang | Global | Defined |
| Narrative Text | Modul 1 | Defined |
| Descriptive Text | Modul 2 | Defined |
| Procedure Text | Modul 3 | Defined |
| Reading Audio | 3 Modul | Defined |
| Vocabulary Pronunciation | 3 Modul | Defined |
| Pop-up Glossary | 3 Modul | Defined |
| Multiple Choice | 3 Modul | Defined |
| Drag & Drop | 3 Modul | Defined |
| Score | Global | Defined |
| Feedback | Global | Defined |
| Progress | Global | Defined |
| Offline | Global | Defined |
| SQLite | Global | Defined |
| Login | Out of Scope | Excluded |
| Backend | Out of Scope | Excluded |
| Web Admin | Out of Scope | Excluded |

---

# 60. Final Product Flow

```text
INSTALL APK
    ↓
SPLASH
    ↓
DASHBOARD
    ↓
PILIH MODUL
    ↓
OVERVIEW
    ↓
LEARNING OBJECTIVES
    ↓
THEORY
    ↓
VOCABULARY PREVIEW
    ↓
READING
    ├── AUDIO
    └── INTERACTIVE GLOSSARY
    ↓
INTERACTIVE PRACTICE
    ↓
MULTIPLE CHOICE
    ↓
CALCULATE SCORE
    ↓
RESULT
    ├── TUNTAS → COMPLETE
    └── BELUM → REVIEW → RETRY
    ↓
SAVE LOCAL PROGRESS
    ↓
BACK TO DASHBOARD
```

---

# 61. Final PRD Status

**Analisis Kebutuhan:** SELESAI  
**Review & Finalisasi Materi:** SELESAI  
**Penyusunan Struktur & Alur Aplikasi:** TERDEFINISI DALAM PRD INI  
**Perancangan UI/UX:** TAHAP BERIKUTNYA  
**Development:** BELUM DIMULAI  

---

# 62. Catatan Penutup

PRD versi 1.0 ini menjadi baseline struktur dan alur aplikasi. Perubahan kecil pada wording, aset, profil, nama aplikasi, KKTP/KKM, atau accent audio dapat dilakukan kemudian tanpa mengubah arsitektur utama.

Perubahan yang memengaruhi authentication, backend, role, server, jumlah modul secara signifikan, atau fitur online harus diperlakukan sebagai perubahan scope.

Dokumen ini harus dibaca bersama master content materi agar implementasi UI dan fitur tidak menyimpang dari isi pembelajaran yang sudah direvisi.
