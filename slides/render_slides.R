# ==============================================================================
# render_slides.R — build the slide decks into slides/   source("slides/render_slides.R")
# Each deck is ONE self-contained .html file (works offline, can be copied on a
# USB key). Open it in a browser. Keys: arrows / space = move, F = full screen,
# O = overview of all slides, N = show the speaker notes.
# ==============================================================================
decks <- c("slides/part1_sessions0-4.Rmd", "slides/part2_sessions5-8.Rmd", "slides/part3_sessions9-13.Rmd")
for (f in decks) {
  message("Rendering ", f)
  rmarkdown::render(f, encoding = "UTF-8", quiet = TRUE)
}
message("Slides written in slides/*.html")
