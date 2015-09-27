#!/bin/bash

install:
	cp doc/ugr.1.gz /usr/share/man/man1/
	cp ugr /usr/bin/ugr
remove:
	rm /usr/bin/ugr /usr/share/man/man1/ugr