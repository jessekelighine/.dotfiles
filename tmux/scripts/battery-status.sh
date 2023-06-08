#!/usr/bin/env bash

[ -z $( pmset -g batt | grep -o "discharging" ) ] && charging='#[fg=red]●'
percentage=$( pmset -g batt | grep -o "[0-9]\{1,3\}%" | sed 's/%//' )
[ $percentage -lt 50 ] && color='#[fg=yellow]'
[ $percentage -lt 20 ] && color='#[fg=red]'

echo "${charging:-} ${color:=#[fg=green]}$percentage"
