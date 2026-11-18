# =============================================================================
# simulate_data.R — creates ALL the datasets of the course in data/
# -----------------------------------------------------------------------------
# source("R/simulate_data.R")
# Every dataset is SIMULATED for teaching. Names of villages, sites and reserves
# are invented. Each dataset comes with a short "collection context" (how the data
# would have been collected), repeated in the sessions that use it.
# The quiz answers are computed from these files when the site is built, so if you
# change something here, rebuild the whole site (R/build_site.R).
# =============================================================================
dir.create("data", showWarnings = FALSE)
r1 <- function(x) round(x, 1)
clamp <- function(x, lo, hi) pmin(pmax(x, lo), hi)

# -----------------------------------------------------------------------------
# 1. fisher_survey.csv — Sessions 0, 2, 9, 11, practice
# Context: September 2026, face-to-face interviews (Malagasy) with 240 fishers of
# 4 villages. In each village, 60 fishers were drawn at random from the register
# of the fishers' association (stratified random sampling). One row = one fisher.
# -----------------------------------------------------------------------------
set.seed(2026)
villages <- c("Ambohibe", "Tsifota", "Andrevo", "Befasy")
n_v <- 60
fs <- do.call(rbind, lapply(seq_along(villages), function(k) {
  sex <- sample(c("F", "M"), n_v, replace = TRUE, prob = c(0.35, 0.65))
  data.frame(village = villages[k], sex = sex)
}))
n <- nrow(fs)
fs$fisher_id <- sprintf("F%03d", seq_len(n))
fs$age <- round(clamp(rnorm(n, 38, 11), 16, 75))
fs$years_fishing <- pmax(1, round(fs$age - 14 - rgamma(n, 2, 0.4)))
# gear depends on sex: women mostly glean on the reef flat
p_gear_f <- c(gleaning = 0.62, line = 0.18, net = 0.15, speargun = 0.05)
p_gear_m <- c(gleaning = 0.08, line = 0.40, net = 0.32, speargun = 0.20)
fs$main_gear <- vapply(fs$sex, function(s) sample(names(p_gear_f), 1,
                       prob = if (s == "F") p_gear_f else p_gear_m), "")
fs$boat <- ifelse(fs$main_gear == "gleaning", ifelse(runif(n) < 0.1, "yes", "no"),
                  ifelse(runif(n) < 0.75, "yes", "no"))
fs$trips_per_week <- clamp(rpois(n, ifelse(fs$main_gear == "gleaning", 3.2, 4.6)), 0, 7)
fs$household_size <- clamp(rpois(n, 5.4), 1, 14)
fs$education <- sample(c("none", "primary", "secondary"), n, replace = TRUE, prob = c(0.32, 0.5, 0.18))
# LMMA membership differs between villages (two villages have an active LMMA)
p_lmma <- c(Ambohibe = 0.68, Tsifota = 0.55, Andrevo = 0.22, Befasy = 0.18)
fs$lmma_member <- ifelse(runif(n) < p_lmma[fs$village], "yes", "no")
# support for temporary closures is higher among members
fs$supports_closure <- ifelse(runif(n) < ifelse(fs$lmma_member == "yes", 0.82, 0.55), "yes", "no")
fs$catch_trend <- sample(c("decreased", "stable", "increased"), n, replace = TRUE, prob = c(0.62, 0.28, 0.10))
fs$monthly_catch_kg <- round(rlnorm(n, log(ifelse(fs$main_gear == "gleaning", 28, 55)), 0.55), 1)
fs <- fs[, c("fisher_id", "village", "sex", "age", "years_fishing", "education", "household_size",
             "main_gear", "boat", "trips_per_week", "monthly_catch_kg", "lmma_member",
             "supports_closure", "catch_trend")]
write.csv(fs, "data/fisher_survey.csv", row.names = FALSE)

# -----------------------------------------------------------------------------
# 2. lagoon_population.csv — Sessions 1 and 5
# Context: a complete map ("census") of a lagoon seagrass bed, divided into
# 1,200 cells of 10 x 10 m (40 columns x 30 rows). Drone images + ground checks
# gave the % seagrass cover and the number of sea urchins in every cell.
# Because we know EVERY cell, we know the true population values, and we can
# see how close samples get to them.
# -----------------------------------------------------------------------------
set.seed(11)
grid <- expand.grid(x = 1:40, y = 1:30)
grid$cell_id <- sprintf("C%04d", seq_len(nrow(grid)))
grid$zone <- cut(grid$x, c(0, 13, 27, 40), labels = c("inshore", "middle", "reef_flat"))
grid$depth_m <- r1(clamp(0.4 + grid$x * 0.045 + rnorm(nrow(grid), 0, 0.25), 0.2, 3.5))
mu_cov <- c(inshore = 62, middle = 41, reef_flat = 18)[as.character(grid$zone)]
grid$seagrass_cover <- round(clamp(mu_cov + rnorm(nrow(grid), 0, 13), 0, 100))
grid$urchins <- rpois(nrow(grid), exp(0.2 + 0.018 * grid$seagrass_cover))
grid <- grid[, c("cell_id", "x", "y", "zone", "depth_m", "seagrass_cover", "urchins")]
write.csv(grid, "data/lagoon_population.csv", row.names = FALSE)

# -----------------------------------------------------------------------------
# 3. reef_fish_sites.csv — Sessions 2, 3, 8, 10, practice
# Context: regional reef survey, Oct–Nov 2025. 36 reef sites (12 in no-take
# reserves, 12 in LMMAs with fishing rules, 12 open access). At each site, divers
# counted and sized fish on three 50 x 5 m belt transects; the values below are
# the MEANS of the three transects (one row = one site, the replicate).
# -----------------------------------------------------------------------------
set.seed(12)
mg <- rep(c("No-take", "LMMA", "Open access"), each = 12)
rf <- data.frame(site = sprintf("R%02d", 1:36), management = mg,
                 region = rep(rep(c("North", "South"), each = 6), 3))
rf$depth_m <- r1(runif(36, 4, 12))
rf$coral_cover <- r1(clamp(rnorm(36, c(`No-take` = 38, LMMA = 33, `Open access` = 27)[mg], 8), 5, 70))
rf$rugosity <- round(clamp(1.2 + 0.018 * rf$coral_cover + rnorm(36, 0, 0.15), 1, 3), 2)
log_b <- log(c(`No-take` = 560, LMMA = 400, `Open access` = 260)[mg]) + 0.015 * (rf$coral_cover - 32) + rnorm(36, 0, 0.45)
rf$biomass_kg_ha <- round(exp(log_b))
rf$fish_density <- round(rf$biomass_kg_ha * runif(36, 0.12, 0.18) + rnorm(36, 0, 6))
rf$species_richness <- round(clamp(rnorm(36, 34 + 0.35 * rf$coral_cover, 5), 15, 70))
rf$herbivore_pct <- r1(clamp(rnorm(36, 28, 7), 8, 55))
write.csv(rf, "data/reef_fish_sites.csv", row.names = FALSE)

# -----------------------------------------------------------------------------
# 4. octopus_catch.csv — Sessions 4, 5, 6, 7, 9
# Context: reopening day of a 3-month temporary octopus closure, 14 March 2026.
# Community data collectors weighed (spring balance, 10 g) and sexed EVERY octopus
# landed in Tsifota (fishing in the area that had been closed) and in Andrevo
# (fishing in open areas only), on the same day. One row = one octopus.
# -----------------------------------------------------------------------------
set.seed(314)
n_c <- 185; n_o <- 160
oc <- data.frame(
  octopus_id = sprintf("O%03d", 1:(n_c + n_o)),
  village = rep(c("Tsifota", "Andrevo"), c(n_c, n_o)),
  area = rep(c("reopened", "open"), c(n_c, n_o)))
oc$weight_g <- round(rlnorm(nrow(oc), log(ifelse(oc$area == "reopened", 870, 620)), 0.55), -1)
set.seed(1003)                      # (a second seed for the sex ratio)
oc$sex <- ifelse(runif(nrow(oc)) < 0.5, "F", "M")
oc$gear <- ifelse(runif(nrow(oc)) < 0.7, "spear", "hook")
oc$fisher_sex <- ifelse(runif(nrow(oc)) < 0.58, "F", "M")
write.csv(oc, "data/octopus_catch.csv", row.names = FALSE)

# -----------------------------------------------------------------------------
# 5. coral_tagged_colonies.csv — Session 7 (paired data)
# Context: 20 coral colonies tagged with numbered plates on the same reef. Each
# colony was photographed from above in March 2026 (peak of the heat stress) and
# again in July 2026; the % of bleached surface was measured on the photos.
# One row = one colony, measured twice.
# -----------------------------------------------------------------------------
set.seed(20)
cc <- data.frame(colony_id = sprintf("T%02d", 1:20),
                 genus = rep(c("Acropora", "Porites", "Pocillopora", "Montipora"), each = 5),
                 depth_m = r1(runif(20, 2, 8)))
base <- clamp(rnorm(20, 46, 18), 5, 95)
cc$bleached_march <- r1(base)
cc$bleached_july  <- r1(clamp(base - rnorm(20, 9, 8), 0, 100))
write.csv(cc, "data/coral_tagged_colonies.csv", row.names = FALSE)

# -----------------------------------------------------------------------------
# 6. sea_cucumber_pens.csv — Session 8 (experiment, one-way ANOVA)
# Context: community sea-cucumber farm (Holothuria scabra), 2026. 24 pens of the
# same size; each pen received 30 juveniles. Four feeding treatments were drawn
# at random among the pens (6 pens each): no added food (control), dried seaweed,
# composted manure, seaweed + manure. After 90 days all animals were weighed.
# One row = one pen (the experimental unit).
# -----------------------------------------------------------------------------
set.seed(90)
tr <- rep(c("control", "seaweed", "manure", "mixed"), each = 6)
sc <- data.frame(pen = sprintf("P%02d", sample(1:24)), treatment = tr)
sc$initial_weight_g <- r1(rnorm(24, 15, 1.2))
sc$growth_g_day <- round(clamp(rnorm(24, c(control = 0.62, seaweed = 0.81, manure = 0.74, mixed = 1.02)[tr], 0.12), 0.1, 2), 2)
sc$final_weight_g <- r1(sc$initial_weight_g + 90 * sc$growth_g_day)
sc$survivors <- rbinom(24, 30, c(control = 0.83, seaweed = 0.80, manure = 0.70, mixed = 0.78)[tr])
sc$survival_pct <- r1(100 * sc$survivors / 30)
sc <- sc[order(sc$pen), ]
write.csv(sc, "data/sea_cucumber_pens.csv", row.names = FALSE)

# -----------------------------------------------------------------------------
# 7. mangrove_plots.csv — Session 10 (correlation, regression)
# Context: 40 plots of 10 x 10 m placed every 25 m along 4 transects running from
# the sea front to the landward edge of a mangrove (2025). In each plot: distance
# from the sea front, pore-water salinity (refractometer), height and diameter (DBH)
# of the trees (plot mean) and number of seedlings.
# -----------------------------------------------------------------------------
set.seed(40)
mp <- data.frame(plot = sprintf("M%02d", 1:40), transect = rep(paste0("T", 1:4), each = 10),
                 distance_m = rep(seq(0, 225, by = 25), 4))
mp$salinity_psu <- r1(clamp(32 + 0.06 * mp$distance_m + rnorm(40, 0, 3.5), 25, 60))
mp$tree_height_m <- r1(clamp(13.5 - 0.17 * mp$salinity_psu + rnorm(40, 0, 1.1), 1.5, 15))
mp$dbh_cm <- r1(clamp(2.2 * mp$tree_height_m + rnorm(40, 0, 2.5), 2, 40))
mp$seedlings <- rpois(40, exp(3.4 - 0.045 * mp$salinity_psu))
write.csv(mp, "data/mangrove_plots.csv", row.names = FALSE)

# -----------------------------------------------------------------------------
# 8. seagrass_urchins.csv — Session 13 (final project)
# Context: April 2026, 80 stations placed at random over a lagoon, stratified by
# protection: 40 inside the no-take zone of an LMMA, 40 outside. At each station,
# one 1 m² quadrat: depth (dive computer), sediment type, % seagrass cover,
# canopy height (cm, mean of 5 shoots) and number of sea urchins (Tripneustes gratilla).
# -----------------------------------------------------------------------------
set.seed(80)
su <- data.frame(station = sprintf("S%02d", 1:80), protection = rep(c("Inside", "Outside"), each = 40))
su$sediment <- sample(c("sand", "muddy sand", "rubble"), 80, replace = TRUE, prob = c(0.45, 0.35, 0.20))
su$depth_m <- r1(runif(80, 0.5, 3.5))
mu <- 48 + ifelse(su$protection == "Inside", 7, 0) +
      c(sand = 0, `muddy sand` = 9, rubble = -14)[su$sediment] - 6 * (su$depth_m - 2)
su$seagrass_cover <- round(clamp(mu + rnorm(80, 0, 13), 0, 100))
su$canopy_cm <- r1(clamp(8 + 0.18 * su$seagrass_cover + rnorm(80, 0, 3), 2, 40))
su$urchins <- rnbinom(80, mu = ifelse(su$protection == "Inside", 1.6, 3.4), size = 1.2)
write.csv(su, "data/seagrass_urchins.csv", row.names = FALSE)

# -----------------------------------------------------------------------------
# All the files in one zip for the students
# -----------------------------------------------------------------------------
files <- c("fisher_survey.csv", "lagoon_population.csv", "reef_fish_sites.csv", "octopus_catch.csv",
           "coral_tagged_colonies.csv", "sea_cucumber_pens.csv", "mangrove_plots.csv", "seagrass_urchins.csv")
old <- setwd("data"); unlink("intro_stats_data.zip")
utils::zip("intro_stats_data.zip", files, flags = "-q"); setwd(old)
message("Datasets written in data/ (", length(files), " files + intro_stats_data.zip)")
