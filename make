#!/bin/bash

warning()
{
	echo "User don't have permission, need root access"
	echo "try: sudo $BASH_SOURCE"
	exit 1
}

if ! cp doc/ugr.1.gz /usr/share/man/man1/ 2> /dev/null; then
	warning
fi

if ! cp ugr /usr/bin/ugr 2> /dev/null; then
	warning
fi