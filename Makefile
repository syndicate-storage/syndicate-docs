# Makefile for Doxygen

WORKSPACE ?= .
PROJECTPATH ?= /var/lib/jenkins/jobs
WEBPATH ?= /srv/sites/butler/docs
DOXYGEN_FILE ?= ./Doxyfile.cfg
OUTPUT_DIR ?= $(WORKSPACE)
SOURCES ?= sources

all: get fixmain docs web

#########################
# get the source via butler
#########################
.PHONY: get
get:
	PROJECTPATH=$(PROJECTPATH) SOURCES=$(SOURCES) $(WORKSPACE)/getproject syndicate-core syndicate-ug-tools https://github.com/syndicate-storage/syndicate-storage.github.io

#########################
# get the source via github
#########################
.PHONY: getgit
getgit:
	PROJECTPATH=$(PROJECTPATH) SOURCES=$(SOURCES) $(WORKSPACE)/getproject https://github.com/syndicate-storage/syndicate-core https://github.com/syndicate-storage/syndicate-ug-tools https://github.com/syndicate-storage/syndicate-storage.github.io

#########################
# fix the header info for the main page, remove "layout" and "title" from markup
#########################
.PHONY: fixmain
fixmain:
	sed '/---/,/---/d' $(SOURCES)/syndicate-storage.github.io/index.md > $(SOURCES)/index.md
	rm -rf $(SOURCES)/syndicate-storage.github.io
	mkdir $(SOURCES)/syndicate-storage.github.io
	mv $(SOURCES)/index.md $(SOURCES)/syndicate-storage.github.io

#########################
# generate documentation
#########################
.PHONY: docs
docs:
	DOXYGEN_FILE=$(DOXYGEN_FILE) $(WORKSPACE)/makedocs

#########################
# copy generated html to web path
#########################
.PHONY: web
web:
	rm -rf $(WEBPATH)/*
	cp -r html/* $(WEBPATH)

#########################
# install man pages, run this as root
#########################
.PHONY: installman
installman:
	$(WORKSPACE)/installman

#########################
# clean up
#########################
.PHONY: clean
clean:
	rm -rf $(WORKSPACE)/html
	rm -rf $(WORKSPACE)/man
	rm -rf $(WORKSPACE)/$(SOURCES)
