# ==============================================================================
# check_setup.R — "Is my computer ready for the statistics course?"
# ------------------------------------------------------------------------------
# 1. Open your course RStudio project (intro-stats).
# 2. Run the whole script (Ctrl + Shift + Enter) and read the ✔ / ✘ lines.
# ==============================================================================
ok   <- function(msg) cat("  ✔ ", msg, "\n", sep = "")
bad  <- function(msg, fix) cat("  ✘ ", msg, "\n      -> ", fix, "\n", sep = "")

cat("\n== R and RStudio ==\n")
v <- getRversion()
if (v >= "4.1.0") ok(paste("R version", v)) else
  bad(paste("R version", v, "is old"), "install the latest R from https://cran.r-project.org")
if (Sys.getenv("RSTUDIO") == "1") ok("running inside RStudio") else
  bad("not running inside RStudio", "open RStudio, then open your course project")

cat("\n== Project folders ==\n")
for (d in c("data", "scripts", "outputs")) {
  if (dir.exists(d)) ok(paste0("folder '", d, "/' exists")) else
    bad(paste0("folder '", d, "/' is missing"), paste0("create it: dir.create(\"", d, "\")"))
}

cat("\n== Packages ==\n")
pkgs <- c("dplyr", "ggplot2")
missing <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]
for (p in setdiff(pkgs, missing)) ok(paste(p, packageVersion(p)))
if (length(missing)) {
  bad(paste("missing packages:", paste(missing, collapse = ", ")),
      paste0('install.packages(c("', paste(missing, collapse = '", "'), '"))'))
}
ok("stats (tests, distributions, lm) is part of base R: nothing to install")

cat("\n== Data files ==\n")
files <- c("fisher_survey.csv", "lagoon_population.csv", "reef_fish_sites.csv", "octopus_catch.csv",
           "coral_tagged_colonies.csv", "sea_cucumber_pens.csv", "mangrove_plots.csv", "seagrass_urchins.csv")
for (f in files) {
  if (file.exists(file.path("data", f))) ok(f) else
    bad(paste(f, "not found in data/"), "download intro_stats_data.zip (Session 0) and unzip it into data/")
}

cat("\n== Random numbers ==\n")
set.seed(1); x <- sample(1:100, 1)
if (x == 68) ok("sample() gives the same numbers as in the course") else
  bad("sample() gives other numbers than in the course",
      "your R is older than 3.6: update R, or the answers using set.seed() will differ")
cat("\nDone. If every line shows ✔, you are ready.\n")
