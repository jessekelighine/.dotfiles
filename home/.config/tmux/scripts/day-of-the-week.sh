#!/usr/bin/env bash

symbols=( "㊊" "㊋" "㊌" "㊍" "㊎" "㊏" "㊐" )
day_of_week=$(date +%u)
index=$((day_of_week - 1))
echo "${symbols[$index]}"
