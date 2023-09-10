
SRC := *.c
OUT := a.out

.DEFAULT_GOAL := all

.PHONY: all
all: build run clean

.PHONY: build
build:
	@gcc -Wall -o $(OUT) $(SRC)

.PHONY: run
run: build
	@./$(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

