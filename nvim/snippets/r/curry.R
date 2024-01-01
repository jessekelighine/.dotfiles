#' Curry a function.
#'
#' @param func A function to be curried.
#' @param args The value that should be applied to the first argument.
#' @return A curried function.
#'
#' @exmple
#'
#' is.person <- function ( name, id ) grepl(x=name, pattern=id)
#' is.john <- is.person %<% list(id="john")
#' is.john("john list") # TRUE
#' is.john("karl list") # FALSE
#'
`%<%` <- function ( func, args ) {
  fixed.args <- if ( class(args)=="list" ) args else list(args)
  function ( ... ) do.call(func, c(..., fixed.args)) # curried function
}
