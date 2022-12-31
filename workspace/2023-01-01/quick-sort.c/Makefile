
SRC := main.c
OUT := main.out

.DEFAULT_GOAL := run

.PHONY: build
build:
	gcc -Wall -o $(OUT) $(SRC)

.PHONY: run
run: build
	./$(OUT)

.PHONY: clean
clean:
	rm -rf $(OUT)

