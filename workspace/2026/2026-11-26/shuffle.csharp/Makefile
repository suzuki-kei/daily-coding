
SRC := $(wildcard *.cs)
OUT := a.out

.DEFAULT_GOAL := all

.PHONY: all
all: run clean

$(OUT): $(SRC)
	@csc -out:$(OUT) $(SRC)

.PHONY: build
build: $(OUT)

.PHONY: run
run: $(OUT)
	@mono $(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

