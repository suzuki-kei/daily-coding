
SRC := $(wildcard *.rs)
OUT := a.out

.DEFAULT_GOAL := all

.PHONY: all
all: build run clean

.PHONY: build
build:
	@rustc -D warnings -o $(OUT) $(SRC)

.PHONY: run
run:
	@./$(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

