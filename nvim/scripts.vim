" detect R scripts by shebang
if did_filetype() | finish | endif
if getline(1) =~ '^#!/usr/bin/env Rscript$'
	setfiletype r
endif
