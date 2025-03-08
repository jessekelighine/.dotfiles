### Timer #####################################################################

timer <- list()
timer$now <- Sys.time()
timer$tic <- function(...) {
  cat(..., fill = ...length() != 0)
  timer$now <<- Sys.time()
}
timer$toc <- function(...) {
  cat(..., format(difftime(Sys.time(), timer$now)), fill = TRUE)
}
