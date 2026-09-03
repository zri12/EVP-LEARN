import { createContext, useContext, useEffect, useMemo, useRef, useState } from "react";
import { createBrowserRouter, RouterProvider, useNavigate, useLocation } from "react-router";
import {
  BookOpen, ChevronDown, ChevronLeft, ChevronRight, ChevronUp, CircleHelp, ClipboardCheck,
  Globe, Headphones, Home, Info, Layers3, Play, Pause,
  Target, UserRound, Volume2, X, Check, AlertTriangle,
  GripVertical, ArrowRight, CircleDot, Store, ScanLine, Trophy,
  BarChart2,
} from "lucide-react";
import ReadingIllustration from "./illustrations";
import { MODULES, PASSING_THRESHOLD, readingGlossaryFor, type Reading, type Word } from "./data";
import logo from "./imports/evp-icon.png";
import module1Art from "./imports/module-art/module-1-narrative.png";
import module2Art from "./imports/module-art/module-2-descriptive.png";
import module3Art from "./imports/module-art/module-3-procedure.png";
import narrativeLessonArt from "./imports/lesson-art/narrative-lesson.png";
import descriptiveLessonArt from "./imports/lesson-art/descriptive-lesson.png";
import procedureLessonArt from "./imports/lesson-art/procedure-lesson.png";

// ─── UI Types ─────────────────────────────────────────────────────────────────
type Lang = "id" | "en";
type ModuleUI = { id: number; title: string; subtitle: string; accent: string; tint: string; icon: typeof BookOpen; reading: string; art: string };

// ─── Scoring / Persistence Types ──────────────────────────────────────────────
type ActivityResult = { score: number; correct: number; total: number; completed: boolean };
type PretestData = { score: number; correct: number; incorrect: number };
type PosttestData = { raw: number; weighted: number; correct: number; incorrect: number };
type ModuleAttempt = {
  id: string; timestamp: string;
  pretestScore: number; practiceScore: number;
  posttestRaw: number; posttestWeighted: number;
  finalScore: number; learningGain: number; passed: boolean;
};
type ModState = {
  pct: number; section: string; lastRoute: string;
  pretestResult?: PretestData;
  baselinePretest?: PretestData; // Preserves first attempt
  practiceActivities: ActivityResult[];
  practiceScore: number;
  posttestResult?: PosttestData;
  finalScore?: number; passed?: boolean;
  attempts: ModuleAttempt[];
  latestScore?: number; bestScore?: number;
};
type GState = { version: 2; lastModule?: number; lastRoute?: string; mods: { [key: string]: ModState } };
type GCtxType = {
  gs: GState;
  updateModPct: (id: number, pct: number, section: string, route: string) => void;
  savePretestResult: (id: number, r: PretestData) => void;
  savePracticeActivity: (id: number, idx: number, r: ActivityResult) => void;
  finalizePosttest: (id: number, r: PosttestData) => void;
  retryModule: (id: number) => void;
};

// ─── Audio Manifest (only real existing files) ────────────────────────────────
const AUDIO_MANIFEST = {
  reading: new Set<string>([
    "/audio/reading/m1-1.wav",
    "/audio/reading/m2-1.wav", "/audio/reading/m2-2.wav", "/audio/reading/m2-3.wav",
    "/audio/reading/m3-1.wav",
  ]),
  vocabulary: new Set<string>([
    "/audio/vocabulary/m1-1.wav", "/audio/vocabulary/m1-2.wav", "/audio/vocabulary/m1-3.wav",
    "/audio/vocabulary/m1-4.wav", "/audio/vocabulary/m1-5.wav",
    "/audio/vocabulary/m2-1.wav", "/audio/vocabulary/m2-2.wav", "/audio/vocabulary/m2-3.wav",
    "/audio/vocabulary/m2-4.wav", "/audio/vocabulary/m2-5.wav",
    "/audio/vocabulary/m3-1.wav", "/audio/vocabulary/m3-2.wav", "/audio/vocabulary/m3-3.wav",
    "/audio/vocabulary/m3-4.wav", "/audio/vocabulary/m3-5.wav",
  ]),
  glossary: new Set<string>([
    "/audio/glossary/adjustable.wav", "/audio/glossary/affordable.wav",
    "/audio/glossary/assemble.wav", "/audio/glossary/asymmetrical.wav",
    "/audio/glossary/attach.wav", "/audio/glossary/boycott.wav",
    "/audio/glossary/cash-drawer.wav", "/audio/glossary/casing.wav",
    "/audio/glossary/centerpiece.wav", "/audio/glossary/checkout.wav",
    "/audio/glossary/crisis.wav", "/audio/glossary/delivery.wav",
    "/audio/glossary/display.wav", "/audio/glossary/dual-screen-display.wav",
    "/audio/glossary/durable.wav", "/audio/glossary/eye-catching.wav",
    "/audio/glossary/finish.wav", "/audio/glossary/flat-packing.wav",
    "/audio/glossary/genuine.wav", "/audio/glossary/gondola-shelving.wav",
    "/audio/glossary/greet.wav", "/audio/glossary/innovation.wav",
    "/audio/glossary/insert.wav", "/audio/glossary/integrated.wav",
    "/audio/glossary/merchandise.wav", "/audio/glossary/open-front.wav",
    "/audio/glossary/payment-method.wav", "/audio/glossary/receipt.wav",
    "/audio/glossary/retailer.wav", "/audio/glossary/scan.wav",
    "/audio/glossary/sleek.wav", "/audio/glossary/sturdy.wav",
    "/audio/glossary/supplier.wav", "/audio/glossary/suppliers.wav",
    "/audio/glossary/verify.wav", "/audio/glossary/visibility.wav",
    // Missing (no audio file): enter.wav, change.wav, hand-over.wav
  ]),
};

function hasAudio(type: keyof typeof AUDIO_MANIFEST, path: string): boolean {
  return AUDIO_MANIFEST[type].has(path);
}

// ─── Score Calculator ─────────────────────────────────────────────────────────
function calculateQuizScore(
  questions: { answer: number }[],
  answers: (number | undefined)[]
): { answered: number; total: number; correct: number; incorrect: number; percentage: number } {
  const total = questions.length;
  let correct = 0;
  let answered = 0;
  for (let i = 0; i < total; i++) {
    const a = answers[i];
    if (typeof a === "number" && Number.isInteger(a)) {
      answered++;
      if (a === questions[i].answer) correct++;
    }
  }
  return {
    answered,
    total,
    correct,
    incorrect: answered - correct,
    percentage: total > 0 ? Math.round((correct / total) * 100) : 0,
  };
}

// ─── Translations ─────────────────────────────────────────────────────────────
const T = {
  id: {
    navHome: "Beranda", navModules: "Modul", navProgress: "Progres", navProfile: "Profil",
    readyToLearn: "Siap belajar?", startJourney: "Mulai perjalanan belajar Bahasa Inggrismu.",
    exploreModules: "Jelajahi Modul", continueLearning: "Lanjutkan Belajar",
    learningProgress: "Progres Belajar", yourModules: "Modul Kamu",
    quickAccess: "Akses Cepat", seeAll: "Lihat Semua",
    startModule: "Mulai Modul", continueModule: "Lanjutkan Modul", reviewModule: "Pelajari Kembali Modul",
    learningObjectives: "Tujuan Pembelajaran",
    startPretest: "Mulai Pre-test", diagnosticPretest: "Pre-test Diagnostik",
    pretestDesc: "Mari lihat kemampuan awalmu.",
    pretestNote: "Nilai Pre-test tidak memengaruhi nilai akhir modul.",
    startPosttest: "Mulai Post-test",
    posttestDesc: "Hampir selesai! Tunjukkan apa yang sudah kamu pelajari.",
    previous: "Sebelumnya", next: "Berikutnya",
    reviewAndSubmit: "Tinjau & Kirim", submitAnswers: "Kirim Jawaban",
    reviewAnswers: "Tinjau Kembali", submitConfirmTitle: "Kirim jawaban?",
    submitConfirmDesc: "Pastikan semua soal sudah dijawab.",
    reviewMaterial: "Pelajari Kembali Materi", tryAgain: "Coba Lagi",
    backToModules: "Kembali ke Beranda",
    greatJob: "Bagus!", thatCorrect: "Jawabanmu benar.",
    notQuiteYet: "Belum tepat", reviewSentence: "Coba pelajari kembali materinya.",
    partialCredit: "Sebagian benar!",
    continueBtn: "Lanjut",
    yourProgress: "Progres Belajarmu", noProgressYet: "Perjalanan belajarmu dimulai di sini.",
    startLearning: "Mulai Belajar",
    howToUse: "Petunjuk Penggunaan", learningOutcomes: "Capaian Pembelajaran", profileLabel: "Profil",
    improvement: "Peningkatan", pretestLabel: "Pre-test", posttestRaw: "Post-test",
    posttestWeighted: "Post-test Berbobot", practice: "Latihan Interaktif",
    finalScore: "Nilai Akhir", latestScore: "Nilai Terbaru", bestScore: "Nilai Terbaik",
    tuntas: "Tuntas", perluReview: "Perlu Review", tetapSemangat: "Tetap Semangat!",
    excellentProgress: "Progres yang luar biasa!", completedModule: "Kamu menyelesaikan modul ini.",
    reviewRecommended: "Pelajari kembali materi lalu coba lagi.",
    languageTitle: "Bahasa / Language", applyBtn: "Terapkan",
    aboutModule: "Tentang Modul Ini", learningJourney: "Alur Pembelajaran",
    chooseModule: "Pilih modul untuk memulai belajar.", learningModules: "Modul Pembelajaran",
    checkAnswer: "Periksa Jawaban", finishPractice: "Selesaikan Latihan",
    startingScore: "NILAI AWALMU", continueToLearning: "Lanjut ke Materi",
    questionOf: (n: number, tot: number) => `Soal ${n} dari ${tot}`,
    modulesCompletedOf: (n: number) => `${n} dari 3 Modul Selesai`,
    guideTitle: "Petunjuk Penggunaan", guideSub: "Belajar dengan langkah-langkah sederhana berikut.",
    guideItems: ["Pilih Modul", "Kerjakan Pre-test", "Pelajari Materi", "Pelajari Kosakata & Audio", "Kerjakan Latihan Interaktif", "Kerjakan Post-test", "Lihat Progres"],
    outcomesTitle: "Capaian Pembelajaran", outcomesSub: "Kurikulum Merdeka · Fase E · Kelas X SMK",
    outcomesItems: ["Mengidentifikasi fungsi sosial teks berkaitan retail.", "Mengenali struktur generik dan ciri kebahasaan.", "Memahami ide pokok dan informasi rinci.", "Menggunakan kosakata retail dalam konteks bermakna."],
    profileTitle: "Peneliti / Pengembang", profileSub: "Profil ini merupakan informasi peneliti untuk keperluan pengembangan aplikasi.",
    completed: "Selesai", inProgress: "Sedang Dipelajari", notStarted: "Belum Dimulai",
    notStartedYet: "Belum ada modul yang dimulai.", overallProgress: "Progres Keseluruhan",
    vocabPreview: "Pratinjau Kosakata", learnBeforeReading: "Pelajari kata-kata ini sebelum membaca.",
    continueToReading: "Lanjut ke Bacaan",
    listenToReading: "Dengarkan Teks", startPractice: "Mulai Latihan Interaktif",
    moduleResult: "Hasil Modul", yourResult: "Hasil Belajarmu",
    preResult: "Hasil Pre-test",
    learningMaterial: "Materi Pembelajaran",
    learnStep: "Belajar", practiceStep: "Latihan",
    afterModule: "Setelah menyelesaikan modul ini, kamu akan mampu:",
    aboutModuleDesc: "Pelajari cara kerja teks dalam konteks retail melalui bacaan terfokus, kosakata, audio, dan latihan interaktif.",
    activityOf: (n: number, tot: number) => `Aktivitas ${n} dari ${tot}`,
    localAudio: "Audio lokal", audioUnavailable: "Audio belum tersedia",
    playPronunciation: "Dengarkan pengucapan", playingPronunciation: "Memutar pengucapan...",
    answersReady: (n: number, tot: number) => `${n} dari ${tot} jawaban siap dikirim.`,
    correctCount: (c: number, w: number) => `${c} benar · ${w} salah`,
    percentComplete: (p: number) => `${p}% selesai`,
    wordType: "Jenis kata",
    posttestIntro: "Post-test",
    pretestIntroTitle: "Pre-test Diagnostik",
    stepLearn: "Belajar", stepPractice: "Latihan",
    stepOf: (n: number, tot: number) => `Langkah ${n} dari ${tot}`,
    questionsLabel: "soal", multipleChoice: "Pilihan Ganda",
    subMaterialOf: (n: number, tot: number) => `Teks ${n} dari ${tot}`,
    nextText: "Teks Berikutnya", finishReading: "Selesai Membaca",
    glossaryLabel: "Glosarium",
    sequenceHelp: "Gunakan tombol panah untuk memindahkan setiap item ke atas atau ke bawah.",
    moveUp: (x: string) => `Pindahkan ${x} ke atas`,
    moveDown: (x: string) => `Pindahkan ${x} ke bawah`,
    profileFields: {
      nama: "Nama Lengkap", nim: "NIM", prodi: "Program Studi",
      fakultas: "Fakultas", universitas: "Universitas",
      pembimbing: "Dosen Pembimbing", judul: "Judul Penelitian", tahun: "Tahun",
    },
  },
  en: {
    navHome: "Home", navModules: "Modules", navProgress: "Progress", navProfile: "Profile",
    readyToLearn: "Ready to learn?", startJourney: "Start your English learning journey.",
    exploreModules: "Explore Modules", continueLearning: "Continue Learning",
    learningProgress: "Learning Progress", yourModules: "Your Modules",
    quickAccess: "Quick Access", seeAll: "See All",
    startModule: "Start Module", continueModule: "Continue Module", reviewModule: "Review Module",
    learningObjectives: "Learning Objectives",
    startPretest: "Start Pre-test", diagnosticPretest: "Diagnostic Pre-test",
    pretestDesc: "Let's see what you already know.",
    pretestNote: "Your pre-test score does not affect your final module score.",
    startPosttest: "Start Post-test",
    posttestDesc: "You're almost there! Show what you have learned.",
    previous: "Previous", next: "Next",
    reviewAndSubmit: "Review & Submit", submitAnswers: "Submit Answers",
    reviewAnswers: "Review Answers", submitConfirmTitle: "Submit your answers?",
    submitConfirmDesc: "Make sure all questions have been answered.",
    reviewMaterial: "Review Material", tryAgain: "Try Again",
    backToModules: "Back to Home",
    greatJob: "Great job!", thatCorrect: "That's correct.",
    notQuiteYet: "Not quite yet", reviewSentence: "Review the material and try once more.",
    partialCredit: "Partially correct!",
    continueBtn: "Continue",
    yourProgress: "Your Learning Progress", noProgressYet: "Your learning journey starts here.",
    startLearning: "Start Learning",
    howToUse: "How to Use", learningOutcomes: "Learning Outcomes", profileLabel: "Profile",
    improvement: "Improvement", pretestLabel: "Pre-test", posttestRaw: "Post-test",
    posttestWeighted: "Post-test Weighted", practice: "Interactive Practice",
    finalScore: "Final Score", latestScore: "Latest Score", bestScore: "Best Score",
    tuntas: "Completed", perluReview: "Review Recommended", tetapSemangat: "Keep Going!",
    excellentProgress: "Excellent progress!", completedModule: "You completed this module.",
    reviewRecommended: "Review the material and try again.",
    languageTitle: "Bahasa / Language", applyBtn: "Apply",
    aboutModule: "About This Module", learningJourney: "Learning Journey",
    chooseModule: "Choose any module to start learning.", learningModules: "Learning Modules",
    checkAnswer: "Check Answer", finishPractice: "Finish Practice",
    startingScore: "YOUR STARTING SCORE", continueToLearning: "Continue to Learning",
    questionOf: (n: number, tot: number) => `Question ${n} of ${tot}`,
    modulesCompletedOf: (n: number) => `${n} of 3 Modules Completed`,
    guideTitle: "How to Use the App", guideSub: "Learn at your own pace with these simple steps.",
    guideItems: ["Choose a Module", "Complete Pre-test", "Study the Material", "Explore Vocabulary & Audio", "Complete Interactive Practice", "Take Post-test", "Check Your Progress"],
    outcomesTitle: "Learning Outcomes", outcomesSub: "Kurikulum Merdeka · Phase E · Grade X SMK",
    outcomesItems: ["Identify the social function of retail-related texts.", "Recognize generic structures and language features.", "Understand main ideas and detailed information.", "Use retail vocabulary in meaningful contexts."],
    profileTitle: "Researcher / Developer", profileSub: "This profile contains researcher information for the application development.",
    completed: "Completed", inProgress: "In Progress", notStarted: "Not Started",
    notStartedYet: "No module has been started yet.", overallProgress: "Overall Progress",
    vocabPreview: "Vocabulary Preview", learnBeforeReading: "Learn these words before reading.",
    continueToReading: "Continue to Reading",
    listenToReading: "Listen to Reading", startPractice: "Start Interactive Practice",
    moduleResult: "Module Result", yourResult: "Your Result",
    preResult: "Pre-test Result",
    learningMaterial: "Learning Material",
    learnStep: "Learn", practiceStep: "Practice",
    afterModule: "After completing this module, you will be able to:",
    aboutModuleDesc: "Learn how texts work in retail contexts through focused reading, vocabulary, audio, and practice activities.",
    activityOf: (n: number, tot: number) => `Activity ${n} of ${tot}`,
    localAudio: "Local audio", audioUnavailable: "Audio is not available yet",
    playPronunciation: "Listen to pronunciation", playingPronunciation: "Playing pronunciation...",
    answersReady: (n: number, tot: number) => `${n} of ${tot} answers are ready to submit.`,
    correctCount: (c: number, w: number) => `${c} correct · ${w} incorrect`,
    percentComplete: (p: number) => `${p}% complete`,
    wordType: "Part of speech",
    posttestIntro: "Post-test",
    pretestIntroTitle: "Diagnostic Pre-test",
    stepLearn: "Learn", stepPractice: "Practice",
    stepOf: (n: number, tot: number) => `Step ${n} of ${tot}`,
    questionsLabel: "questions", multipleChoice: "Multiple Choice",
    subMaterialOf: (n: number, tot: number) => `Text ${n} of ${tot}`,
    nextText: "Next Text", finishReading: "Finish Reading",
    glossaryLabel: "Glossary",
    sequenceHelp: "Use the arrow buttons to move each item up or down.",
    moveUp: (x: string) => `Move ${x} up`,
    moveDown: (x: string) => `Move ${x} down`,
    profileFields: {
      nama: "Full Name", nim: "Student ID / NIM", prodi: "Study Program",
      fakultas: "Faculty", universitas: "University",
      pembimbing: "Supervisor", judul: "Research Title", tahun: "Year",
    },
  },
};

// ─── Lang Context ─────────────────────────────────────────────────────────────
const LangCtx = createContext<{ lang: Lang; setLang: (l: Lang) => void; t: typeof T.id }>({
  lang: "id", setLang: () => {}, t: T.id,
});
function useLang() { return useContext(LangCtx); }
function LangProvider({ children }: { children: React.ReactNode }) {
  const [lang, setLangState] = useState<Lang>(() => (localStorage.getItem("evp-lang") as Lang) || "id");
  function setLang(l: Lang) { setLangState(l); localStorage.setItem("evp-lang", l); }
  return <LangCtx.Provider value={{ lang, setLang, t: T[lang] }}>{children}</LangCtx.Provider>;
}

// ─── Global State ─────────────────────────────────────────────────────────────
const GCtx = createContext<GCtxType | null>(null);
function useGlobalState() {
  const ctx = useContext(GCtx);
  if (!ctx) throw new Error("useGlobalState outside StateProvider");
  return ctx;
}
function defaultModState(): ModState {
  return { pct: 0, section: "", lastRoute: "", practiceActivities: [], practiceScore: 0, attempts: [] };
}
function loadGState(): GState {
  try {
    const raw = localStorage.getItem("evp-state-v2");
    if (raw) {
      const p = JSON.parse(raw) as GState;
      if (p?.version === 2 && p?.mods) {
        for (const id of [1, 2, 3]) {
          if (!p.mods[id]) p.mods[id] = defaultModState();
          if (!Array.isArray(p.mods[id].practiceActivities)) p.mods[id].practiceActivities = [];
          if (!Array.isArray(p.mods[id].attempts)) p.mods[id].attempts = [];
          if (typeof p.mods[id].practiceScore !== "number") p.mods[id].practiceScore = 0;
        }
        return p;
      }
    }
    // Migrate from v1
    const base: GState = { version: 2, mods: { 1: defaultModState(), 2: defaultModState(), 3: defaultModState() } };
    try {
      const v1 = JSON.parse(localStorage.getItem("evp-progress") || "{}");
      if (v1.m1) base.mods[1].pct = Number(v1.m1) || 0;
      if (v1.m2) base.mods[2].pct = Number(v1.m2) || 0;
      if (v1.m3) base.mods[3].pct = Number(v1.m3) || 0;
      if (v1.lastModule) base.lastModule = v1.lastModule;
      if (v1.lastRoute) base.lastRoute = v1.lastRoute;
    } catch { /* ignore */ }
    return base;
  } catch {
    return { version: 2, mods: { 1: defaultModState(), 2: defaultModState(), 3: defaultModState() } };
  }
}
function saveGState(s: GState) {
  try { localStorage.setItem("evp-state-v2", JSON.stringify(s)); } catch { /* ignore */ }
}

function StateProvider({ children }: { children: React.ReactNode }) {
  const [gs, setGS] = useState<GState>(loadGState);
  function persist(next: GState) { setGS(next); saveGState(next); }

  function updateModPct(id: number, pct: number, section: string, route: string) {
    const next = { ...gs, lastModule: id, lastRoute: route, mods: { ...gs.mods } };
    next.mods[id] = { ...next.mods[id], pct: Math.max(next.mods[id]?.pct ?? 0, pct), section, lastRoute: route };
    persist(next);
  }

  function savePretestResult(id: number, r: PretestData) {
    const next = { ...gs, mods: { ...gs.mods } };
    const mod = { ...next.mods[id] };
    mod.pretestResult = r;
    if (!mod.baselinePretest) {
      mod.baselinePretest = r;
    }
    next.mods[id] = mod;
    persist(next);
  }

  function savePracticeActivity(id: number, idx: number, r: ActivityResult) {
    const next = { ...gs, mods: { ...gs.mods } };
    const mod = { ...next.mods[id] };
    const acts = [...(mod.practiceActivities || [])];
    acts[idx] = r;
    mod.practiceActivities = acts;
    mod.practiceScore = acts.reduce((sum, a) => sum + (a?.score ?? 0), 0);
    next.mods[id] = mod;
    persist(next);
  }

  function finalizePosttest(id: number, r: PosttestData) {
    const next = { ...gs, mods: { ...gs.mods } };
    const mod = { ...next.mods[id] };
    
    // Idempotency: prevent StrictMode/refresh from duplicating attempts
    if (mod.posttestResult) return;
    
    mod.posttestResult = r;
    const pracScore = mod.practiceScore || 0;
    const finalScore = Math.min(100, Math.round((r.weighted + pracScore) * 10) / 10);
    const passed = finalScore >= PASSING_THRESHOLD;
    mod.finalScore = finalScore;
    mod.passed = passed;
    
    // Learning gain calculated against current attempt's pretest, not baseline
    const pretestScore = mod.pretestResult?.score ?? 0;
    
    const attempt: ModuleAttempt = {
      id: `${id}-${Date.now()}`,
      timestamp: new Date().toISOString(),
      pretestScore, practiceScore: pracScore,
      posttestRaw: r.raw, posttestWeighted: r.weighted,
      finalScore, learningGain: r.raw - pretestScore, passed,
    };
    mod.attempts = [...(mod.attempts || []), attempt];
    mod.latestScore = finalScore;
    mod.bestScore = Math.max(mod.bestScore ?? 0, finalScore);
    mod.pct = 100;
    next.mods[id] = mod;
    persist(next);
  }

  function retryModule(id: number) {
    const next = { ...gs, mods: { ...gs.mods } };
    const mod = { ...next.mods[id] };
    mod.pretestResult = undefined;
    mod.practiceActivities = [];
    mod.practiceScore = 0;
    mod.posttestResult = undefined;
    mod.finalScore = undefined;
    mod.passed = undefined;
    mod.pct = 10;
    mod.section = "";
    mod.lastRoute = `/module/${id}/objectives`;
    next.mods[id] = mod;
    next.lastRoute = `/module/${id}/objectives`;
    persist(next);
    try {
      localStorage.removeItem(`evp-pre-answers-m${id}`);
      localStorage.removeItem(`evp-post-answers-m${id}`);
    } catch { /* ignore */ }
  }

  return (
    <GCtx.Provider value={{ gs, updateModPct, savePretestResult, savePracticeActivity, finalizePosttest, retryModule }}>
      {children}
    </GCtx.Provider>
  );
}

// ─── Static content ───────────────────────────────────────────────────────────
const moduleIcons = [BookOpen, Store, ScanLine] as const;
const moduleArt = [module1Art, module2Art, module3Art] as const;
const modules: ModuleUI[] = Object.values(MODULES).map((module, index) => ({
  id: module.id,
  title: module.title,
  subtitle: module.subtitle,
  accent: module.accent,
  tint: module.tint,
  icon: moduleIcons[index],
  reading: module.readings[0].title,
  art: moduleArt[index],
}));
const moduleContent = (id: number) => MODULES[id] || MODULES[1];

// ─── Language sheet ───────────────────────────────────────────────────────────
function LanguageSheet({ close }: { close: () => void }) {
  const { lang, setLang, t } = useLang();
  const [sel, setSel] = useState<Lang>(lang);
  return (
    <div className="sheet-backdrop" onClick={close}>
      <div className="sheet lang-sheet" onClick={e => e.stopPropagation()}>
        <i className="handle" />
        <p className="lang-sheet-title">{t.languageTitle}</p>
        {(["id", "en"] as Lang[]).map(l => (
          <button key={l} className={`lang-option${sel === l ? " selected" : ""}`} onClick={() => setSel(l)}>
            <span>{l === "id" ? "Bahasa Indonesia" : "English"}</span>
            <span className={`radio${sel === l ? " checked" : ""}`}>{sel === l && <Check size={12} />}</span>
          </button>
        ))}
        <button className="button primary" style={{ marginTop: 16 }} onClick={() => { setLang(sel); close(); }}>
          {t.applyBtn}
        </button>
      </div>
    </div>
  );
}

// ─── Shell ────────────────────────────────────────────────────────────────────
function Shell({ children, title, back = true }: { children: React.ReactNode; title?: string; back?: boolean }) {
  const nav = useNavigate();
  const loc = useLocation();
  const { t } = useLang();
  const [langOpen, setLangOpen] = useState(false);
  const root = ["/home", "/modules", "/progress", "/profile"].includes(loc.pathname);
  const canChangeLanguage = ["/home", "/modules", "/progress"].includes(loc.pathname);
  return (
    <main className="app-shell">
      <div className="phone">
        <header className="topbar">
          {back && !root
            ? <button className="icon-button" onClick={() => nav(-1)} aria-label={t.previous}><ChevronLeft size={22} /></button>
            : <div className="brand-mark"><img src={logo} alt="EVP Learn" /></div>}
          <span>{title || "EVP Learn"}</span>
          {canChangeLanguage ? (
            <button className="icon-button" onClick={() => setLangOpen(true)} aria-label={t.languageTitle}><Globe size={20} /></button>
          ) : <span className="topbar-spacer" aria-hidden="true" />}
        </header>
        <div className="screen">{children}</div>
        {root && <BottomNav />}
        {langOpen && <LanguageSheet close={() => setLangOpen(false)} />}
      </div>
    </main>
  );
}

function BottomNav() {
  const nav = useNavigate();
  const { pathname } = useLocation();
  const { t } = useLang();
  const items = [
    ["/home", Home, t.navHome],
    ["/modules", Layers3, t.navModules],
    ["/progress", BarChart2, t.navProgress],
    ["/profile", UserRound, t.navProfile],
  ] as const;
  return (
    <nav className="bottom-nav bottom-nav-4">
      {items.map(([to, I, label]) => (
        <button key={to} className={pathname === to ? "active" : ""} onClick={() => nav(to)}>
          <I size={20} />
          <span>{label}</span>
        </button>
      ))}
    </nav>
  );
}

function Button({ children, onClick, variant = "primary", disabled = false }: {
  children: React.ReactNode; onClick?: () => void; variant?: "primary" | "secondary" | "text"; disabled?: boolean;
}) {
  return <button disabled={disabled} onClick={onClick} className={`button ${variant}`}>{children}</button>;
}

function ProgressBar({ value, color = "#2563eb" }: { value: number; color?: string }) {
  return <div className="progress"><i style={{ width: `${Math.min(100, value)}%`, background: color }} /></div>;
}

function useLocalAudio() {
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const [activeSrc, setActiveSrc] = useState<string>();
  const [elapsed, setElapsed] = useState(0);
  const [duration, setDuration] = useState(0);

  useEffect(() => () => audioRef.current?.pause(), []);

  function toggle(src: string) {
    const current = audioRef.current;
    if (current && activeSrc === src && !current.paused) {
      current.pause(); setActiveSrc(undefined); return;
    }
    current?.pause();
    const next = new Audio(src);
    audioRef.current = next;
    setElapsed(0); setDuration(0); setActiveSrc(src);
    next.onloadedmetadata = () => setDuration(Number.isFinite(next.duration) ? next.duration : 0);
    next.ontimeupdate = () => setElapsed(next.currentTime);
    next.onended = () => { setActiveSrc(undefined); setElapsed(0); };
    void next.play().catch(() => setActiveSrc(undefined));
  }

  function stop() {
    audioRef.current?.pause(); audioRef.current = null;
    setActiveSrc(undefined); setElapsed(0); setDuration(0);
  }

  return { activeSrc, duration, elapsed, toggle, stop };
}

// ─── Home ─────────────────────────────────────────────────────────────────────
function HomePage() {
  const nav = useNavigate();
  const { t } = useLang();
  const { gs } = useGlobalState();
  const mods = gs.mods;
  const pcts = [mods[1]?.pct ?? 0, mods[2]?.pct ?? 0, mods[3]?.pct ?? 0];
  const returning = pcts.some(p => p > 0);
  const completedCount = pcts.filter(v => v >= 100).length;
  const overallPct = Math.round(pcts.reduce((s, v) => s + v, 0) / 3);

  const activeId = gs.lastModule || ([1, 2, 3].find(id => (mods[id]?.pct ?? 0) > 0 && (mods[id]?.pct ?? 0) < 100) ?? null);
  const m = activeId ? modules[activeId - 1] : null;
  const mProgress = activeId ? (mods[activeId]?.pct ?? 0) : 0;
  const mSection = activeId ? (mods[activeId]?.section || "") : "";
  const mRoute = activeId ? (mods[activeId]?.lastRoute || gs.lastRoute || `/module/${activeId}/reading`) : "";

  return (
    <Shell back={false}>
      <section className="home-hero">
        <p className="eyebrow">ENGLISH FOR VOCATIONAL PURPOSES</p>
        <h1>{t.readyToLearn}</h1>
        <p>{returning ? t.continueLearning + "." : t.startJourney}</p>
        <div className="hero-objects">
          <div className="shelf"><i /><i /><i /></div>
          <img className="hero-logo" src={logo} alt="EVP Learn" />
        </div>
      </section>

      {returning && m ? (
        <section className="continue-card" onClick={() => nav(mRoute)}>
          <span>{t.continueLearning.toUpperCase()}</span>
          <div><b>Module 0{activeId} · {m.title}</b><p>{mSection || `Reading · ${m.reading}`}</p></div>
          <ProgressBar value={mProgress} color={m.accent} />
          <footer><small>{t.percentComplete(mProgress)}</small><ArrowRight size={19} /></footer>
        </section>
      ) : !returning ? (
        <Button onClick={() => nav("/modules")}>{t.exploreModules} <ArrowRight size={18} /></Button>
      ) : null}

      <section className="section-head">
        <div><h2>{t.learningProgress}</h2><p>{returning ? "" : t.noProgressYet}</p></div>
        <b>{t.modulesCompletedOf(completedCount)}</b>
      </section>
      <ProgressBar value={overallPct} />

      <section className="section-head" style={{ marginTop: 28 }}>
        <h2>{t.yourModules}</h2>
        <button className="text-link" onClick={() => nav("/modules")}>{t.seeAll}</button>
      </section>
      <div className="module-slider">
        {modules.map(mod => {
          const prog = mods[mod.id]?.pct ?? 0;
          return <SliderCard key={mod.id} m={mod} onClick={() => nav(`/module/${mod.id}`)} progress={prog} t={t} />;
        })}
      </div>

      <section className="section-head" style={{ marginTop: 28 }}>
        <h2>{t.quickAccess}</h2>
      </section>
      <div className="quick-grid-2">
        <Quick2 icon={CircleHelp} label={t.howToUse} onClick={() => nav("/guide")} />
        <Quick2 icon={Target} label={t.learningOutcomes} onClick={() => nav("/outcomes")} />
      </div>
    </Shell>
  );
}

function Quick2({ icon: I, label, onClick }: { icon: React.ElementType; label: string; onClick: () => void }) {
  return (
    <button onClick={onClick} className="quick2">
      <I size={22} />
      <span>{label}</span>
    </button>
  );
}

function SliderCard({ m, onClick, progress, t }: { m: ModuleUI; onClick: () => void; progress: number; t: typeof T.id }) {
  const I = m.icon;
  return (
    <button className="slider-card" onClick={onClick}>
      <div className="slider-card-top">
        <div className="slider-card-icon" style={{ background: m.tint, color: m.accent }}>
          <I size={24} />
        </div>
        {progress > 0 && <span className="slider-card-progress">{progress}%</span>}
      </div>
      <div>
        <h3>Module 0{m.id}</h3>
        <p>{m.title}</p>
      </div>
      <div className="slider-card-footer">
        <span>{t.exploreModules}</span>
        <div className="play-btn">
          <Play size={16} fill="currentColor" style={{ marginLeft: 2 }} />
        </div>
      </div>
    </button>
  );
}

// ─── Modules page ─────────────────────────────────────────────────────────────
function ModulesPage() {
  const nav = useNavigate();
  const { t } = useLang();
  const { gs } = useGlobalState();
  return (
    <Shell title={t.navModules}>
      <div className="page-title">
        <h1>{t.learningModules}</h1>
        <p>{t.chooseModule}</p>
      </div>
      <div className="module-list">
        {modules.map(m => {
          const prog = gs.mods[m.id]?.pct ?? 0;
          return <ModuleCard key={m.id} m={m} progress={prog} onClick={() => nav(`/module/${m.id}`)} />;
        })}
      </div>
    </Shell>
  );
}

function ModuleCard({ m, progress, onClick }: { m: ModuleUI; progress: number; onClick: () => void }) {
  const { t } = useLang();
  const I = m.icon;
  const statusLabel = progress >= 100 ? t.completed : progress > 0 ? t.inProgress : t.notStarted;
  const ctaLabel = progress >= 100 ? t.reviewModule : progress > 0 ? t.continueModule : t.startModule;
  return (
    <article className="module-card" style={{ "--accent": m.accent, "--tint": m.tint } as React.CSSProperties}>
      <div className="module-card-top">
        <span className="module-number">0{m.id}</span>
        <span className="status"><CircleDot size={13} />{statusLabel}</span>
      </div>
      <h2>{m.title}</h2>
      <p>{m.subtitle}</p>
      <div className="module-art"><img src={m.art} alt={`${m.title} illustration`} /></div>
      <ProgressBar value={progress} color={m.accent} />
      <footer>
        <small>{t.percentComplete(progress)}</small>
        <Button onClick={onClick} variant="text">{ctaLabel} <ArrowRight size={16} /></Button>
      </footer>
    </article>
  );
}

// ─── Overview ─────────────────────────────────────────────────────────────────
function Overview() {
  const nav = useNavigate();
  const { t } = useLang();
  const id = Number(useLocation().pathname.split("/")[2]) || 1;
  const m = modules[id - 1];
  const content = moduleContent(id);
  const I = m.icon;
  const { updateModPct } = useGlobalState();
  return (
    <Shell title={`Module 0${id}`}>
      <div className="overview-hero" style={{ background: m.tint }}>
        <span style={{ color: m.accent }}>MODULE 0{id}</span>
        <h1>{m.title}</h1>
        <p>{m.subtitle}</p>
        <div className="hero-icon" style={{ color: m.accent }}><I size={66} /></div>
      </div>
      <section>
        <h2>{t.aboutModule}</h2>
        <p className="body-copy">{t.aboutModuleDesc}</p>
      </section>
      <section>
        <h2>{t.learningObjectives}</h2>
        <ul className="learn-list">
          {content.objectives.slice(0, 3).map((x, i) => <li key={x}><b>0{i + 1}</b>{x}</li>)}
        </ul>
      </section>
      <section>
        <h2>{t.learningJourney}</h2>
        <div className="stepper">
          {["Pre-test", t.stepLearn, t.stepPractice, "Post-test"].map((x, i) => (
            <div className={i === 0 ? "current" : ""} key={x}><i>{i + 1}</i><span>{x}</span></div>
          ))}
        </div>
      </section>
      <Button onClick={() => {
        updateModPct(id, 10, t.learningObjectives, `/module/${id}/objectives`);
        nav(`/module/${id}/objectives`);
      }}>
        {t.startModule} <ArrowRight size={18} />
      </Button>
    </Shell>
  );
}

// ─── Objectives ───────────────────────────────────────────────────────────────
function Objectives() {
  const nav = useNavigate();
  const { t } = useLang();
  const id = Number(useLocation().pathname.split("/")[2]) || 1;
  const m = modules[id - 1];
  const content = moduleContent(id);
  return (
    <Shell title={t.learningObjectives}>
      <div className="page-title">
        <p className="eyebrow">MODULE 0{id} · {m.title.toUpperCase()}</p>
        <h1>{t.learningObjectives}</h1>
        <p>{t.afterModule}</p>
      </div>
      <div className="objective-list">
        {content.objectives.map((x, i) => <article key={x}><b>0{i + 1}</b><p>{x}</p></article>)}
      </div>
      <Button onClick={() => nav(`/module/${id}/pretest`)}>{t.startPretest} <ArrowRight size={18} /></Button>
    </Shell>
  );
}

// ─── Assessment intro ─────────────────────────────────────────────────────────
function AssessmentIntro({ post = false }: { post?: boolean }) {
  const nav = useNavigate();
  const { t } = useLang();
  const id = Number(useLocation().pathname.split("/")[2]) || 1;
  const m = modules[id - 1];
  return (
    <Shell title={post ? t.posttestIntro : t.pretestIntroTitle}>
      <div className="assessment-intro">
        <div className="intro-icon"><ClipboardCheck size={38} /></div>
        <p className="eyebrow">MODULE 0{id} · {m.title.toUpperCase()}</p>
        <h1>{post ? "Post-test" : t.diagnosticPretest}</h1>
        <p>{post ? t.posttestDesc : t.pretestDesc}</p>
        <div className="meta"><span>10 {t.questionsLabel}</span><span>{t.multipleChoice}</span></div>
        {!post && (
          <aside className="info-box">
            <Info size={19} />
            <p>{t.pretestNote}</p>
          </aside>
        )}
      </div>
      <Button onClick={() => nav(`/module/${id}/${post ? "postquiz" : "prequiz"}`)}>
        {post ? t.startPosttest : t.startPretest} <ArrowRight size={18} />
      </Button>
    </Shell>
  );
}

// ─── Quiz ─────────────────────────────────────────────────────────────────────
function Quiz({ post = false }: { post?: boolean }) {
  const nav = useNavigate();
  const { t } = useLang();
  const id = Number(useLocation().pathname.split("/")[2]) || 1;
  const [index, setIndex] = useState(0);
  const answerStorageKey = `evp-${post ? "post" : "pre"}-answers-m${id}`;
  const [answers, setAnswers] = useState<(number | undefined)[]>(() => {
    try {
      const stored = JSON.parse(localStorage.getItem(answerStorageKey) || "[]");
      return Array.isArray(stored) ? stored : [];
    } catch { return []; }
  });
  const module = modules[id - 1];
  const questions = post ? moduleContent(id).posttest : moduleContent(id).pretest;
  const q = questions[index % questions.length];
  const last = index === questions.length - 1;

  useEffect(() => { localStorage.setItem(answerStorageKey, JSON.stringify(answers)); }, [answerStorageKey, answers]);

  function next() {
    if (last) nav(`/module/${id}/${post ? "postsubmit" : "presubmit"}`);
    else setIndex(index + 1);
  }

  return (
    <Shell title={post ? "Post-test" : t.diagnosticPretest}>
      <div className="quiz-head">
        <span>{post ? "POST-TEST" : "PRE-TEST DIAGNOSTIK"}</span>
        <b>{t.questionOf(index + 1, questions.length)}</b>
      </div>
      <ProgressBar value={((index + 1) / questions.length) * 100} />
      <section className="question">
        <figure className="question-visual">
          <img src={module.art} alt={`Visual context for ${module.title}`} />
        </figure>
        <h2>{q.prompt}</h2>
        <div className="options">
          {q.options.map((a, i) => (
            <button
              key={a}
              className={answers[index] === i ? "selected" : ""}
              onClick={() => setAnswers(v => { const n = [...v]; n[index] = i; return n; })}
            >
              <b>{"ABCD"[i]}</b>
              <span>{a}</span>
              {answers[index] === i && <Check size={18} />}
            </button>
          ))}
        </div>
      </section>
      <div className="quiz-actions">
        <Button variant="secondary" onClick={() => setIndex(Math.max(0, index - 1))} disabled={index === 0}>
          {t.previous}
        </Button>
        <Button disabled={answers[index] === undefined} onClick={next}>
          {last ? t.reviewAndSubmit : t.next} <ChevronRight size={18} />
        </Button>
      </div>
    </Shell>
  );
}

// ─── Submit confirm ───────────────────────────────────────────────────────────
function SubmitConfirm({ post = false }: { post?: boolean }) {
  const nav = useNavigate();
  const { t } = useLang();
  const id = Number(useLocation().pathname.split("/")[2]) || 1;
  const questions = post ? moduleContent(id).posttest : moduleContent(id).pretest;
  const answerKey = `evp-${post ? "post" : "pre"}-answers-m${id}`;

  const answeredCount = useMemo(() => {
    try {
      const stored: (number | undefined)[] = JSON.parse(localStorage.getItem(answerKey) || "[]");
      return stored.filter((a) => typeof a === "number" && Number.isInteger(a)).length;
    } catch { return 0; }
  }, [answerKey]);

  const allAnswered = answeredCount === questions.length;

  return (
    <Shell title={t.reviewAndSubmit}>
      <div className="empty submit">
        <div><ClipboardCheck size={34} /></div>
        <h2>{t.submitConfirmTitle}</h2>
        <p>{t.submitConfirmDesc}</p>
        <aside className="info-box">
          <Info size={18} />
          <p>{t.answersReady(answeredCount, questions.length)}</p>
        </aside>
        {!allAnswered && (
          <aside className="info-box warn">
            <AlertTriangle size={18} />
            <p>{post ? "Pastikan semua soal dijawab sebelum submit." : "Pastikan semua soal dijawab."}</p>
          </aside>
        )}
        <Button onClick={() => nav(`/module/${id}/${post ? "postresult" : "preresult"}`)}>
          {t.submitAnswers}
        </Button>
        <Button variant="secondary" onClick={() => nav(-1)}>{t.reviewAnswers}</Button>
      </div>
    </Shell>
  );
}

// ─── Pre-test result ──────────────────────────────────────────────────────────
function PreResult() {
  const nav = useNavigate();
  const { t } = useLang();
  const { gs, savePretestResult, updateModPct } = useGlobalState();
  const id = Number(useLocation().pathname.split("/")[2]) || 1;
  const modState = gs.mods[id];

  const { preScore, preCorrect, preIncorrect } = useMemo(() => {
    if (modState?.pretestResult) {
      return { preScore: modState.pretestResult.score, preCorrect: modState.pretestResult.correct, preIncorrect: modState.pretestResult.incorrect };
    }
    try {
      const answers: (number | undefined)[] = JSON.parse(localStorage.getItem(`evp-pre-answers-m${id}`) || "[]");
      const result = calculateQuizScore(moduleContent(id).pretest, answers);
      return { preScore: result.percentage, preCorrect: result.correct, preIncorrect: result.incorrect };
    } catch {
      return { preScore: 0, preCorrect: 0, preIncorrect: 0 };
    }
  }, [id, modState?.pretestResult]);

  useEffect(() => {
    if (!modState?.pretestResult) {
      savePretestResult(id, { score: preScore, correct: preCorrect, incorrect: preIncorrect });
    }
  }, [id]);

  return (
    <Shell title={t.preResult}>
      <div className="calm-score">
        <span>{t.startingScore}</span>
        <h1>{preScore}<small>/100</small></h1>
        <p>{t.correctCount(preCorrect, preIncorrect)}</p>
      </div>
      <aside className="info-box"><Info size={19} /><p>{t.pretestNote}</p></aside>
      <Button onClick={() => {
        updateModPct(id, 20, t.learningMaterial, `/module/${id}/theory`);
        nav(`/module/${id}/theory`);
      }}>
        {t.continueToLearning} <ArrowRight size={18} />
      </Button>
    </Shell>
  );
}

// ─── Theory ───────────────────────────────────────────────────────────────────
function Theory() {
  const nav = useNavigate();
  const { t, lang } = useLang();
  const id = Number(useLocation().pathname.split("/")[2]) || 1;
  const content = moduleContent(id);
  const { updateModPct } = useGlobalState();

  const c = {
    defTitle: lang === "id" ? "Pengertian & Tujuan" : "Definition & Purpose",
    defSub: "Definition & Purpose",
    structTitle: lang === "id" ? "Struktur Teks" : "Text Structure",
    structSub: "Generic Structure",
    featTitle: lang === "id" ? "Ciri Kebahasaan" : "Key Language Features",
    featSub: "Key Language Features",
    structures: content.theory.structure.map(item => item.split(" — ")[0]),
    features: content.theory.features.map(item => item.split(" — ")[0]),
  };
  const lesson = {
    definition: content.theory.definition,
    purpose: content.overview,
    structures: content.theory.structure.map(item => item.split(" — ")[1] || item),
    features: content.theory.features.map(item => item.split(" — ")[1] || item),
  };

  const lessonExtra = ({
    1: { art: narrativeLessonArt, artAlt: "Visual story of a retail entrepreneur." },
    2: { art: descriptiveLessonArt, artAlt: "Retail point-of-sale terminal and products." },
    3: { art: procedureLessonArt, artAlt: "Retail cashier processing a customer checkout." },
  } as const)[id] || { art: narrativeLessonArt, artAlt: "Retail learning illustration." };

  return (
    <Shell title={t.learningMaterial}>
      <p className="eyebrow">MODULE 0{id} · {modules[id - 1].title.toUpperCase()}</p>
      <div className="page-title compact">
        <h1>{t.learningMaterial}</h1>
        <p>{t.learnStep} · {t.stepOf(2, 4)}</p>
      </div>
      <figure className="lesson-visual">
        <img src={lessonExtra.art} alt={lessonExtra.artAlt} />
      </figure>
      <section className="theory-section">
        <h2>{c.defTitle}</h2>
        <p className="theory-sub">{c.defSub}</p>
        <p>{lesson.definition}</p>
      </section>
      <section>
        <h2>{c.structTitle}</h2>
        <p className="theory-sub">{c.structSub}</p>
        <div className="structure">
          {c.structures.map((x, i) => (
            <div key={x}><b>{i + 1}</b><span><strong>{x}</strong><small>{lesson.structures[i]}</small></span>{i < c.structures.length - 1 && <i />}</div>
          ))}
        </div>
      </section>
      <section className="theory-section">
        <h2>{c.featTitle}</h2>
        <p className="theory-sub">{c.featSub}</p>
        <div className="feature-list">{c.features.map((x, i) => <article key={x}><b>{x}</b><p>{lesson.features[i]}</p></article>)}</div>
      </section>
      <Button onClick={() => {
        updateModPct(id, 35, t.vocabPreview, `/module/${id}/vocabulary`);
        nav(`/module/${id}/vocabulary`);
      }}>
        {t.vocabPreview} <ArrowRight size={18} />
      </Button>
    </Shell>
  );
}

// ─── Vocabulary ───────────────────────────────────────────────────────────────
function Vocabulary() {
  const nav = useNavigate();
  const { t, lang } = useLang();
  const id = Number(useLocation().pathname.split("/")[2]) || 1;
  const { activeSrc, toggle, stop } = useLocalAudio();
  const { updateModPct } = useGlobalState();
  const words = moduleContent(id).vocabularyPreview; // 5 preview words

  return (
    <Shell title={`${lang === "id" ? "Modul" : "Module"} 0${id}`}>
      <div className="page-title">
        <h1>{t.vocabPreview}</h1>
        <p>{t.learnBeforeReading}</p>
      </div>
      <div className="vocab-list">
        {words.map(({ word, pos: type, meaning }, index) => {
          const source = `/audio/vocabulary/m${id}-${index + 1}.wav`;
          const available = hasAudio("vocabulary", source);
          const playing = activeSrc === source;
          return (
            <article key={word}>
              <div>
                <h3>{word}</h3>
                <span>{type}</span>
                <p>{meaning}</p>
              </div>
              {available ? (
                <button
                  className={playing ? "playing" : ""}
                  onClick={() => toggle(source)}
                  aria-label={`${t.playPronunciation} ${word}`}
                >
                  {playing ? <Pause size={18} /> : <Volume2 size={18} />}
                </button>
              ) : (
                <button
                  className="audio-unavailable"
                  disabled
                  aria-disabled="true"
                  aria-label={t.audioUnavailable}
                  title={t.audioUnavailable}
                >
                  <Volume2 size={18} />
                </button>
              )}
            </article>
          );
        })}
      </div>
      <Button onClick={() => {
        stop();
        updateModPct(id, 45, lang === "id" ? "Teks Bacaan" : "Reading", `/module/${id}/reading`);
        nav(`/module/${id}/reading`);
      }}>
        {t.continueToReading} <ArrowRight size={18} />
      </Button>
    </Shell>
  );
}

// ─── Glossary fallback map ─────────────────────────────────────────────────────
const GLOSS: Record<string, { pos: string; meaning: string }> = {
  affordable:           { pos: "adjective",   meaning: "Terjangkau; dapat dibeli oleh banyak orang." },
  supplier:             { pos: "noun",        meaning: "Pemasok; pihak yang menyediakan barang atau bahan." },
  suppliers:            { pos: "noun",        meaning: "Pemasok; pihak yang menyediakan barang atau bahan." },
  boycott:              { pos: "verb/noun",   meaning: "Memboikot; menolak menggunakan sesuatu sebagai bentuk protes." },
  "flat-pack":          { pos: "noun",        meaning: "Kemasan datar; furnitur dikemas tipis untuk dirakit sendiri." },
  assemble:             { pos: "verb",        meaning: "Merakit; menyusun bagian-bagian menjadi satu kesatuan." },
  retailer:             { pos: "noun",        meaning: "Pengecer; penjual yang menjual langsung ke konsumen." },
  delivery:             { pos: "noun",        meaning: "Pengiriman; proses mengantar barang ke pelanggan." },
  sleek:                { pos: "adjective",   meaning: "Halus, modern, dan elegan." },
  casing:               { pos: "noun",        meaning: "Badan atau penutup luar perangkat." },
  integrated:           { pos: "adjective",   meaning: "Terintegrasi; tergabung menjadi satu sistem." },
  sturdy:               { pos: "adjective",   meaning: "Kokoh; kuat dan tidak mudah rusak." },
  "dual-screen display":{ pos: "noun phrase", meaning: "Layar ganda untuk kasir dan pembeli." },
  finish:               { pos: "noun",        meaning: "Lapisan akhir permukaan produk." },
  adjustable:           { pos: "adjective",   meaning: "Dapat disesuaikan; bisa diubah posisi atau tingginya." },
  durable:              { pos: "adjective",   meaning: "Tahan lama; kuat dalam jangka waktu panjang." },
  "gondola shelving":   { pos: "noun phrase", meaning: "Rak gondola; rak display standar supermarket." },
  "open-front":         { pos: "adjective",   meaning: "Terbuka pada bagian depan." },
  visibility:           { pos: "noun",        meaning: "Visibilitas; kemampuan untuk dilihat dengan jelas." },
  genuine:              { pos: "adjective",   meaning: "Asli; terbuat dari bahan yang autentik." },
  asymmetrical:         { pos: "adjective",   meaning: "Tidak simetris." },
  "eye-catching":       { pos: "adjective",   meaning: "Menarik perhatian." },
  centerpiece:          { pos: "noun",        meaning: "Produk utama pusat tampilan." },
  merchandise:          { pos: "noun",        meaning: "Barang dagangan." },
  greet:                { pos: "imperative verb", meaning: "Menyapa; mengucapkan salam kepada pelanggan." },
  scan:                 { pos: "verb",        meaning: "Memindai; membaca kode barcode produk." },
  verify:               { pos: "verb",        meaning: "Memeriksa; memastikan kebenaran data." },
  "payment method":     { pos: "noun phrase", meaning: "Metode pembayaran yang dipilih pelanggan." },
  enter:                { pos: "imperative verb", meaning: "Memasukkan; menginput jumlah uang ke sistem." },
  change:               { pos: "noun",        meaning: "Kembalian; uang sisa yang dikembalikan ke pelanggan." },
  receipt:              { pos: "noun",        meaning: "Struk belanja; bukti pembayaran resmi." },
  "hand over":          { pos: "verb phrase", meaning: "Menyerahkan; memberikan barang kepada pelanggan." },
  innovation:           { pos: "noun",        meaning: "Inovasi; ide atau cara baru yang membawa perubahan." },
  crisis:               { pos: "noun",        meaning: "Krisis; masalah besar yang membutuhkan penyelesaian." },
};

// ─── Reading ──────────────────────────────────────────────────────────────────
function Reading() {
  const nav = useNavigate();
  const { t, lang } = useLang();
  const id = Number(useLocation().pathname.split("/")[2]) || 1;
  const m = modules[id - 1];
  const [glossWord, setGlossWord] = useState<string | undefined>();
  const { activeSrc, duration, elapsed, toggle, stop } = useLocalAudio();
  const [textIndex, setTextIndex] = useState(0);
  const { updateModPct } = useGlobalState();

  const texts = moduleContent(id).readings;
  const current = texts[textIndex] || texts[0];
  const isLast = textIndex === texts.length - 1;

  useEffect(() => { setTextIndex(0); }, [id]);
  useEffect(() => { stop(); }, [textIndex]);

  const fmt = (s: number) => `${String(Math.floor(s / 60)).padStart(2, "0")}:${String(Math.floor(s % 60)).padStart(2, "0")}`;
  const audioSource = `/audio/reading/m${id}-${textIndex + 1}.wav`;
  const audioAvailable = hasAudio("reading", audioSource);
  const playing = activeSrc === audioSource;

  const readingGlossary = readingGlossaryFor(current);

  function renderBody(body: string, highlights: string[] = []): React.ReactNode[] {
    const lines = body.split("\n");
    return lines.map((line, lineIdx) => {
      if (!line.trim()) return <br key={`br-${lineIdx}`} />;
      if (!highlights.length) return <p key={lineIdx}>{line}</p>;

      const parts: React.ReactNode[] = [];
      let remaining = line;

      for (const h of highlights) {
        const idx = remaining.toLowerCase().indexOf(h.toLowerCase());
        if (idx >= 0) {
          if (idx > 0) parts.push(remaining.slice(0, idx));
          parts.push(
            <button key={`${h}-${lineIdx}`} className="gloss-word" onClick={() => setGlossWord(h.toLowerCase())}>
              {remaining.slice(idx, idx + h.length)}
            </button>
          );
          remaining = remaining.slice(idx + h.length);
        }
      }
      if (remaining) parts.push(remaining);
      return <p key={lineIdx}>{parts.length > 1 || parts.some(p => typeof p !== "string") ? parts : line}</p>;
    });
  }

  return (
    <Shell title={lang === "id" ? "Teks Bacaan" : "Reading"}>
      <p className="eyebrow">MODULE 0{id} · {m.title.toUpperCase()}</p>
      {texts.length > 1 && (
        <>
          <p className="eyebrow" style={{ marginTop: 2, color: m.accent }}>{t.subMaterialOf(textIndex + 1, texts.length)}</p>
          <div className="reading-selector" aria-label={lang === "id" ? "Pilih teks bacaan" : "Choose reading text"}>
            {texts.map((text, index) => (
              <button
                key={text.title}
                className={index === textIndex ? "selected" : ""}
                onClick={() => setTextIndex(index)}
                aria-label={`${lang === "id" ? "Teks" : "Text"} ${index + 1}: ${text.title}`}
              >
                {index + 1}
              </button>
            ))}
          </div>
        </>
      )}
      <div className="page-title compact">
        <h1>{current.title}</h1>
        {current.subtitle && <p>{current.subtitle}</p>}
      </div>

      <div className="reading-illustration">
        <ReadingIllustration kind={current.visual} />
      </div>

      <article className="audio-card">
        <div className="audio-icon"><Headphones size={21} /></div>
        <div>
          <b>{t.listenToReading}</b>
          <small>{audioAvailable ? t.localAudio : t.audioUnavailable}</small>
        </div>
        {audioAvailable ? (
          <button
            onClick={() => toggle(audioSource)}
            aria-label={playing ? (lang === "id" ? "Jeda audio" : "Pause audio") : (lang === "id" ? "Putar audio" : "Play audio")}
          >
            {playing ? <Pause size={19} /> : <Play size={19} />}
          </button>
        ) : (
          <button disabled aria-disabled="true" aria-label={t.audioUnavailable} className="audio-unavailable">
            <Play size={19} />
          </button>
        )}
        {audioAvailable && (
          <>
            <div className="audio-progress">
              <i style={{ width: `${duration ? Math.min(100, (elapsed / duration) * 100) : 0}%` }} />
            </div>
            <small>{fmt(elapsed)} <span>{duration ? fmt(Math.ceil(duration)) : ""}</span></small>
          </>
        )}
      </article>

      <article className="reading-copy">
        {current.sections.map(sec => (
          <div key={sec.heading}>
            <h3>{sec.heading}</h3>
            {renderBody(sec.body, sec.highlights)}
          </div>
        ))}
      </article>

      {isLast ? (
        <Button onClick={() => {
          updateModPct(id, 65, lang === "id" ? "Latihan Interaktif" : "Interactive Practice", `/module/${id}/practice`);
          nav(`/module/${id}/practice`);
        }}>
          {t.startPractice} <ArrowRight size={18} />
        </Button>
      ) : (
        <Button onClick={() => setTextIndex(textIndex + 1)}>
          {t.nextText} <ArrowRight size={18} />
        </Button>
      )}

      {glossWord && <GlossarySheet word={glossWord} glossary={readingGlossary} close={() => setGlossWord(undefined)} />}
    </Shell>
  );
}

// ─── Glossary bottom sheet ────────────────────────────────────────────────────
function GlossarySheet({ word, glossary, close }: { word: string; glossary: Record<string, Word>; close: () => void }) {
  const { t, lang } = useLang();
  const { activeSrc, toggle } = useLocalAudio();
  const info = glossary[word.toLowerCase()] || GLOSS[word.toLowerCase()] || { pos: "noun", meaning: lang === "id" ? "Makna tersedia di kamus." : "Meaning available in dictionary." };
  const audioPath = `/audio/glossary/${word.toLowerCase().replace(/\s+/g, "-")}.wav`;
  const audioAvailable = hasAudio("glossary", audioPath);
  const playing = audioPath === activeSrc;

  useEffect(() => {
    const onKey = (e: KeyboardEvent) => { if (e.key === "Escape") close(); };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [close]);

  return (
    <div className="sheet-backdrop" onClick={close} role="presentation">
      <div className="sheet" onClick={e => e.stopPropagation()} role="dialog" aria-modal="true" aria-label={`${word} ${lang === "id" ? "glosarium" : "glossary"}`}>
        <i className="handle" />
        <button className="sheet-close" onClick={close} aria-label={lang === "id" ? "Tutup" : "Close"}><X size={20} /></button>
        <span className="eyebrow">{t.wordType.toUpperCase()} · {info.pos.toUpperCase()}</span>
        <h2 style={{ textTransform: "capitalize" }}>{word}</h2>
        {audioAvailable ? (
          <button
            className="pronounce"
            onClick={() => toggle(audioPath)}
            aria-label={playing ? (lang === "id" ? "Jeda pengucapan" : "Pause pronunciation") : t.playPronunciation}
          >
            {playing ? <Pause size={18} /> : <Volume2 size={18} />}
            {playing ? t.playingPronunciation : t.playPronunciation}
          </button>
        ) : (
          <button className="pronounce audio-unavailable" disabled aria-disabled="true" aria-label={t.audioUnavailable}>
            <Volume2 size={18} />
            <span>{t.audioUnavailable}</span>
          </button>
        )}
        <p>{info.meaning}</p>
      </div>
    </div>
  );
}

// ─── Practice ─────────────────────────────────────────────────────────────────
function Practice() {
  const nav = useNavigate();
  const { t, lang } = useLang();
  const id = Number(useLocation().pathname.split("/")[2]) || 1;
  const { updateModPct, savePracticeActivity } = useGlobalState();
  const [stage, setStage] = useState(1);
  const [selectedLeft, setSelectedLeft] = useState<string | undefined>();
  const [pairs, setPairs] = useState<Record<string, string>>({});
  const [checked, setChecked] = useState(false);
  const [draggedLeft, setDraggedLeft] = useState<string | undefined>();
  const [dragOverRight, setDragOverRight] = useState<string | undefined>();
  const [activityScores, setActivityScores] = useState<ActivityResult[]>([]);
  const modulePractices = moduleContent(id).practices;
  const seqPractice = modulePractices.find(p => p.type === "sequence");
  const [order, setOrder] = useState<string[]>(() => seqPractice && seqPractice.type === "sequence" ? [...seqPractice.items] : []);
  const practice = modulePractices[stage - 1];
  const isSequence = practice.type === "sequence";
  const matching = isSequence ? undefined : practice;
  const sequenceIsCorrect = isSequence && practice.type === "sequence" && order.every((item, i) => item === practice.answer[i]);
  const pairIsCorrect = matching && matching.left.every(left => pairs[left] === matching.pairs[left]);
  const isCorrect = isSequence ? sequenceIsCorrect : Boolean(pairIsCorrect);

  const practiceCopy = {
    id: {
      1: [["Mencocokkan Struktur", "Cocokkan setiap bagian Narrative Text dengan fungsinya."], ["Mencocokkan Kosakata", "Cocokkan kosakata retail dengan makna bahasa Indonesianya."], ["Mengurutkan Peristiwa", "Atur peristiwa cerita dari awal hingga akhir."]],
      2: [["Mencocokkan Fitur Produk", "Cocokkan setiap fitur dengan produk retail yang tepat."], ["Mencocokkan Kosakata", "Cocokkan kosakata deskriptif dengan makna bahasa Indonesianya."], ["Mengelompokkan Struktur Teks", "Cocokkan kalimat dengan bagian Identification atau Description."]],
      3: [["Mengurutkan Proses Checkout", "Atur langkah checkout dari awal hingga akhir."], ["Mencocokkan Peralatan", "Cocokkan peralatan retail dengan kegunaannya."], ["Mencocokkan Kata Penghubung", "Cocokkan kata penghubung urutan dengan makna bahasa Indonesianya."]],
    },
    en: {
      1: [["Structure Match", "Match each Narrative Text part with its purpose."], ["Vocabulary Match", "Match each retail word with its Indonesian meaning."], ["Event Sequence", "Arrange the story events from first to last."]],
      2: [["Product Feature Match", "Match each feature with the correct retail product."], ["Vocabulary Match", "Match each descriptive word with its Indonesian meaning."], ["Text Structure Sort", "Match each sentence with Identification or Description."]],
      3: [["Checkout Sequence", "Arrange the checkout steps in the correct order."], ["Equipment Match", "Match each retail tool with its use."], ["Sequence Connector Match", "Match each connector with its Indonesian meaning."]],
    },
  } as const;
  const moduleCopy = practiceCopy[lang][id as 1 | 2 | 3][stage - 1];

  function computeActivityScore(): ActivityResult {
    if (isSequence && practice.type === "sequence") {
      const total = practice.answer.length;
      const correct = practice.answer.filter((item, i) => order[i] === item).length;
      return { score: total > 0 ? Math.round((correct / total) * 10) : 0, correct, total, completed: true };
    } else if (matching) {
      const total = matching.left.length;
      const correct = matching.left.filter(l => pairs[l] === matching.pairs[l]).length;
      return { score: total > 0 ? Math.round((correct / total) * 10) : 0, correct, total, completed: true };
    }
    return { score: 0, correct: 0, total: 0, completed: false };
  }

  function handleCta() {
    if (!checked) {
      const actScore = computeActivityScore();
      const newScores = [...activityScores];
      newScores[stage - 1] = actScore;
      setActivityScores(newScores);
      savePracticeActivity(id, stage - 1, actScore);
      setChecked(true);
      return;
    }
    if (stage === modulePractices.length) {
      updateModPct(id, 80, "Post-test", `/module/${id}/posttest`);
      nav(`/module/${id}/posttest`);
      return;
    }
    const next = stage + 1;
    setStage(next);
    setSelectedLeft(undefined);
    setPairs({});
    setChecked(false);
    const nextP = modulePractices[next - 1];
    if (nextP.type === "sequence") setOrder([...nextP.items]);
  }

  function moveItem(index: number, direction: -1 | 1) {
    const nextIndex = index + direction;
    if (nextIndex < 0 || nextIndex >= order.length) return;
    setOrder(items => {
      const next = [...items];
      [next[index], next[nextIndex]] = [next[nextIndex], next[index]];
      return next;
    });
    setChecked(false);
  }

  function pairLeftWithRight(left: string, right: string) {
    if (!matching) return;
    setPairs(current => {
      const next = Object.fromEntries(Object.entries(current).filter(([l, pairedRight]) => l !== left && pairedRight !== right));
      next[left] = right;
      return next;
    });
    setSelectedLeft(undefined);
    setChecked(false);
    setDraggedLeft(undefined);
    setDragOverRight(undefined);
  }

  function chooseRight(right: string) {
    if (!selectedLeft) return;
    pairLeftWithRight(selectedLeft, right);
  }

  const canCheck = isSequence ? order.length > 0 : Boolean(matching && matching.left.every(left => pairs[left]));
  const currentScore = activityScores[stage - 1];

  return (
    <Shell title={t.startPractice}>
      <div className="page-title">
        <p className="eyebrow">{t.activityOf(stage, 3).toUpperCase()}</p>
        <h1>{moduleCopy[0]}</h1>
        <p>{moduleCopy[1]}</p>
      </div>
      <ProgressBar value={stage * 33} />

      {!isSequence && matching ? (
        <div className="match-grid practice-match-grid">
          <div>
            <p className="task-label">{lang === "id" ? "PILIH BAGIAN" : "CHOOSE A PART"}</p>
            {matching.left.map(left => {
              const paired = pairs[left];
              const correct = checked && paired === matching.pairs[left];
              const incorrect = checked && Boolean(paired) && !correct;
              return (
                <button
                  key={left}
                  className={["match-source", selectedLeft === left ? "selected" : "", draggedLeft === left ? "dragging" : "", correct ? "correct" : "", incorrect ? "incorrect" : ""].join(" ").trim()}
                  onClick={() => { setSelectedLeft(left); setChecked(false); }}
                  aria-pressed={selectedLeft === left}
                  draggable
                  onDragStart={(e) => {
                    setDraggedLeft(left);
                    setChecked(false);
                    e.dataTransfer.effectAllowed = "move";
                    e.dataTransfer.setData("text/plain", left);
                  }}
                  onDragEnd={() => {
                    setDraggedLeft(undefined);
                    setDragOverRight(undefined);
                  }}
                >
                  <div
                    className="drag-handle match-drag-handle"
                    onPointerDown={(e) => {
                      e.currentTarget.setPointerCapture(e.pointerId);
                      setDraggedLeft(left);
                      setChecked(false);
                    }}
                    onPointerMove={(e) => {
                      if (draggedLeft !== left) return;
                      e.preventDefault();
                      const el = document.elementFromPoint(e.clientX, e.clientY);
                      const targetEl = el?.closest("[data-match-target]");
                      if (targetEl) {
                        const rightVal = targetEl.getAttribute("data-match-target");
                        if (rightVal && dragOverRight !== rightVal) setDragOverRight(rightVal);
                      } else {
                        if (dragOverRight !== undefined) setDragOverRight(undefined);
                      }
                    }}
                    onPointerUp={(e) => {
                      e.currentTarget.releasePointerCapture(e.pointerId);
                      if (draggedLeft === left && dragOverRight) {
                        pairLeftWithRight(left, dragOverRight);
                      } else {
                        setDraggedLeft(undefined);
                        setDragOverRight(undefined);
                      }
                    }}
                    onPointerCancel={(e) => {
                      e.currentTarget.releasePointerCapture(e.pointerId);
                      setDraggedLeft(undefined);
                      setDragOverRight(undefined);
                    }}
                  >
                    <GripVertical size={16} />
                  </div>
                  <span><b>{left}</b>{paired && <small>{paired}</small>}</span>
                  {paired ? <Check size={17} /> : <ChevronRight size={17} />}
                </button>
              );
            })}
          </div>
          <div>
            <p className="task-label">{lang === "id" ? "PILIH PASANGAN" : "CHOOSE A MATCH"}</p>
            {matching.right.map(right => (
              <button
                key={right}
                className={`match-target${Object.values(pairs).includes(right) ? " paired" : ""}${dragOverRight === right ? " drag-over" : ""}`}
                onClick={() => chooseRight(right)}
                aria-disabled={!selectedLeft}
                data-match-target={right}
                onDragOver={(e) => {
                  e.preventDefault();
                  if (draggedLeft) {
                    e.dataTransfer.dropEffect = "move";
                    if (dragOverRight !== right) setDragOverRight(right);
                  }
                }}
                onDragLeave={() => {
                  if (dragOverRight === right) setDragOverRight(undefined);
                }}
                onDrop={(e) => {
                  e.preventDefault();
                  const leftData = e.dataTransfer.getData("text/plain");
                  if (leftData && matching?.left.includes(leftData)) {
                    pairLeftWithRight(leftData, right);
                  }
                }}
              >
                <span>{right}</span>
              </button>
            ))}
          </div>
        </div>
      ) : (
        <div className="sequence">
          <p className="sequence-help">{t.sequenceHelp}</p>
          {order.map((x, i) => (
            <div className={`seq-row${checked ? (isCorrect ? " correct" : " incorrect") : ""}`} key={x}>
              <div className="seq-item">
                <GripVertical size={18} className="drag-handle" />
                <b>{i + 1}</b>
                <span>{x}</span>
              </div>
              <div className="sequence-controls">
                <button onClick={() => moveItem(i, -1)} disabled={i === 0} aria-label={t.moveUp(x)}><ChevronUp size={17} /></button>
                <button onClick={() => moveItem(i, 1)} disabled={i === order.length - 1} aria-label={t.moveDown(x)}><ChevronDown size={17} /></button>
              </div>
            </div>
          ))}
        </div>
      )}

      {checked && (
        <div className={`feedback ${isCorrect ? "good" : "bad"}`}>
          {isCorrect ? <Check size={22} /> : <AlertTriangle size={22} />}
          <div>
            <b>{isCorrect ? t.greatJob : (currentScore && currentScore.score > 0 ? t.partialCredit : t.notQuiteYet)}</b>
            <p>
              {isCorrect ? t.thatCorrect : t.reviewSentence}
              {currentScore && ` · ${currentScore.score.toFixed(1)}/10`}
            </p>
          </div>
        </div>
      )}

      <Button disabled={!canCheck} onClick={handleCta}>
        {checked ? t.continueBtn : t.checkAnswer} <ArrowRight size={18} />
      </Button>
    </Shell>
  );
}

// ─── Final result ─────────────────────────────────────────────────────────────
function FinalResult() {
  const nav = useNavigate();
  const { t } = useLang();
  const id = Number(useLocation().pathname.split("/")[2]) || 1;
  const { gs, finalizePosttest, retryModule } = useGlobalState();
  const [animating, setAnimating] = useState(true);
  const modState = gs.mods[id];

  useEffect(() => {
    if (!modState?.posttestResult) {
      try {
        const answers: (number | undefined)[] = JSON.parse(localStorage.getItem(`evp-post-answers-m${id}`) || "[]");
        const questions = moduleContent(id).posttest;
        const result = calculateQuizScore(questions, answers);
        const weighted = Math.round((result.correct / questions.length) * 70 * 10) / 10;
        finalizePosttest(id, { raw: result.percentage, weighted, correct: result.correct, incorrect: result.incorrect });
      } catch {
        finalizePosttest(id, { raw: 0, weighted: 0, correct: 0, incorrect: 0 });
      }
    }
    const timer = setTimeout(() => setAnimating(false), 900);
    return () => clearTimeout(timer);
  }, [id]);

  const pretestScore = modState?.pretestResult?.score ?? 0;
  const posttestRaw = modState?.posttestResult?.raw ?? 0;
  const posttestWeighted = modState?.posttestResult?.weighted ?? 0;
  const practiceScore = modState?.practiceScore ?? 0;
  const finalScore = modState?.finalScore ?? Math.round(posttestWeighted + practiceScore);
  const gain = posttestRaw - pretestScore;
  const passed = finalScore >= PASSING_THRESHOLD;
  const latestScore = modState?.latestScore ?? finalScore;
  const bestScore = modState?.bestScore ?? finalScore;

  return (
    <Shell title={t.moduleResult}>
      <section className="final-hero">
        <div className={`score-ring ${passed ? "pass" : "warn"} ${animating ? "animating" : ""}`}>
          <div>
            <b>{finalScore}</b>
            <span>/100</span>
          </div>
        </div>
        <div>
          <span className={`result-badge ${passed ? "pass" : "warn"}`}>
            {passed ? <><Check size={14} /> {t.tuntas}</> : <><AlertTriangle size={14} /> {t.perluReview}</>}
          </span>
          <h1>{passed ? t.excellentProgress : t.tetapSemangat}</h1>
          <p>{passed ? t.completedModule : t.reviewRecommended}</p>
        </div>
      </section>

      <section className="gain">
        <div><small>{t.pretestLabel}</small><b>{pretestScore}</b></div>
        <ArrowRight size={16} style={{ color: "#94a3b8", flex: "none" }} />
        <div><small>Post-test</small><b>{posttestRaw}</b></div>
        <div className="gain-badge">{gain >= 0 ? "+" : ""}{gain} {t.improvement}</div>
      </section>

      <section className="breakdown">
        <h2>{t.yourResult}</h2>
        {[
          [t.pretestLabel, `${pretestScore} / 100`],
          [t.posttestRaw, `${posttestRaw} / 100`],
          [t.posttestWeighted, `${posttestWeighted.toFixed(1)} / 70`],
          [t.practice, `${practiceScore.toFixed(1)} / 30`],
          [t.finalScore, `${finalScore} / 100`],
        ].map(([a, b]) => <div key={a as string}><span>{a}</span><b>{b}</b></div>)}
      </section>

      <div className="score-meta">
        <div><small>{t.latestScore}</small><b>{latestScore}</b></div>
        <div><small>{t.bestScore}</small><b>{bestScore}</b></div>
      </div>

      <Button onClick={() => nav(`/module/${id}/theory`)}>{t.reviewMaterial}</Button>
      <Button variant="secondary" onClick={() => { retryModule(id); nav(`/module/${id}/objectives`); }}>{t.tryAgain}</Button>
      <Button variant="text" onClick={() => nav("/home")}>{t.backToModules}</Button>
    </Shell>
  );
}

// ─── Progress page ────────────────────────────────────────────────────────────
function ProgressPage() {
  const nav = useNavigate();
  const { t } = useLang();
  const { gs } = useGlobalState();
  const mods = gs.mods;
  const pcts = [mods[1]?.pct ?? 0, mods[2]?.pct ?? 0, mods[3]?.pct ?? 0];
  const completed = pcts.filter(v => v >= 100).length;
  const overall = Math.round(pcts.reduce((s, v) => s + v, 0) / 3);
  const empty = pcts.every(v => v === 0);

  return (
    <Shell back={false} title={t.navProgress}>
      <div className="page-title">
        <h1>{t.yourProgress}</h1>
        <p>{empty ? t.noProgressYet : ""}</p>
      </div>

      {empty ? (
        <div className="empty">
          <div><Target size={34} /></div>
          <h2>{t.notStartedYet}</h2>
          <p>{t.noProgressYet}</p>
          <Button onClick={() => nav("/modules")}>{t.startLearning}</Button>
        </div>
      ) : (
        <>
          <section className="overall">
            <span>{t.overallProgress.toUpperCase()}</span>
            <h2>{t.modulesCompletedOf(completed)}</h2>
            <b>{overall}%</b>
            <ProgressBar value={overall} />
          </section>

          <div className="progress-modules" style={{ marginTop: 24 }}>
            {modules.map(m => {
              const prog = mods[m.id]?.pct ?? 0;
              const modData = mods[m.id];
              const score = modData?.latestScore;
              const status = prog >= 100 ? "done" : prog > 0 ? "active" : "idle";
              const statusLabel = prog >= 100 ? t.completed : prog > 0 ? t.inProgress : t.notStarted;
              const I = m.icon;
              return (
                <button key={m.id} className="progress-mod-card" onClick={() => nav(`/module/${m.id}`)}>
                  <div className="pm-icon" style={{ background: m.tint, color: m.accent }}><I size={20} /></div>
                  <div className="pm-info">
                    <p className="pm-label">Module 0{m.id} · {m.title}</p>
                    <p className={`pm-status ${status}`}>
                      {status === "done" ? <Check size={13} /> : status === "active" ? <CircleDot size={13} /> : <span className="pm-dot" />}
                      {statusLabel}
                    </p>
                    {prog > 0 && prog < 100 && <ProgressBar value={prog} color={m.accent} />}
                  </div>
                  <div className="pm-right">
                    {prog >= 100 && score != null ? <b className="pm-score">{score}</b> : prog > 0 ? <em className="pm-pct">{prog}%</em> : <ChevronRight size={17} style={{ color: "#94a3b8" }} />}
                  </div>
                </button>
              );
            })}
          </div>
        </>
      )}
    </Shell>
  );
}

// ─── Guide page ───────────────────────────────────────────────────────────────
function GuidePage() {
  const { t } = useLang();
  return (
    <Shell title={t.howToUse}>
      <div className="page-title">
        <h1>{t.guideTitle}</h1>
        <p>{t.guideSub}</p>
      </div>
      <div className="simple-list">
        {t.guideItems.map((x, i) => <article key={x}><b>0{i + 1}</b><p>{x}</p></article>)}
      </div>
    </Shell>
  );
}

// ─── Outcomes page ────────────────────────────────────────────────────────────
function OutcomesPage() {
  const { t } = useLang();
  return (
    <Shell title={t.learningOutcomes}>
      <div className="page-title">
        <h1>{t.outcomesTitle}</h1>
        <p>{t.outcomesSub}</p>
      </div>
      <div className="metadata-card"><span>Kurikulum Merdeka</span><span>Phase E</span><span>Reading–Viewing</span></div>
      <div className="simple-list">
        {t.outcomesItems.map((x, i) => <article key={x}><b>0{i + 1}</b><p>{x}</p></article>)}
      </div>
    </Shell>
  );
}

// ─── Profile page ─────────────────────────────────────────────────────────────
function ProfilePage() {
  const { t } = useLang();
  const f = t.profileFields;
  const rows: [string, string][] = [
    [f.nama, "AFRIDA DWI RAHMAWATI"],
    [f.nim, "805230006"],
    [f.prodi, "Tadris Bahasa Inggris"],
    [f.fakultas, "Pascasarjana"],
    [f.universitas, "Universitas Islam Negeri Sulthan Thaha Saifuddin Jambi"],
    [f.pembimbing, "1. Prof. Dr. Martinis, M.Pd\n2. Tartila, M.Pd, Ed.D"],
    [f.judul, "The development of Android-based Teaching Materials in English Language Learning for Vocational High Schools"],
    [f.tahun, "2026"],
  ];
  return (
    <Shell back={false} title={t.navProfile}>
      <div className="profile-header">
        <div className="profile-avatar-large"><UserRound size={44} /></div>
        <h1>{t.profileTitle}</h1>
        <p>{t.profileSub}</p>
      </div>
      <div className="profile-fields">
        {rows.map(([label, value]) => (
          <div key={label} className="profile-field">
            <span className="pf-label">{label}</span>
            <span className="pf-value">{value}</span>
          </div>
        ))}
      </div>
    </Shell>
  );
}

// ─── Splash ───────────────────────────────────────────────────────────────────
function Splash() {
  const nav = useNavigate();
  useEffect(() => { const timer = setTimeout(() => nav("/home"), 1200); return () => clearTimeout(timer); }, [nav]);
  return (
    <div className="splash">
      <div className="splash-icon"><img src={logo} alt="EVP Learn" /></div>
      <p>ENGLISH FOR VOCATIONAL PURPOSES</p>
      <h1>EVP<br />Learn</h1>
      <span>Learning for the world of retail</span>
      <i />
    </div>
  );
}

// ─── Router ───────────────────────────────────────────────────────────────────
const router = createBrowserRouter([
  { path: "/", Component: Splash },
  { path: "/home", Component: HomePage },
  { path: "/modules", Component: ModulesPage },
  { path: "/module/:id", Component: Overview },
  { path: "/module/:id/objectives", Component: Objectives },
  { path: "/module/:id/pretest", Component: () => <AssessmentIntro /> },
  { path: "/module/:id/prequiz", Component: Quiz },
  { path: "/module/:id/presubmit", Component: SubmitConfirm },
  { path: "/module/:id/preresult", Component: PreResult },
  { path: "/module/:id/theory", Component: Theory },
  { path: "/module/:id/vocabulary", Component: Vocabulary },
  { path: "/module/:id/reading", Component: Reading },
  { path: "/module/:id/practice", Component: Practice },
  { path: "/module/:id/posttest", Component: () => <AssessmentIntro post /> },
  { path: "/module/:id/postquiz", Component: () => <Quiz post /> },
  { path: "/module/:id/postsubmit", Component: () => <SubmitConfirm post /> },
  { path: "/module/:id/postresult", Component: FinalResult },
  { path: "/progress", Component: ProgressPage },
  { path: "/guide", Component: GuidePage },
  { path: "/outcomes", Component: OutcomesPage },
  { path: "/profile", Component: ProfilePage },
]);

export default function App() {
  return (
    <LangProvider>
      <StateProvider>
        <RouterProvider router={router} />
      </StateProvider>
    </LangProvider>
  );
}
