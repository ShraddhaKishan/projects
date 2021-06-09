#!/bin/sh

if [[  $* == '' ]] 
then
	echo "No input"
else
	for file in $*;
	do
		while read line
		do
			if [[ $(which $line) != '' ]]
			then
				$line --version
				echo
			else
				echo -e "The utility $line is not installed"
				echo
			fi
		done < $file
	done
fi
