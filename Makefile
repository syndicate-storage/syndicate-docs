# Makefile for Doxygen

WORKSPACE ?= .
PROJECTPATH ?= /var/lib/jenkins/jobs
WEBPATH ?= /srv/sites/butler/docs
DOXYGEN_FILE ?= ./Doxyfile.cfg
OUTPUT_DIR ?= $(WORKSPACE)
SOURCES ?= sources

all: get fixmain docs web

#########################
# get the source provided
#########################
get:
	PROJECTPATH=$(PROJECTPATH) SOURCES=$(SOURCES) $(WORKSPACE)/getproject syndicate-core syndicate-ug-tools https://github.com/syndicate-storage/syndicate-storage.github.io

#########################
# fix the header info for the main page, remove "layout" and "title" from markup
#########################
fixmain:
	sed  -i '/---/,/---/d' $(SOURCES)/syndicate-storage.github.io/index.md

#########################
# generate documentation
#########################
docs:
	DOXYGEN_FILE=$(DOXYGEN_FILE) $(WORKSPACE)/makedocs

#########################
# copy generated html to web path
#########################
web:
	rm -rf $(WEBPATH)/*
	cp -r html/* $(WEBPATH)

#########################
# clean up
#########################
clean:
	rm -rf $(WORKSPACE)/html
	rm -rf $(WORKSPACE)/man
	rm -rf $(WORKSPACE)/$(SOURCES)
