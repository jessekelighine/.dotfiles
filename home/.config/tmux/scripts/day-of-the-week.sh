#!/usr/bin/env bash

symbols=( "㊊" "㊋" "㊌" "㊍" "㊎" "㊏" "㊐" )
# symbols=( "㊀" "㊁" "㊂" "㊃" "㊄" "㊅" "㊆" )
# symbols=( "➊" "➋" "➌" "➍" "➎" "➏" "➐" )
day_of_week=$(date +%u)
index=$((day_of_week - 1))
echo "${symbols[$index]}"
