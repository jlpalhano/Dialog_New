#!/bin/bash

MENU_OPTIONS=
COUNT=0

for i in `ls`
do
       COUNT=$[COUNT+1]
       MENU_OPTIONS="${MENU_OPTIONS} ${COUNT} $i off "
done
cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
options=(${MENU_OPTIONS})
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
for choice in $choices
do
       " WHATEVER from HERE"
done
