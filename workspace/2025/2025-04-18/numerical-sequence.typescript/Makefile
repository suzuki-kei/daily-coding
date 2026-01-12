
SRC := $(wildcard *.ts)
OUT := main.js

.DEFAULT_GOAL := all

.PHONY: all
all: type-check build run clean

.PHONY: type-check
type-check:
	@tsc --noEmit

.PHONY: build
build:
	@tsc

.PHONY: run
run:
	@node $(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

