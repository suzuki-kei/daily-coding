
SRC := *.c
OUT := a.out

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

