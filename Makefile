#!/bin/bash
DOC_FILE=/ugr.1.gz
DOC_SOURCE=doc/
DOC_DEST=/usr/share/man/man1
TARGET=ugr
TARGET_DIR=/usr/bin/
INSTALL=cp
REMOVE=rm

install:
	$(INSTALL) $(DOC_SOURCE)$(DOC_FILE) $(DOC_DEST)
	$(INSTALL) $(TARGET) $(TARGET_DIR)
	
	$(TARGET)

remove:
	$(REMOVE) $(TARGET_DIR)$(TARGET) $(DOC_DEST)$(DOC_FILE)
