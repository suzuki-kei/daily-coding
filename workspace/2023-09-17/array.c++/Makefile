
SRC := *.cpp
OUT := a.out

.DEFAULT_GOAL := all

.PHONY: all
all: build run clean

.PHONY: build
build:
	@g++ -Wall -std=c++2b -o $(OUT) $(SRC)

.PHONY: run
run: $(OUT)
	@./$(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

