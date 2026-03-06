
SRC := $(wildcard *.ts)
OUT := a.js

.DEFAULT_GOAL := all

.PHONY: all
all: run clean

$(OUT): $(SRC)
	@tsc --strict --lib dom,es2015 --target es2015 --outFile $(OUT) $(SRC)

.PHONY: build
build: $(OUT)

.PHONY: run
run: $(OUT)
	@node $(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

