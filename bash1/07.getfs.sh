#!/bin/sh

echo File systems present:
echo
echo -e "Mount Point \t:\tFile System"
echo ------------------------------------
while read line
	do
	echo $line | awk '{print $1"\t:\t"$2}'
done < <(df -Th | grep "^/dev")

