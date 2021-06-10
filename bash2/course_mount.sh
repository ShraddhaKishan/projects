#!/bin/sh

# Assuming the user trainee:ftpaccess exists
alias CREATE_MOUNT="bindfs -p 550 -u trainee -g ftpaccess"
alias CHECKMOUNT="mount | grep "

BASE_PATH="/data/courses"
TARGET_PATH="/home/trainee"

COURSES=(
	"Linux_course/Linux_course1"
	"Linux_course/Linux_course2"
	"SQLFundamentals1"
)


function usage {
	echo Usage:
	echo
	echo ./course_mount.sh -h To print this help message
    	echo ./course_mount.sh -m -c [course] For mounting a given course
    	echo ./course_mount.sh -u -c [course] For unmounting a given course
	echo
	echo "If course name is ommited all courses will be (un)mounted"
	echo
}


function mount_course {
	if [[ " ${COURSES[@]} " =~ " $1 " ]]
	then
		IFS="/" read -ra course_split_slash <<< $1
		source="$BASE_PATH/$course"
		target="$TARGET_PATH/${course_split_slash[*]: -1}"
		if [[ ! -d "$target" ]]
		then
			mkdir $target
		fi

		if [[ "$(CHECKMOUNT $target)" != "" ]]
		then
			echo "Mount exists at $target"
		else
			CREATE_MOUNT $source $target
			echo "Mounted: $source -> $target"
		fi
	else
		echo "Wrong course name"
	fi
}


function unmount_course {
	if [[ " ${COURSES[@]} " =~ " $1 " ]]
	then
		IFS="/" read -ra course_split_slash <<< $1
		target="$TARGET_PATH/${course_split_slash[*]: -1}"
		
		if [[ "$(CHECKMOUNT $target)" != "" ]]
		then
			umount $target
			rmdir $target
			echo "Unmounted: $target"
		else
			echo "Mount not found at $target"
		fi
	else
		echo "Wrong course name"
	fi
}



function mount_all {
	for course in "${COURSES[@]}"
	do
		mount_course $course
	done
	echo
	echo "All mounted"
}


function unmount_all {
	for course in "${COURSES[@]}"
	do
		unmount_course $course
	done
	echo
	echo "All unmounted"
}


function main {
	if [[ "$1" = '-h' ]] || [[ "$1" = "" ]]
	then
		usage
	else
		if [[ "$1" = '-m' ]]
		then
			if [[ "$2" = "" ]]
			then
				mount_all
			else
				mount_course $2
			fi
		fi
		
		if [[ "$1" = '-u' ]]
		then
			if [[ "$2" = "" ]]
			then
				unmount_all
			else
				unmount_course $2
			fi
		fi
	fi
}


main $*
