
SRC := *.cs
OUT := a.out

.DEFAULT_GOAL := all

.PHONY: all
all: build run clean

.PHONY: build
build:
	@csc -out:$(OUT) $(SRC)

.PHONY: run
run:
	@mono $(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

