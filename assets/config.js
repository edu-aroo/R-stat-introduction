/* ============================================================================
   config.js  —  THE FILE YOU EDIT TO CONFIGURE THE SITE
   ----------------------------------------------------------------------------
   After editing, rebuild (source("R/build_site.R")) OR edit the copy in
   docs/assets/config.js directly, then commit + push to GitHub.
   ============================================================================ */

window.COURSE_CONFIG = {

  // Short id of this course. It prefixes what the browser stores (login, progress
  // cache), so that this course and the R course can live on the same github.io
  // address without mixing their logins. Never change it once students have started.
  courseId: "statr",

  // Course title (login screen, certificate) — one per language
  title: { en: "R4Marine Stats - Introduction to Statistics using R",
           fr: "R4Marine Stats - Introduction aux statistiques avec R" },
  subtitle: { en: "From describing your data to choosing, running and reporting the right test",
              fr: "De la description des données au choix, à l'exécution et à la rédaction du bon test" },

  // Name used for the watermark, the footer and the login screen
  author: "Aroo Falinirina",

  // Course version shown in the footer (describe changes in whats-new.Rmd)
  version: "1.0", versionDate: "2026-11",

  // Default language for a first visit: "en" or "fr"
  defaultLang: "fr",

  // Image behind the login card. Replace the file (same name) or change the path,
  // e.g. "assets/img/my-photo.jpg". A wide image (≥ 1600 px) looks best.
  loginBackground: "assets/img/login-bg.svg",

  // Google Apps Script web-app URL. Empty "" = DEMO MODE (accounts below,
  // progress saved only in the browser). Use a NEW Google Sheet + script for this
  // course (see README, section 4), not the one of the R course.
  scriptUrl: "https://script.google.com/macros/s/AKfycbxWKbIIjGOwlsHT8QGxQQO4A5Me7pTpgbM4wTmT5aim1p_JhoXlmYqHHQNkSdkmPoVD_A/exec",

  // DEMO MODE only (real accounts are in the Google Sheet, never here: this file is public)
  demoUsers: [
    { user: "demo",    pass: "demo",    name: "Demo Student", level: "stats", role: "student" },
    { user: "teacher", pass: "teacher", name: "Demo Teacher", level: "stats", role: "teacher" }
  ],

  // Quiz rules: attempts per quiz, and the share of the points needed to open the
  // next session and to pass the course (best attempt of every quiz, practice included).
  maxAttempts: 2,
  passThreshold: 0.75,

  // Message and Bible verse shown on the certificate page
  // (on the page only, not printed on the certificate PDF). Edit freely.
  certificateMessages: {
    stats: {
      en: "Congratulations! You can now describe data honestly, choose a test for a good reason, and say what a p-value does — and does not — mean. That is rarer than you think. Keep asking “how do we know?”",
      fr: "Félicitations ! Vous savez maintenant décrire des données honnêtement, choisir un test pour une bonne raison, et dire ce qu'une p-value signifie — et ne signifie pas. C'est plus rare qu'on ne le croit. Continuez à demander « comment le savons-nous ? »",
      verse_en: "For the LORD giveth wisdom: out of his mouth cometh knowledge and understanding.",
      ref_en: "Proverbs 2:6 (KJV)",
      verse_fr: "Car l'Éternel donne la sagesse ; de sa bouche sortent la connaissance et l'intelligence.",
      ref_fr: "Proverbes 2:6 (Louis Segond 1910)"
    }
  },

  // Shown in the "you need help" message
  contact: { email: "aroo.madaeducation@gmail.com", facebook: "Aroo Falinirina" },

  // Pages that do not belong to a level (never locked)
  extraPages: ["index", "help", "certificate", "common-errors", "whats-new",
               "cheatsheet", "glossary", "resources", "choose-test"],

  // The levels, in order (this course has one). Each page: id = file name without
  // ".html"; quiz / quizzes = quiz id(s) of the page; hours = suggested duration.
  levels: [
    { id: "stats", en: "Introduction to statistics", fr: "Introduction aux statistiques", pages: [
      { id: "00-start",          quiz: "t00", hours: 2,   en: "0. Why statistics? Variables, populations, samples", fr: "0. Pourquoi les statistiques ? Variables, populations, échantillons" },
      { id: "01-design",         quiz: "t01", hours: 2.5, en: "1. Study design and sampling",                fr: "1. Plan d'étude et échantillonnage" },
      { id: "02-describe",       quiz: "t02", hours: 3,   en: "2. Describing data: centre, spread, shape",   fr: "2. Décrire les données : centre, dispersion, forme" },
      { id: "03-explore",        quiz: "t03", hours: 2.5, en: "3. Exploring distributions with graphs",      fr: "3. Explorer les distributions en graphiques" },
      { id: "04-probability",    quiz: "t04", hours: 3,   en: "4. Probability and distributions",            fr: "4. Probabilités et lois de distribution" },
      { id: "05-estimation",     quiz: "t05", hours: 3,   en: "5. Standard error and confidence intervals",  fr: "5. Erreur standard et intervalles de confiance" },
      { id: "06-testing",        quiz: "t06", hours: 3,   en: "6. Hypothesis tests and p-values",            fr: "6. Tests d'hypothèse et p-values" },
      { id: "07-two-groups",     quiz: "t07", hours: 3,   en: "7. Comparing two groups",                     fr: "7. Comparer deux groupes" },
      { id: "08-anova",          quiz: "t08", hours: 3.5, en: "8. Comparing several groups: ANOVA, Kruskal–Wallis", fr: "8. Comparer plusieurs groupes : ANOVA, Kruskal–Wallis" },
      { id: "09-categorical",    quiz: "t09", hours: 3,   en: "9. Categorical data: proportions and χ²",     fr: "9. Données catégorielles : proportions et χ²" },
      { id: "10-regression",     quiz: "t10", hours: 3.5, en: "10. Correlation and simple linear regression", fr: "10. Corrélation et régression linéaire simple" },
      { id: "11-power-reporting", quiz: "t11", hours: 2.5, en: "11. Power, multiple tests and reporting",    fr: "11. Puissance, tests multiples et rédaction" },
      { id: "12-practice", quizzes: ["tp1", "tp2", "tp3", "tp4", "tp5", "tp6"], hours: 3.5,
                                                        en: "12. Practice session",                        fr: "12. Séance d'exercices" },
      { id: "13-final-project",  quiz: "t13", hours: 4.5, en: "13. Final project: seagrass and sea urchins", fr: "13. Projet final : herbiers et oursins" }
    ]}
  ]
};
