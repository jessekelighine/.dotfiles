#!/usr/bin/env bash

git_head=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
[ -n "$git_head" ] && echo " ⎇ ($git_head)"
