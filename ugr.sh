#!/bin/bash

bold="\033[01m"
normal="\033[0m"
banner="
\nUGR - ${bold}U${normal}pdate ${bold}G${normal}it ${bold}R${normal}epository
\nBy gjuniioor [gjuniioor\x40protonmail\x2Ech]\n"
HELP="
Usage:
\n\t$BASH_SOURCE [options]
\n\nOptions:
\n\t
"

version="0.9"

interactive_mode="n"

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
echo -e $HELP

# interactive_mode="y" # test interactive mode on

# path # test current path
# path /home/gjuniioor/Documents/git/ # test in a path
# list /tmp/test # test with file list