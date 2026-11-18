# _setup.R — shared setup for the slide decks (sourced in each .Rmd)
# Code chunks run from the PROJECT ROOT (root.dir), so paths are the same as
# in the course: "data/octopus_catch.csv".
source("R/course_helpers.R")          # fig_svg(), theme_c() etc.
knitr::opts_chunk$set(comment = "#>", collapse = TRUE,   # code + result in one box (saves space)
                      fig.width = 7, fig.height = 3.8,
                      out.width = "75%", fig.align = "center", dpi = 110)
library(ggplot2)
fs  <- read.csv("data/fisher_survey.csv")
lag <- read.csv("data/lagoon_population.csv")
rf  <- read.csv("data/reef_fish_sites.csv")
oc  <- read.csv("data/octopus_catch.csv")
cc  <- read.csv("data/coral_tagged_colonies.csv")
sc  <- read.csv("data/sea_cucumber_pens.csv")
mp  <- read.csv("data/mangrove_plots.csv")
