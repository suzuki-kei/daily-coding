
SRC := $(wildcard *.rs)
OUT := a.out

.DEFAULT_GOAL := all

.PHONY: all
all: run clean

$(OUT): $(SRC)
	@rustc -D warnings -o $(OUT) $(SRC)

.PHONY: build
build: $(OUT)

.PHONY: run
run: $(OUT)
	@./$(OUT) || true

.PHONY: clean
clean:
	@rm -rf $(OUT)

