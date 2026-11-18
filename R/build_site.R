# =============================================================================
# build_site.R — build the whole website into docs/      source("R/build_site.R")
# =============================================================================
# 0. the pages contain French accents: R must run in a UTF-8 locale
#    (always the case in RStudio on Linux/macOS and with R >= 4.2 on Windows)
if (!isTRUE(l10n_info()[["UTF-8"]])) stop("R is not running in a UTF-8 locale: accents would be broken. ",
                                          "Start R from RStudio, or set LANG=en_US.UTF-8.")

# 1. start from an empty quiz registry (each quiz() call refills it)
unlink(".quiz_registry", recursive = TRUE)

# 2. knit every .Rmd and copy assets/, data/, templates/ into docs/
rmarkdown::render_site(encoding = "UTF-8")

# 3. combine the registry into the quiz index (used to compute level scores)
files <- list.files(".quiz_registry", full.names = TRUE)
idx   <- lapply(files, function(f) jsonlite::fromJSON(f))
names(idx) <- sapply(idx, `[[`, "id")
idx   <- lapply(idx, function(x) x[c("max", "page", "level")])
json  <- jsonlite::toJSON(idx, auto_unbox = TRUE, pretty = TRUE)
for (d in c("assets", "docs/assets")) {
  writeLines(json, file.path(d, "quiz_index.json"))                      # for the Apps Script
  writeLines(paste0("window.QUIZ_INDEX = ", json, ";"), file.path(d, "quiz_index.js"))  # for course.js
}

# 4. GitHub Pages: do not run Jekyll
file.create("docs/.nojekyll")
message(length(idx), " quizzes indexed. Site built in docs/. Check docs/index.html, then commit + push.")

