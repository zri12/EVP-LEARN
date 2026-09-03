// ============================================================
// EVP Learn — Academic Data Module
// Source: MATERI AFRIDA.docx (Canonical)
// Pre-test: PROTOTYPE / DIAGNOSTIC
// Post-test: PROTOTYPE (Derived strictly from MATERI AFRIDA.docx)
// ============================================================

export const PASSING_THRESHOLD = 75;

// ─── Types ───────────────────────────────────────────────────────────────────

export type Question = {
  prompt: string;
  options: string[];
  answer: number; // 0-indexed correct option
  feedback?: string;
  assessmentStatus?: "prototype" | "final"; // Internal marker
};

export type Word = {
  word: string;
  pos: string;
  meaning: string;
};

export type Practice =
  | {
      type: "match" | "tapMatch";
      title: string;
      instruction: string;
      left: string[];
      right: string[];
      pairs: Record<string, string>;
    }
  | {
      type: "sequence";
      title: string;
      instruction: string;
      items: string[];
      answer: string[];
    };

export type IllustrationKind = "furniture" | "pos" | "shelving" | "jacket" | "checkout";

export type Reading = {
  title: string;
  subtitle: string;
  visual: IllustrationKind;
  sections: { heading: string; body: string; highlights: string[] }[];
  glossary: Word[];
};

export type Module = {
  id: number;
  title: string;
  subtitle: string;
  accent: string;
  tint: string;
  overview: string;
  objectives: string[];
  theory: {
    definition: string;
    structure: string[];
    features: string[];
  };
  vocabularyPreview: Word[];
  readings: Reading[];
  pretest: Question[];
  posttest: Question[];
  practices: Practice[];
};

// ─── Helpers ─────────────────────────────────────────────────────────────────

const w = (word: string, pos: string, meaning: string): Word => ({ word, pos, meaning });

export const readingGlossaryFor = (reading: Reading): Record<string, Word> =>
  Object.fromEntries(reading.glossary.map((item) => [item.word.toLowerCase(), item]));

export const glossaryFor = (module: Module): Record<string, Word> =>
  Object.fromEntries(
    module.readings.flatMap((r) => r.glossary).map((item) => [item.word.toLowerCase(), item])
  );

// ─── Module Data ─────────────────────────────────────────────────────────────

export const MODULES: Record<number, Module> = {

  // ══════════════════════════════════════════════════════════════════
  // MODULE 1 — NARRATIVE TEXT
  // ══════════════════════════════════════════════════════════════════
  1: {
    id: 1,
    title: "Narrative Text",
    subtitle: "Inspirational Business Stories",
    accent: "#2563eb",
    tint: "#eff6ff",
    overview:
      "Narrative Text is a text that tells a story of connected events. In retail, it focuses on inspirational business origins, retail brand histories, and entrepreneurship challenges to entertain and inspire readers.",
    objectives: [
      "Mengidentifikasi fungsi sosial teks berkaitan retail.",
      "Mengenali struktur generik dan ciri kebahasaan.",
      "Memahami ide pokok dan informasi rinci.",
      "Menggunakan kosakata retail dalam konteks bermakna.",
    ],
    theory: {
      definition:
        "Narrative Text is a text that tells a story of connected events. In retail, it focuses on inspirational business origins, retail brand histories, and entrepreneurship challenges to entertain and inspire readers.",
      structure: [
        "Orientation — Introduces the business founder, setting, and starting time.",
        "Complication — Describes the main business problem, crisis, or challenge faced.",
        "Resolution — Explains how the founder solved the problem creatively.",
        "Re-orientation — Shows the final success and the moral lesson of the story.",
      ],
      features: [
        "Simple Past Tense (e.g., founded, struggled, invented, launched).",
        "Action Verbs (e.g., sold, built, shipped, produced).",
        "Time Connectives (e.g., long ago, at first, suddenly, finally).",
      ],
    },
    vocabularyPreview: [
      w("Founder", "noun", "Pendiri bisnis."),
      w("Venture", "noun", "Usaha/bisnis baru berrisiko."),
      w("Crisis", "noun", "Krisis/masalah besar."),
      w("Breakthrough", "noun", "Inovasi/penemuan penting."),
      w("Retailer", "noun", "Pengecer."),
    ],
    readings: [
      {
        title: "THE STORY OF IKEA",
        subtitle: "Innovation in Furniture Retail",
        visual: "furniture",
        sections: [
          {
            heading: "ORIENTATION",
            body: "Long ago in 1943, a 17-year-old boy named Ingvar Kamprad founded a small mail-order business in Sweden. He named it IKEA, using his initials (I.K.) plus the first letters of Elmtaryd and Agunnaryd, the farm and village where he grew up. At first, he sold small household items like pens, wallets, and picture frames.",
            highlights: [],
          },
          {
            heading: "COMPLICATION",
            body: "As IKEA grew and began selling affordable furniture, local traditional furniture store owners became furious. They pressured suppliers to BOYCOTT Kamprad, preventing him from receiving pre-assembled furniture. Furthermore, shipping large wooden tables and sofas was extremely EXPENSIVE and often resulted in damaged goods during DELIVERY. Kamprad faced a major crisis that threatened to close his growing business.",
            highlights: ["boycott", "delivery"],
          },
          {
            heading: "RESOLUTION",
            body: "Instead of giving up, Kamprad and his designer came up with a REVOLUTIONARY idea: \"FLAT-PACKING.\" They decided to disassemble a table by taking off its legs so it could fit into a flat box. Customers would buy the boxed furniture and ASSEMBLE it themselves at home. This innovation drastically reduced shipping costs, saved store warehouse space, and allowed IKEA to sell high-quality furniture at unbelievably low prices.",
            highlights: ["revolutionary", "flat-packing", "assemble"],
          },
          {
            heading: "RE-ORIENTATION",
            body: "Today, IKEA has grown into the world's largest furniture RETAILER with hundreds of stores worldwide. Ingvar Kamprad proved that facing business challenges with creativity and customer-focused solutions can turn a local struggle into a global success story.",
            highlights: ["retailer"],
          },
        ],
        glossary: [
          w("Boycott",       "verb",        "Memboikot / menolak kerja sama"),
          w("Delivery",      "noun",        "Pengiriman barang"),
          w("Revolutionary", "adjective",   "Sangat inovatif / mengubah keadaan"),
          w("Flat-packing",  "noun phrase", "Pengemasan barang secara pipih/dUS"),
          w("Assemble",      "verb",        "Merakit / menyusun bagian produk"),
          w("Retailer",      "noun",        "Pengecer / pengusaha retail"),
        ],
      },
    ],
    pretest: [
      {
        assessmentStatus: "prototype",
        prompt: "What is the main purpose of Narrative Text in retail context?",
        options: [
          "To describe product specifications",
          "To give step-by-step checkout instructions",
          "To focus on inspirational business origins and brand histories",
          "To complain about broken items"
        ],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which part of Narrative Text introduces the founder and setting?",
        options: ["Orientation", "Complication", "Resolution", "Re-orientation"],
        answer: 0,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What does the 'Complication' section describe?",
        options: [
          "The final success of the story",
          "The main business problem, crisis, or challenge",
          "The time and place of the story",
          "The step-by-step manual"
        ],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What tense is commonly used in Narrative Text?",
        options: ["Simple Present Tense", "Simple Future Tense", "Present Continuous Tense", "Simple Past Tense"],
        answer: 3,
      },
      {
        assessmentStatus: "prototype",
        prompt: "The word 'founded' is an example of...",
        options: ["Noun Phrase", "Simple Past Tense verb", "Time Connective", "Adjective"],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What does 'Founder' mean in Indonesian?",
        options: ["Pendiri bisnis", "Pengecer", "Pembeli", "Karyawan toko"],
        answer: 0,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which of the following is a Time Connective?",
        options: ["Sold", "Long ago", "Retailer", "Venture"],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Where did Ingvar Kamprad grow up?",
        options: ["America", "England", "Sweden", "Germany"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What items did IKEA sell at first?",
        options: ["Flat-pack sofas", "Large wooden tables", "Computers and phones", "Pens, wallets, and picture frames"],
        answer: 3,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What is the Indonesian meaning of 'Retailer'?",
        options: ["Pabrik", "Grosir", "Pengecer", "Distributor"],
        answer: 2,
      },
    ],
    posttest: [
      {
        assessmentStatus: "prototype",
        prompt: "According to the reading, when did Ingvar Kamprad found IKEA?",
        options: ["1950", "1943", "1956", "1934"],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What complication did IKEA face as it began selling affordable furniture?",
        options: [
          "They ran out of materials to make pens",
          "They could not find any customers in Sweden",
          "Suppliers were pressured to boycott Kamprad",
          "Customers did not know how to assemble tables"
        ],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Why did Kamprad face a major crisis with shipping?",
        options: [
          "Large tables were expensive to ship and often damaged during delivery",
          "Customers refused to pay for delivery",
          "The mail-order system broke down",
          "He could not find enough delivery drivers"
        ],
        answer: 0,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What revolutionary idea did Kamprad and his designer invent?",
        options: ["Online shopping", "Free home delivery", "Flat-packing", "Selling only picture frames"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What did flat-packing allow customers to do?",
        options: [
          "Buy the boxed furniture and assemble it themselves at home",
          "Order furniture over the telephone",
          "Pay for furniture in monthly installments",
          "Design their own furniture online"
        ],
        answer: 0,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What was one major benefit of the flat-packing innovation for IKEA?",
        options: [
          "It made the furniture heavier",
          "It drastically reduced shipping costs",
          "It increased the store warehouse space needed",
          "It made traditional store owners happy"
        ],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "In the Re-orientation paragraph, what has IKEA become today?",
        options: [
          "A small mail-order business",
          "A local Swedish grocery store",
          "The world's largest furniture retailer",
          "A supplier of wood and paint"
        ],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What does the word 'Assemble' mean?",
        options: ["Mengirim barang", "Merakit / menyusun bagian produk", "Memboikot kerja sama", "Mengemas barang secara pipih"],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which sentence uses the Simple Past Tense correctly?",
        options: [
          "Ingvar Kamprad founds a small business.",
          "Ingvar Kamprad founded a small mail-order business.",
          "Ingvar Kamprad is founding a small business.",
          "Ingvar Kamprad will found a small business."
        ],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Based on the text, what moral lesson can be learned from the IKEA story?",
        options: [
          "Creativity and customer-focused solutions can turn a struggle into global success",
          "Never start a business when you are 17 years old",
          "Always agree with traditional store owners",
          "Furniture should always be pre-assembled by the seller"
        ],
        answer: 0,
      },
    ],
    practices: [
      {
        type: "match",
        title: "Structure Match",
        instruction: "Match each narrative part with its purpose.",
        left: ["Orientation", "Complication", "Resolution", "Re-orientation"],
        right: [
          "Shows the final success and the moral lesson",
          "Introduces the business founder and setting",
          "Explains how the founder solved the problem creatively",
          "Describes the main business problem or crisis",
        ],
        pairs: {
          "Orientation":    "Introduces the business founder and setting",
          "Complication":   "Describes the main business problem or crisis",
          "Resolution":     "Explains how the founder solved the problem creatively",
          "Re-orientation": "Shows the final success and the moral lesson",
        },
      },
      {
        type: "tapMatch",
        title: "Vocabulary Match",
        instruction: "Match each word with its Indonesian meaning.",
        left: ["Boycott", "Flat-packing", "Assemble", "Delivery"],
        right: [
          "Merakit / menyusun bagian produk",
          "Pengiriman barang",
          "Memboikot / menolak kerja sama",
          "Pengemasan barang secara pipih/dUS",
        ],
        pairs: {
          "Boycott":      "Memboikot / menolak kerja sama",
          "Flat-packing": "Pengemasan barang secara pipih/dUS",
          "Assemble":     "Merakit / menyusun bagian produk",
          "Delivery":     "Pengiriman barang",
        },
      },
      {
        type: "sequence",
        title: "IKEA Event Sequence",
        instruction: "Arrange the IKEA story events from first to last.",
        items: [
          "IKEA became the world's largest furniture retailer",
          "IKEA began selling affordable furniture",
          "Flat-packing was invented",
          "Ingvar Kamprad founded a small mail-order business",
          "Suppliers boycotted Kamprad",
        ],
        answer: [
          "Ingvar Kamprad founded a small mail-order business",
          "IKEA began selling affordable furniture",
          "Suppliers boycotted Kamprad",
          "Flat-packing was invented",
          "IKEA became the world's largest furniture retailer",
        ],
      },
    ],
  },

  // ══════════════════════════════════════════════════════════════════
  // MODULE 2 — DESCRIPTIVE TEXT
  // ══════════════════════════════════════════════════════════════════
  2: {
    id: 2,
    title: "Descriptive Text",
    subtitle: "Retail Products & Store Fixtures",
    accent: "#7c3aed",
    tint: "#f5f3ff",
    overview:
      "Descriptive Text is a text that describes a specific object, place, or item in detail. In retail, it is used to describe merchandise specifications, store fixtures, and product selling points.",
    objectives: [
      "Mengidentifikasi fungsi sosial teks berkaitan retail.",
      "Mengenali struktur generik dan ciri kebahasaan.",
      "Memahami ide pokok dan informasi rinci.",
      "Menggunakan kosakata retail dalam konteks bermakna.",
    ],
    theory: {
      definition:
        "Descriptive Text is a text that describes a specific object, place, or item in detail. In retail, it is used to describe merchandise specifications, store fixtures, and product selling points.",
      structure: [
        "Identification — Introduces the retail product or store fixture being described.",
        "Description — Details the physical features, materials, size, colors, durability, and functions of the item.",
      ],
      features: [
        "Simple Present Tense (e.g., features, includes, measures, contains).",
        "Adjectives of Quality & Appearance (e.g., durable, sleek, ergonomic, sturdy).",
        "Noun Phrases (e.g., heavy-duty shelving, dual-screen terminal).",
      ],
    },
    vocabularyPreview: [
      w("Merchandise", "noun",      "Barang dagangan."),
      w("Durable",     "adjective", "Tahan lama / awet."),
      w("Adjustable",  "adjective", "Dapat disesuaikan tingginya/ukurannya."),
      w("Display",     "noun/verb", "Penataan/pajangan barang."),
      w("Sleek",       "adjective", "Halus, modern, dan elegan."),
    ],
    readings: [
      {
        title: "Modern Touchscreen POS Terminal",
        subtitle: "Retail Hardware / POS System",
        visual: "pos",
        sections: [
          {
            heading: "IDENTIFICATION & DESCRIPTION",
            body: "The OmniTouch 500 is a modern touchscreen POS terminal designed for fast-paced retail stores. It features a sleek black casing made of high-impact ABS plastic and a 15.6-inch dual-screen display that allows both cashiers and customers to view transactions simultaneously. At the top of the main unit, there is an integrated thermal receipt printer that operates quietly and at high speed. Supported by a sturdy metallic stand with a rust-resistant finish, this device ensures smooth checkout operations while maintaining an elegant aesthetic on the cashier counter.",
            highlights: ["casing", "dual-screen display", "integrated", "sturdy", "finish"],
          },
        ],
        glossary: [
          w("Casing",              "noun",        "Wadah / pelindung luar perangkat."),
          w("Dual-screen display", "noun phrase", "Layar ganda (layar untuk kasir dan layar pembeli)."),
          w("Integrated",          "adjective",   "Menyatu / terintegrasi menjadi satu unit."),
          w("Sturdy",              "adjective",   "Kokoh / kuat / tidak mudah goyah."),
          w("Finish",              "noun",        "Lapisan akhir permukaan bahan (misal: anti karat/matte)."),
        ],
      },
      {
        title: "Heavy-Duty Supermarket Gondola Shelving",
        subtitle: "Store Fixtures & Display",
        visual: "shelving",
        sections: [
          {
            heading: "IDENTIFICATION & DESCRIPTION",
            body: "This heavy-duty gondola shelving unit is built specifically for organizing supermarket merchandise efficiently. Standing 2 meters tall, it consists of five adjustable steel shelves painted in a durable matte white powder coating. Each shelf is engineered to support up to 100 kilograms of goods, making it ideal for heavy food packaging and household cleaning items. Its open-front design provides high product visibility, allowing shoppers to easily locate and reach items while maximizing aisle space.",
            highlights: ["gondola shelving", "adjustable", "durable", "open-front", "visibility"],
          },
        ],
        glossary: [
          w("Gondola shelving", "noun phrase", "Rak display dua sisi/satu sisi yang biasa digunakan di supermarket/minimarket."),
          w("Adjustable",       "adjective",   "Dapat disesuaikan (ketinggian/posisinya)."),
          w("Durable",          "adjective",   "Tahan lama / awet / tidak mudah rusak."),
          w("Open-front",       "adjective",   "Berdesain terbuka bagian depan."),
          w("Visibility",       "noun",        "Tingkat keterlihatan produk oleh pelanggan."),
        ],
      },
      {
        title: "Vintage Leather Biker Jacket",
        subtitle: "Fashion & Merchandise Display",
        visual: "jacket",
        sections: [
          {
            heading: "IDENTIFICATION & DESCRIPTION",
            body: "The Urban Rider Jacket is a classic black biker-style leather jacket crafted for front-window retail display. Made from premium genuine cowhide leather, it features a smooth texture with a subtle natural shine. The jacket includes asymmetrical silver zippers, a snap-button collar, and an adjustable waist belt for a custom fit. Its bold design and high-quality craftsmanship make it an eye-catching centerpiece that attracts potential fashion shoppers into the store.",
            highlights: ["premium", "asymmetrical", "adjustable", "eye-catching", "centerpiece"],
          },
        ],
        glossary: [
          w("Premium",      "adjective", "Berkualitas tinggi / bermutu super."),
          w("Asymmetrical", "adjective", "Tidak simetris (desain ritsleting miring khas jaket biker)."),
          w("Adjustable",   "adjective", "Dapat diatur (ukuran lingkar pinggangnya)."),
          w("Eye-catching", "adjective", "Menarik perhatian / mencolok untuk dilihat."),
          w("Centerpiece",  "noun",      "Produk utama yang menjadi pusat perhatian tampilan display window toko."),
        ],
      },
    ],
    pretest: [
      {
        assessmentStatus: "prototype",
        prompt: "What is the primary function of Descriptive Text?",
        options: [
          "To tell a story from the past",
          "To give step-by-step instructions",
          "To describe a specific object, place, or item in detail",
          "To persuade customers to buy a product"
        ],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which part of Descriptive Text introduces the product being described?",
        options: ["Description", "Resolution", "Identification", "Orientation"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "The 'Description' section of the text usually details...",
        options: [
          "The step-by-step procedure",
          "The physical features, materials, size, and colors",
          "The company's history",
          "The moral value of the product"
        ],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What tense is used in Descriptive Text?",
        options: ["Simple Past Tense", "Simple Future Tense", "Present Perfect Tense", "Simple Present Tense"],
        answer: 3,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which of the following is an Adjective of Quality & Appearance?",
        options: ["Shelving", "Terminal", "Sleek", "Cashier"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What does the word 'Merchandise' mean in Indonesian?",
        options: ["Rak toko", "Barang dagangan", "Kasir", "Mesin EDC"],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "The phrase 'heavy-duty shelving' is an example of...",
        options: ["A Verb Phrase", "An Adverb", "A Noun Phrase", "A Preposition"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What does 'Durable' mean?",
        options: ["Mudah rusak", "Halus dan elegan", "Tahan lama / awet", "Sangat murah"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which of the following describes the POS Terminal's casing?",
        options: ["Made of wood", "Sleek black casing made of ABS plastic", "Painted in white powder coating", "Made from genuine cowhide leather"],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which word means 'Penataan/pajangan barang'?",
        options: ["Sleek", "Adjustable", "Display", "Merchandise"],
        answer: 2,
      },
    ],
    posttest: [
      {
        assessmentStatus: "prototype",
        prompt: "What is the OmniTouch 500 designed for?",
        options: ["Making coffee", "Fast-paced retail stores", "Organizing heavy food packaging", "Front-window fashion display"],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What allows both cashiers and customers to view transactions on the POS terminal?",
        options: ["A thermal receipt printer", "A sturdy metallic stand", "A 15.6-inch dual-screen display", "A sleek black casing"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What does the word 'Integrated' mean in the context of the POS terminal?",
        options: ["Menyatu / terintegrasi menjadi satu unit", "Berdesain terbuka bagian depan", "Kokoh / kuat / tidak mudah goyah", "Layar ganda"],
        answer: 0,
      },
      {
        assessmentStatus: "prototype",
        prompt: "How tall is the Heavy-Duty Supermarket Gondola Shelving?",
        options: ["1 meter tall", "2 meters tall", "3 meters tall", "5 meters tall"],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "How much weight is each shelf of the Gondola Shelving engineered to support?",
        options: ["Up to 10 kilograms", "Up to 50 kilograms", "Up to 100 kilograms", "Up to 200 kilograms"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What is the benefit of the 'open-front design' of the shelving unit?",
        options: [
          "It hides the products from view",
          "It provides high product visibility",
          "It makes the shelf lighter",
          "It prints thermal receipts quickly"
        ],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What material is the Urban Rider Jacket made from?",
        options: ["ABS plastic", "Matte white powder coating", "Premium genuine cowhide leather", "Steel shelves"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which feature of the jacket provides a 'custom fit'?",
        options: ["Asymmetrical silver zippers", "Snap-button collar", "Quilted inner lining", "Adjustable waist belt"],
        answer: 3,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What does 'Eye-catching' mean in Indonesian?",
        options: ["Produk utama", "Menarik perhatian / mencolok untuk dilihat", "Berkualitas tinggi", "Tidak simetris"],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "The phrase 'smooth texture with a subtle natural shine' is an example of...",
        options: ["Identification", "Description", "Orientation", "Complication"],
        answer: 1,
      },
    ],
    practices: [
      {
        type: "match",
        title: "Product Feature Match",
        instruction: "Match each feature with the correct retail product.",
        left: ["Dual-screen display", "Adjustable steel shelves", "Asymmetrical silver zippers"],
        right: ["Vintage Leather Biker Jacket", "Modern Touchscreen POS Terminal", "Heavy-Duty Gondola Shelving"],
        pairs: {
          "Dual-screen display":         "Modern Touchscreen POS Terminal",
          "Adjustable steel shelves":    "Heavy-Duty Gondola Shelving",
          "Asymmetrical silver zippers": "Vintage Leather Biker Jacket",
        },
      },
      {
        type: "tapMatch",
        title: "Descriptive Vocabulary",
        instruction: "Match each word with its Indonesian meaning.",
        left: ["Durable", "Sturdy", "Eye-catching"],
        right: ["Kokoh / kuat", "Tahan lama / awet", "Menarik perhatian"],
        pairs: {
          "Durable":      "Tahan lama / awet",
          "Sturdy":       "Kokoh / kuat",
          "Eye-catching": "Menarik perhatian",
        },
      },
      {
        type: "match",
        title: "Text Structure Sort",
        instruction: "Classify each sentence as Identification or Description.",
        left: [
          "The OmniTouch 500 is a modern touchscreen POS terminal.",
          "It features a sleek black casing made of ABS plastic.",
          "The Urban Rider Jacket is a classic black biker-style leather jacket.",
        ],
        right: [
          "Description — physical features",
          "Identification — POS",
          "Identification — jacket",
        ],
        pairs: {
          "The OmniTouch 500 is a modern touchscreen POS terminal.":    "Identification — POS",
          "It features a sleek black casing made of ABS plastic.":      "Description — physical features",
          "The Urban Rider Jacket is a classic black biker-style leather jacket.":"Identification — jacket",
        },
      },
    ],
  },

  // ══════════════════════════════════════════════════════════════════
  // MODULE 3 — PROCEDURE TEXT
  // ══════════════════════════════════════════════════════════════════
  3: {
    id: 3,
    title: "Procedure Text",
    subtitle: "Store Standard Operating Procedures",
    accent: "#0f766e",
    tint: "#f0fdfa",
    overview:
      "Procedure Text is a text that gives step-by-step instructions to achieve a specific goal. In retail, it covers store Standard Operating Procedures (SOPs), cash handling, merchandise display rules, and return processing.",
    objectives: [
      "Mengidentifikasi fungsi sosial teks berkaitan retail.",
      "Mengenali struktur generik dan ciri kebahasaan.",
      "Memahami ide pokok dan informasi rinci.",
      "Menggunakan kosakata retail dalam konteks bermakna.",
    ],
    theory: {
      definition:
        "Procedure Text is a text that gives step-by-step instructions to achieve a specific goal. In retail, it covers store Standard Operating Procedures (SOPs), cash handling, merchandise display rules, and return processing.",
      structure: [
        "Goal / Aim — States what is going to be achieved or done.",
        "Materials / Equipment — Lists tools or items needed to complete the steps.",
        "Steps / Methods — Sequential instructions on how to do the process.",
      ],
      features: [
        "Imperative Sentences / Action Verbs (e.g., greet, scan, press, verify, print).",
        "Sequence Adverbs (e.g., First, Next, Then, After that, Finally).",
        "Clear & Precise Directives (e.g., scan the barcode carefully).",
      ],
    },
    vocabularyPreview: [
      w("Scan",        "verb", "Memindai (barcode)."),
      w("Receipt",     "noun", "Struk belanja/bukti pembayaran."),
      w("Checkout",    "noun", "Area/proses pembayaran kasir."),
      w("Verify",      "verb", "Memeriksa/memastikan kebenaran data."),
      w("Cash Drawer", "noun", "Laci uang kasir."),
    ],
    readings: [
      {
        title: "HOW TO PROCESS CUSTOMER CHECKOUT USING A POS TERMINAL",
        subtitle: "Store Standard Operating Procedure",
        visual: "checkout",
        sections: [
          {
            heading: "GOAL / AIM",
            body: "To complete a retail sales transaction efficiently and accurately using a Point of Sale (POS) terminal.",
            highlights: [],
          },
          {
            heading: "MATERIALS / EQUIPMENT",
            body: "1. POS Terminal & Cash Drawer\n2. Barcode Scanner\n3. Thermal Receipt Paper\n4. Customer's Merchandise",
            highlights: [],
          },
          {
            heading: "STEPS / PROCEDURES",
            body: "1. FIRST, GREET the customer warmly and ask if they found everything they needed.\n\n2. NEXT, SCAN each item's barcode using the hand-held scanner. Ensure the scanner BEEPS to confirm the item is registered on the system screen.\n\n3. THEN, VERIFY the quantity and price of the merchandise displayed on the dual-screen monitor.\n\n4. AFTER THAT, ASK the customer for their preferred PAYMENT METHOD (cash, credit card, or QRIS digital payment).\n\n5. IF paying cash, INSERT the money into the cash drawer and ENTER the amount into the terminal to calculate change automatically.\n\n6. FINALLY, PRINT the receipt, ATTACH it to the shopping bag, and HAND over the items with a warm closing phrase like \"Thank you for shopping with us!\"",
            highlights: ["greet", "scan", "verify", "payment method", "insert", "attach"],
          },
        ],
        glossary: [
          w("Greet",          "verb (imperative)", "Menyapa"),
          w("Scan",           "verb (imperative)", "Memindai (barcode)"),
          w("Verify",         "verb (imperative)", "Memeriksa / memverifikasi"),
          w("Payment method", "noun phrase",       "Metode / cara pembayaran"),
          w("Insert",         "verb (imperative)", "Memasukkan"),
          w("Attach",         "verb (imperative)", "Melampirkan / menempelkan"),
        ],
      },
    ],
    pretest: [
      {
        assessmentStatus: "prototype",
        prompt: "What is a Procedure Text?",
        options: [
          "A text that tells a fictional story",
          "A text that gives step-by-step instructions to achieve a goal",
          "A text that describes a product's physical features",
          "A text that debates an issue"
        ],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which section lists the tools needed to complete the steps?",
        options: ["Goal / Aim", "Steps / Methods", "Materials / Equipment", "Orientation"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which of the following is a Sequence Adverb?",
        options: ["Finally", "Scan", "Receipt", "Cash Drawer"],
        answer: 0,
      },
      {
        assessmentStatus: "prototype",
        prompt: "An Imperative Sentence usually begins with...",
        options: ["A Noun", "An Adjective", "An Action Verb", "A Sequence Adverb"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What does 'Verify' mean?",
        options: ["Menyapa", "Memindai (barcode)", "Melampirkan", "Memeriksa/memastikan kebenaran data"],
        answer: 3,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What is the Indonesian term for 'Receipt'?",
        options: ["Laci uang", "Area kasir", "Struk belanja/bukti pembayaran", "Memindai barcode"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which is an example of a clear and precise directive?",
        options: ["Scan the barcode carefully", "It is very durable", "Long ago in 1943", "The jacket is black"],
        answer: 0,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Where does a procedure text usually state what is going to be achieved?",
        options: ["In the Steps section", "In the Goal/Aim section", "In the Materials section", "At the very end of the text"],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What is a 'Cash Drawer'?",
        options: ["Kertas termal", "Pemindai kode", "Laci uang kasir", "Keranjang belanja"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which of the following is NOT part of the Generic Structure of a Procedure Text?",
        options: ["Goal / Aim", "Complication", "Materials / Equipment", "Steps / Methods"],
        answer: 1,
      },
    ],
    posttest: [
      {
        assessmentStatus: "prototype",
        prompt: "What is the Goal/Aim of the provided procedure text?",
        options: [
          "To assemble flat-packing furniture at home",
          "To complete a retail sales transaction efficiently and accurately using a POS terminal",
          "To display vintage leather jackets in the front window",
          "To organize supermarket merchandise efficiently"
        ],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which of the following is NOT listed as Materials/Equipment in the text?",
        options: ["POS Terminal & Cash Drawer", "Barcode Scanner", "Shopping Trolley", "Thermal Receipt Paper"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "According to the procedure, what should the cashier do FIRST?",
        options: ["Scan the barcode", "Greet the customer warmly", "Verify the quantity and price", "Ask for the payment method"],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "How does the cashier ensure the item is registered on the system screen after scanning?",
        options: [
          "By printing the receipt",
          "By inserting the money",
          "By ensuring the scanner BEEPS",
          "By greeting the customer"
        ],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What must the cashier do THEN, after scanning the barcodes?",
        options: [
          "Verify the quantity and price of the merchandise displayed",
          "Attach the receipt to the shopping bag",
          "Calculate the change automatically",
          "Ask if they found everything they needed"
        ],
        answer: 0,
      },
      {
        assessmentStatus: "prototype",
        prompt: "Which payment methods can the cashier ask the customer for?",
        options: [
          "Cash, credit card, or QRIS digital payment",
          "Only cash",
          "Only credit card",
          "Gold and silver"
        ],
        answer: 0,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What happens IF the customer is paying with cash?",
        options: [
          "The cashier inserts the money into the cash drawer and enters the amount into the terminal",
          "The terminal prints the receipt immediately",
          "The cashier asks them to use a credit card instead",
          "The cashier taps the cash on the EDC machine"
        ],
        answer: 0,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What is the Indonesian meaning of the imperative verb 'Attach'?",
        options: ["Menyapa", "Memasukkan", "Melampirkan / menempelkan", "Memeriksa"],
        answer: 2,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What is the FINALLY step in the checkout procedure?",
        options: [
          "Ask if they found everything they needed",
          "Print the receipt, attach it to the shopping bag, and hand over the items",
          "Verify the quantity and price on the dual-screen monitor",
          "Ensure the scanner beeps"
        ],
        answer: 1,
      },
      {
        assessmentStatus: "prototype",
        prompt: "What warm closing phrase is suggested when handing over the items?",
        options: [
          "Please come back tomorrow!",
          "Thank you for shopping with us!",
          "Don't forget your receipt!",
          "Have a nice flight!"
        ],
        answer: 1,
      },
    ],
    practices: [
      {
        type: "sequence",
        title: "Checkout Sequencing",
        instruction: "Arrange the checkout steps in the correct order.",
        items: [
          "Print the receipt and attach it to the bag",
          "Verify the quantity and price",
          "Scan each item's barcode",
          "Greet the customer warmly",
          "Ask for the preferred payment method",
          "Insert money and enter the amount",
        ],
        answer: [
          "Greet the customer warmly",
          "Scan each item's barcode",
          "Verify the quantity and price",
          "Ask for the preferred payment method",
          "Insert money and enter the amount",
          "Print the receipt and attach it to the bag",
        ],
      },
      {
        type: "match",
        title: "Equipment Match",
        instruction: "Match each retail tool with its use.",
        left: ["Barcode Scanner", "Thermal Receipt Paper", "POS Terminal"],
        right: ["To calculate transactions", "To scan items", "To print proof of payment"],
        pairs: {
          "Barcode Scanner": "To scan items",
          "Thermal Receipt Paper": "To print proof of payment",
          "POS Terminal": "To calculate transactions",
        },
      },
      {
        type: "tapMatch",
        title: "Sequence Connector Match",
        instruction: "Match each connector with its Indonesian meaning.",
        left: ["First", "Next", "Then", "After that", "Finally"],
        right: ["Kemudian", "Setelah itu", "Terakhir", "Berikutnya", "Pertama"],
        pairs: {
          "First":      "Pertama",
          "Next":       "Berikutnya",
          "Then":       "Kemudian",
          "After that": "Setelah itu",
          "Finally":    "Terakhir",
        },
      },
    ],
  },
};
