# ==============================================================================
# Final project — Seagrass and sea urchins (R4Marine Stats, Session 13)
# Name: ...............................        Date: ..........
# ==============================================================================

# ---- 0. ANALYSIS PLAN (write it BEFORE running any test) ----------------------
# Sampling unit: the station (n = 80; 40 Inside, 40 Outside, placed at random)
#
# Q1 Lagoon cover      : response = ..........  type = ..........  method = ..........
# Q2 Cover in/out      : response = ..........  groups = .......... test = ..........
#                        if conditions not met: ..........
# Q3 Urchins in/out    : response = ..........  type = ..........  test = ..........
# Q4 Cover ~ sediment  : test = ..........  follow-up = ..........
# Q5 Presence in/out   : variables = ..........  test = ..........
# Q6 Urchins ~ cover   : coefficient = ..........  why = ..........
# Q7 Cover ~ depth     : model = ..........  checks = ..........
# Q8 Next year         : smallest difference = 5 %, power = 0.80, sd from = ..........
# Outliers / missing values will be handled by: ..........

# ---- 1. Packages and data ----------------------------------------------------
library(dplyr)
library(ggplot2)
su <- read.csv("data/seagrass_urchins.csv")
str(su)

# ---- 2. Checks and description -----------------------------------------------


# ---- 3. Q1 Lagoon cover ------------------------------------------------------


# ---- 4. Q2, Q3, Q5 Inside vs outside -----------------------------------------


# ---- 5. Q4 Sediment ----------------------------------------------------------


# ---- 6. Q6, Q7 Relationships -------------------------------------------------


# ---- 7. Q8 Sample size for next year -----------------------------------------


# ---- 8. Figures for the report (save them in outputs/) -----------------------
# ggsave("outputs/cover_by_protection.png", width = 6, height = 4, dpi = 300)

# ---- 9. Reproducibility ------------------------------------------------------
sessionInfo()
