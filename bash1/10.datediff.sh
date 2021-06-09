#!/bin/sh

# Number of seconds in a day 
DAY_IN_SEC=86400

let diff_in_sec=($(date +%s -d $1) - $(date +%s -d $2))

let diff_in_day=($diff_in_sec/$DAY_IN_SEC)

echo ${diff_in_day#-} days

