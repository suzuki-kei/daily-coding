
SRC := *.rs
OUT := a.out

.DEFAULT_GOAL := run

.PHONY: build
build:
	@rustc -o $(OUT) $(SRC)

.PHONY: clean
clean:
	@rm -rf $(OUT)

.PHONY: run
run: build
	@./$(OUT)

