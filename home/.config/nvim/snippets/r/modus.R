modus <- function(x, na.rm = TRUE) {
  names(sort(-table(test, useNA = ifelse(na.rm, "no", "ifany"))))[1]
}
modus <- function(x, na.rm = TRUE) {
  if (na.rm) {
    x <- x[!is.na(x)]
  }
  u <- unique(x)
  return(u[which.max(tabulate(match(x, u)))])
}
