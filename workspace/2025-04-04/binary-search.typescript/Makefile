
SRC := *.ts
OUT := main.js

.DEFAULT_GOAL := all

.PHONY: all
all: build run clean

.PHONY: build
build:
	@tsc --lib dom,es2022 --outFile $(OUT) $(SRC)

.PHONY: run
run:
	@node $(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

