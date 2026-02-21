
SRC := $(wildcard *.c)
OUT := a.out

.DEFAULT_GOAL := all

.PHONY: all
all: build run clean

$(OUT): $(SRC)
	@gcc -Wall -Werror -o $(OUT) $(SRC)

.PHONY: build
build: $(OUT)

.PHONY: run
run: $(OUT)
	@./$(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

