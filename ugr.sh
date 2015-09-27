#!/bin/bash

bold="\033[01m"
normal="\033[0m"
banner="
\nUGR - ${bold}U${normal}pdate ${bold}G${normal}it ${bold}R${normal}epository
\nBy gjuniioor [gjuniioor\x40protonmail\x2Ech]\n"


version="0.9"

interactive_mode="n"

help_menu() # show help message
{
	HELP="
Usage:
\n\t$BASH_SOURCE [options]
\n\nOptions:
\n\t-h\t\tHelp message
\n\t-i\t\tSet interactive mode on (default=off)
\n\t-l <file>\tUse a repositories location file list
\n\t-p <path>\tSet a path to focus
\n\t\t\tIf none argument was seted, default is \"-p current_dir\"
"
	echo -e $HELP
}
try()
{
	echo -e "Try: \n\t$BASH_SOURCE -h"
}
list() # use file with list
{
	for dir in `cat ${1}`
	do
		check $dir
	done;
}
path() # use path indicator (maybe current)
{
	cmd="ls --ignore=$BASH_SOURCE"

	if [ ! -z ${1} ]; then
		cmd="$cmd ${1}"
		for dir in `$cmd`
		do
			check ${1}/$dir
		done;
	else
		for dir in `$cmd`
		do
			check $dir
		done;
	fi;
}
interactive() # interactive mode
{
	dir_now=${1}
	name=${dir_now##*/}
	if [[ $interactive_mode == "y" ]]; then
		echo -e "Do you want update $bold$name$normal? [Y/n]"
		read ask
		if [[ ! $ask == "n" ]]; then
			update ${1}
		fi;
	else
		update ${1}
	fi;
}
check() # check if is a repository
{
	dir_now=${1}
	if [ -d $dir_now/.git ]; then
		interactive $dir_now
	fi;
}
update() # update repository
{
	dir_now=${1}
	current=`pwd`
	name=${dir_now##*/}
	echo -e "Checking update to $bold$name$normal"
	cd $dir_now && git pull
	echo -e "$bold$name$normal is ok!\n"
	cd $current
}

echo -e $banner

while getopts ":hil:p:" o;
	do
		case "${o}" in
			h) 
				help_menu 
				exit 1
				;;
			i) interactive_mode="y" ;;
			l) 
				list $OPTARG
				exit 0
				;;
			p) 
				path $OPTARG
				exit 0
				;;
			\?)
				echo "Invalid option: -$OPTARG" >&2
				try
				exit 1
				;;
			:)
				echo "Option -$OPTARG requires an argument." >&2
				try
				exit 1
				;;
		esac
	done

path # in use ./$0 -i (execute in current path)