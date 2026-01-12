
SRC := *.c
OUT := a.out

.DEFAULT_GOAL := run

.PHONY: build
build: $(SRC)
	@gcc -Wall -o $(OUT) $(SRC)

.PHONY: clean
clean:
	@rm -rf $(OUT)

.PHONY: run
run: build
	@./$(OUT)

