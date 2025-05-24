###############################################################################
# -*- encoding: UTF-8 -*-                                                     #
# Author: jessekelighine at gmail dot com                                     #
# Description: update or install the dotfiles.                                #
#                                                                             #
# Last Modified: 2025-05-15                                                   #
###############################################################################

.PHONY: all
all:
	# Use `make update`, `make install`, or `make uninstall`

.PHONY: update
update:
	./dotfiles-update.sh interactive

.PHONY: update-noninteractive
update-noninteractive:
	./dotfiles-update.sh

.PHONY: install
install:
	./dotfiles-install.sh

.PHONY: uninstall
uninstall:
	./dotfiles-uninstall.sh
