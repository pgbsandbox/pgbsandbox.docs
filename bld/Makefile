# Copyright (C) Stilo International plc, 2015 - 2015
# All rights reserved.
#
# This source code is unpublished proprietary information of Stilo
# Corporation.  The copyright notice above does not evidence any
# actual or intended publication of such source code.
#
# This file may not be redistributed as source, either by itself,
# or as part of software derived from this file.
#
#
SHELL := /bin/bash

.PHONY : documentation

# GENERIC VARIABLES

DITA_OT_AB_ANT_FILE = /public/LinuxSoftware/dita-ot-2.1.24AB

HELP_SRC_DIR = $(shell cd .. ; pwd)

HELP_TARGET_DIR = $(shell cd $(HELP_TARGET_ROOT_DIR); mkdir -p $(HELP_DEV_OR_REL); cd ./$(HELP_DEV_OR_REL); pwd)

HELP_BUILD_TOOL = $(shell cd .. ; pwd)

HELP_SOURCE_FILE = $(shell find $(HELP_SRC_DIR)/build_files $(HELP_SRC_DIR)/DITA $(HELP_SRC_DIR)/resource  -type f )

# RULES
documentation : $(HELP_SOURCE_FILE)
	@CLASSPATH="$(CLASSPATH):$(shell find $(DITA_OT_AB_ANT_FILE)/ -name '*jar' | awk 'BEGIN{ORS=":";} {print;}')" \
        AUTHORBRIDGE_HELP_SRC_DIR=$(HELP_SRC_DIR)                                                                \
        AUTHORBRIDGE_HELP_TARGET_DIR=$(HELP_TARGET_DIR)                                                          \
        ant -f $(DITA_OT_AB_ANT_FILE)/build_AuthorBridge.xml
