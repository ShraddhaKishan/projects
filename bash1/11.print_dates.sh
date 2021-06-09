#!/bin/sh

LAST=$(date -d "$(date +%m)/1 + 1 month - 1 day" +%d)
TODAY=$(date +%d)

let DIFF=$LAST_DATE-$TODAY

for d in $(seq 0 $DIFF); do
	echo $(date -d "+ $d days" +%d-%m-%Y)
done
