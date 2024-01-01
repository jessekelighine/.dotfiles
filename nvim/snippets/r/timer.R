### Timer #####################################################################

timer <- list()
timer$now <- Sys.time()
timer$tic <- function () timer$now <<- Sys.time()
timer$toc <- function () format(difftime(Sys.time(),timer$now))
