#!/bin/bash

{
	brew leaves
	brew list --cask
} > ./.brew_list

printf "/date:\ns/\".*\"/\"%s\"/\np\nwq\n" "$(date +%F)" | ed -s README.md
git add .
