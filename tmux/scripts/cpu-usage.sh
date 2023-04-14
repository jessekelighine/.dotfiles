#!/usr/bin/env bash

###############################################################################
# -*- encoding: UTF-8 -*-                                                     #
# Author: Jesse C. Chen  (jessekelighine@gmail.com)                           #
# Description: Show CPU usage                                                 #
#                                                                             #
# Last Modified: 2023-03-25                                                   #
###############################################################################

### Linux #####################################################################

# cpu_line=$(top -b -n 1 | grep "Cpu(s)" )
# cpu_user=$(echo "$cpu_line" | grep -Po "(\d+(.\d+)?)(?=%?\s?(us(er)?))")
# cpu_syst=$(echo "$cpu_line" | grep -Po "(\d+(.\d+)?)(?=%?\s?(sys?))")
# cpu_idle=$(echo "$cpu_line" | grep -Po "(\d+(.\d+)?)(?=%?\s?(id(le)?))")

### OSX #######################################################################

# cpu_line=$(top -e -l 1 | grep "CPU usage:" | sed 's/CPU usage: //')
cpu_line=$(top -l 2 | grep "CPU usage:" | tail -n 1 | sed 's/CPU usage: //')
cpu_user=$(echo "$cpu_line" | awk '{ print $1 }' | sed 's/%//' )
cpu_syst=$(echo "$cpu_line" | awk '{ print $3 }' | sed 's/%//' )
cpu_idle=$(echo "$cpu_line" | awk '{ print $5 }' | sed 's/%//' )

### Output ####################################################################

[ $(echo "$cpu_idle < 70" | bc -l) -eq 1 ] && idle_color="yellow"
[ $(echo "$cpu_idle < 40" | bc -l) -eq 1 ] && idle_color="red"

printf "%4.1f %4.1f #[bg=${idle_color:=green}] %4.1f" "$cpu_user" "$cpu_syst" "$cpu_idle"
exit 0
