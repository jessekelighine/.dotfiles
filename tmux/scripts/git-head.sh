#!/usr/bin/env bash

###############################################################################
# -*- encoding: UTF-8 -*-                                                     #
# Author: Jesse C. Chen  (jessekelighine@gmail.com)                           #
# Last Modified: 2023-03-22                                                   #
# Description: Print Git branch if in Git repo.                               #
#                                                                             #
###############################################################################

git_head=$( git rev-parse --abbrev-ref HEAD 2> /dev/null )
[ -n "$git_head" ] && echo " ⎇ ($git_head)"
