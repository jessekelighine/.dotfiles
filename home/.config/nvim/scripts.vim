" ~/.config/nvim/scripts.vim

if did_filetype()
	finish
endif

" DETECT R SCRIPT:
if getline(1) =~ '^#!/usr/bin/env Rscript$'
	setfiletype r
endif
