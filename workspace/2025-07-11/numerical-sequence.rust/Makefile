
SRC := $(wildcard *.rs)
OUT := a.out

.PHONY: run
run:
	@rustc -D warnings -o $(OUT) $(SRC) && ./$(OUT); rm -rf $(OUT)

