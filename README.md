# R4Marine Stats - Introduction to Statistics using R

*by Aroo Falinirina* — version 1.0 (2026-11)

A bilingual (EN/FR), self-study **statistics** course built as an **R Markdown website**,
with the same machinery as the R course *R4Marine Research*: student login, saved progress,
scored quizzes (2 attempts, 75 % rule), sessions that open one after the other, a certificate
and a watermark. All data are **simulated**, each with a description of how it was "collected".

**One level, 14 sessions (≈ 43 h).** Prerequisite: the Beginner level of *R4Marine Research*.
Next course: *Statistical modelling with R* (multiple regression, GLM, mixed models).

| Session | Topic | Data | Quiz |
|---|---|---|---|
| 0 | Why statistics? Variables, populations, samples | fisher survey | t00 |
| 1 | Study design and sampling (random, stratified, systematic, convenience; pseudoreplication) | lagoon census | t01 |
| 2 | Describing data: centre, spread, shape, outliers, tables | reef fish sites, fisher survey | t02 |
| 3 | Exploring distributions with graphs (Anscombe, histogram, boxplot, QQ plot, log scale) | octopus landings | t03 |
| 4 | Probability and distributions (binomial, Poisson, normal, log-normal; d/p/q/r) | octopus, lagoon | t04 |
| 5 | Standard error, central limit theorem, confidence intervals, bootstrap | lagoon, octopus | t05 |
| 6 | Hypothesis tests and p-values (permutation, one-sample t, errors, effect size) | octopus | t06 |
| 7 | Comparing two groups (Welch t, log scale, Wilcoxon, paired tests) | octopus, tagged corals | t07 |
| 8 | ANOVA, assumptions, Tukey, Welch ANOVA, Kruskal–Wallis | sea-cucumber experiment, reef | t08 |
| 9 | Proportions and χ² (binom, goodness of fit, prop.test, independence, Fisher, OR) | fisher survey, octopus | t09 |
| 10 | Correlation and simple linear regression (Pearson, Spearman, lm, diagnostics, prediction) | mangrove plots, reef | t10 |
| 11 | Power and sample size, multiple tests, p-hacking, reporting | octopus, fisher survey | t11 |
| 12 | Practice session (6 exercises) | all | tp1–tp6 |
| 13 | Final project: seagrass and sea urchins (15 questions) | seagrass_urchins | t13 |

Extra pages: *Which test?* (decision guide), cheatsheet, EN–FR glossary, common errors & pitfalls,
*To go further* (reading list), help, certificate, what's new.

---

## 1. What is in this folder

```
Intro-statR/
├── Intro-statR.Rproj          <- open this in RStudio
├── _site.yml                  <- navbar, theme, output folder (docs/), files never published
├── index.Rmd                  <- home page (dashboard of the student)
├── 00-start.Rmd … 13-final-project.Rmd   <- the 14 sessions (12 = practice)
├── choose-test.Rmd, cheatsheet.Rmd, glossary.Rmd, common-errors.Rmd, resources.Rmd
├── help.Rmd, certificate.Rmd, cert-preview.Rmd, whats-new.Rmd
├── assets/
│   ├── config.js              <- THE file to edit: title, Google Script URL, pages, certificate text
│   ├── course.js              <- login, progress, quizzes, unlocking, certificate (commented)
│   ├── course.css             <- the look (same as the R course)
│   ├── quiz_index.json/.js    <- list of all quizzes and their points (built by R/build_site.R)
│   └── img/*.svg              <- bilingual figures; logo.png, login-bg.svg, bg.png
├── R/
│   ├── build_site.R           <- builds the website into docs/ (USE THIS)
│   ├── course_helpers.R       <- quiz(), q_num(), q_mcq(), q_text(), fig_svg(), dl(), fa(), theme_c()
│   ├── simulate_data.R        <- creates the 8 datasets + intro_stats_data.zip
│   ├── make_accounts.R        <- usernames + passwords for your students
│   └── make_pdf_kit.R         <- printable PDF kit, with watermark
├── data/                      <- the 8 CSV files + intro_stats_data.zip
├── templates/                 <- check_setup.R, final_project_template.R (downloadable)
├── slides/                    <- slide decks (French), see section 8
├── pdf_kit/                   <- pdf.css + the PDFs you generate (never published)
├── apps-script/Code.gs        <- the Google Apps Script "backend"
└── docs/                      <- THE BUILT WEBSITE (what GitHub publishes)
```

`R/`, `apps-script/`, `slides/`, `pdf_kit/` and `README.md` are **never published** (`exclude:` in `_site.yml`).

### The datasets (all simulated, invented place names)

| File | Collected how | One row = |
|---|---|---|
| `fisher_survey.csv` | 240 interviews, 60 drawn at random per village (4 villages), Sept. 2026 | one fisher |
| `lagoon_population.csv` | complete drone + ground map of a lagoon, 1,200 cells of 10 × 10 m | one cell |
| `reef_fish_sites.csv` | visual census, 36 sites (12 no-take, 12 LMMA, 12 open access), 3 transects averaged | one site |
| `octopus_catch.csv` | every octopus landed on the reopening day of a closure, 2 villages, March 2026 | one octopus |
| `coral_tagged_colonies.csv` | 20 tagged colonies photographed in March and July 2026 | one colony (2 measures) |
| `sea_cucumber_pens.csv` | 4 feeds assigned at random to 24 pens, 90 days | one pen |
| `mangrove_plots.csv` | 40 plots along 4 sea-to-land transects, 2025 | one plot |
| `seagrass_urchins.csv` | 80 random stations, 40 inside and 40 outside a no-take zone, April 2026 | one station |

## 2. Build the site

1. Open `Intro-statR.Rproj` in RStudio.
2. Install once:
   `install.packages(c("rmarkdown", "knitr", "jsonlite", "dplyr", "ggplot2", "patchwork"))`
   (optional: `"pagedown"` for the PDF kit).
3. *(Optional)* regenerate the data: `source("R/simulate_data.R")`. Quiz answers are computed from the data
   at build time (hidden `answers` chunks), so they follow automatically. A few sentences quote numbers
   from the data; they are protected by hidden `stopifnot()` checks: if you change the data and a page
   stops with *"… is not TRUE"*, update the sentence just above that check.
4. Build: **`source("R/build_site.R")`**. It renders every page, rebuilds the quiz index
   (`assets/quiz_index.*`) and re-creates `docs/.nojekyll`. To check one page only:
   `rmarkdown::render_site("08-anova.Rmd")` — but always finish with a full build before publishing.
5. Open `docs/index.html`. Without a Google Script URL the site runs in **demo mode**:
   `demo` / `demo` (student) and `teacher` / `teacher` (sees everything, answers not recorded).

## 3. Publish on GitHub Pages

1. New repository (e.g. `intro-statR` on your account `edu-aroo`), push this folder.
2. Repository → **Settings → Pages → Deploy from a branch**, Branch `main`, Folder **`/docs`**.
3. After each change: full build → commit → push. Keep `docs/.nojekyll`.

**Same github.io address as the R course?** No problem: `courseId: "statr"` in `config.js`
keeps the logins and saved progress of the two courses separate in the students' browsers.

## 4. Google Sheet backend (logins, progress, scores, certificate)

Use a **new** Google Sheet and a **new** Apps Script deployment for this course (not the R course's),
so that scores, levels and certificates do not mix.

1. New Google Sheet → *Extensions → Apps Script* → paste `apps-script/Code.gs` → Save.
2. At the top of `Code.gs`, set **`SITE_URL`** to the address of the site, with the final `/`
   (e.g. `"https://edu-aroo.github.io/intro-statR/"`). Check `ALERT_EMAIL`.
3. Run **`setup`** (accept the permissions), then **`installTriggers`**.
4. *Deploy → New deployment → Web app* — Execute as **Me**, access **Anyone** → copy the URL (`…/exec`).
5. Paste it in `assets/config.js` → `scriptUrl: "…/exec"`, rebuild, push.
6. Run **`testQuizIndex`**: the log must show **19** quizzes.

The tabs and columns are the same as in the R course (`students`, `progress`, `scores`, `certificates`,
`alerts`, `dashboard`). In `students`, the column **`level`** is `stats` (or empty) for everyone;
`role` = `teacher` sees everything; `open_pages` opens sessions by hand, e.g. `07-two-groups`
(to unblock a stuck student, or to let a student skip sessions they already know).
Accounts: `source("R/make_accounts.R")` (writes `accounts_to_paste.csv`, never published).

**Rules.** 2 attempts per quiz, the best counts; a session opens when the previous one reaches 75 %;
the practice session counts as one session (its 6 exercises together). The course is passed when all
quizzes are done with ≥ 75 % of the total points: a certificate is issued and you receive an e-mail.
When 75 % can no longer be reached on a session, the student goes to the help page and you receive an e-mail.
`maxAttempts` / `passThreshold` in `config.js` and `MAX_ATTEMPTS` / `PASS` in `Code.gs` must stay identical.

**Be aware:** GitHub Pages serves static files. The login protects *progress and scores*, but a technical
person can read the pages and decode the answers. Fine for a course, not for high-stakes exams.

## 5. Change the texts

- Title, subtitle, version, contacts, pages, certificate message and verse: `assets/config.js`.
- Colours: top of `assets/course.css`. Login background: `assets/img/login-bg.svg`.
- New version: add a section at the top of `whats-new.Rmd` and change `version` in `config.js`.

## 6. Add or change a session

Keep the structure of a session: objectives → **simulated context** → sections with code, output and a
*Functions and arguments* table (`fa()`) → application work → hint → quiz → solution. Quiz ids must be
unique and must never be renamed once students have used them. Add the page to `levels` in
`assets/config.js` and to the navbar in `_site.yml`, then run a full build.

Adding a second level later (e.g. an applied-projects level) works as in the R course: add a level in
`config.js` and `LEVELS` in `Code.gs`, and make `register_quiz()` in `R/course_helpers.R` choose the level
from the file name.

## 7. PDF kit

```r
source("R/make_pdf_kit.R")
make_pdf_kit(lang = "fr")                     # without solutions
make_pdf_kit(lang = "en", solutions = TRUE)
```

Needs `pagedown` and Google Chrome (or Chromium). PDFs go to `pdf_kit/stats/<lang>/`, with the watermark on every page; they are never published (quizzes stay online so that progress is kept).

## 8. Slides

`slides/` contains French slide decks for presenting the course live (≈ 1 h each).
Build: `source("slides/render_slides.R")`. Keys: **→ / Space** next, **F** full screen, **O** overview,
**N** speaker notes, **Ctrl + P** → PDF.

## 9. For students

`templates/check_setup.R` checks R, RStudio, packages, data files and that `set.seed()` gives the same
random numbers as the course. It can be downloaded from the home page and from Session 0.
