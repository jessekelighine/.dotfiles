#!/bin/bash

alias dictionary='sdcv --use-dict="Longman Dictionary of Contemporary English" -c0'
alias woerterbuch='sdcv --use-dict="Duden" --use-dict="LDaF" -c0'
export STARDICT_DATA_DIR='~/.stardict'
export SDCV_PAGER='sed "s/\/\//\n/g" | less --quit-if-one-screen -RX'
