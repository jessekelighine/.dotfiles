#!/usr/bin/env bash

sudo powermetrics --samplers smc -n 1 | grep -i "CPU die temperature" | grep -o '\d\+\.\d\+ C' | sed 's/ C//'
exit 0
