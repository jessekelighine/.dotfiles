#' Curry a function.
#'
#' @param func A function to be curried.
#' @param args The value that should be applied to the first argument.
#' @return A curried function.
#'
#' @exmple
#'
#' is_person <- function(name, id) grepl(x = name, pattern = id)
#' is_john <- is_person %<% list(id = "john")
#' is_john("john list") # TRUE
#' is_john("karl list") # FALSE
#'
`%<%` <- function(func, args) {
  fixed_args <- if (class(args) == "list") args else list(args)
  function(...) do.call(func, c(..., fixed_args)) # curried function
}
