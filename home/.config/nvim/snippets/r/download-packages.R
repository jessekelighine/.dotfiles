#!/usr/bin/env Rscript

#' @encoding UTF-8
#' @description
#' Download packages as a repository, then use the created
#' repository to install packages.
#' @date 2025-07-04

install.packages("miniCRAN", type = "mac.binary")
library(miniCRAN)

## Settings ###################################################################

package_path <- "~/Desktop/packages/"
packages <- c("rlang")
r_version <- "4.1.2"
repository <- "http://cran.us.r-project.org"

## Download Packages ##########################################################

dir.create(
  package_path,
  recursive = TRUE
)

package_list <- pkgDep(
  packages,
  type = "source",
  suggests = FALSE,
  Rversion = r_version,
  repos = repository
)

makeRepo(
  package_list,
  path = package_path,
  type = c("source"),
  Rversion = r_version,
  repos = repository
)

pkgAvail(
  repos = package_path,
  type = "source",
  Rversion = r_version
)

## Installation ###############################################################

install.packages(
  packages,
  repos = "file:///home/.../packages",
  type = "source"
)
