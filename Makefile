# Makefile for Doxygen

WORKSPACE ?= .
PROJECTPATH ?= /var/lib/jenkins/jobs
DOXYGEN_FILE ?= ./Doxyfile.cfg
OUTPUT_DIR ?= $(WORKSPACE)
SOURCES ?= sources

all: get docs

get:
	PROJECTPATH=$(PROJECTPATH) SOURCES=$(SOURCES) $(WORKSPACE)/getproject syndicate-core syndicate-ug-tools

docs:
	DOXYGEN_FILE=$(DOXYGEN_FILE) $(WORKSPACE)/makedocs

clean:
	rm -rf $(WORKSPACE)/html
	rm -rf $(WORKSPACE)/man
	rm -rf $(WORKSPACE)/$(SOURCES)
