
SRC := $(wildcard *.ts)
OUT := a.js

.DEFAULT_GOAL := all

.PHONY: all
all: build run clean

.PHONY: build
build:
	@tsc --strict --lib dom,es2015 --target es2015 --outFile $(OUT) $(SRC)

.PHONY: run
run:
	@node $(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

