
SRC := $(wildcard *.cpp)
OUT := a.out

.DEFAULT_GOAL := all

.PHONY: all
all: build run clean

$(OUT): $(SRC)
	@g++ -Wall -Werror -std=c++23 -o $(OUT) $(SRC)

.PHONY: build
build: $(OUT)

.PHONY: run
run:
	@./$(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

