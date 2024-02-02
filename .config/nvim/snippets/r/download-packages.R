#!/usr/bin/env Rscript

###############################################################################
# -*- encoding: UTF-8 -*-                                                     #
# Author: jessekelighine@gmail.com                                            #
# Download packages as a repository, then use the created repository to       #
# install packages.                                                           #
#                                                                             #
# Last Modified: 2022-08-10                                                   #
###############################################################################
library(miniCRAN)
###############################################################################

# install.packages("miniCRAN", type="mac.binary")

### Settings ##################################################################

PATH <- "~/Desktop/packages/"
PKGS <- c("rlang")
RVER <- "4.1.2"
REPO <- "http://cran.us.r-project.org"

### Download Packages #########################################################

dir.create(PATH, recursive=TRUE)
package.list <- pkgDep(PKGS, type="source", suggests=FALSE, Rversion=RVER, repos=REPO)
makeRepo(package.list, path=PATH, type=c("source"), Rversion=RVER, repos=REPO)
pkgAvail(repos=PATH, type="source", Rversion=RVER)

#### Installation #############################################################

install.packages(PKGS, repos="file:///home/.../packages", type="source")
