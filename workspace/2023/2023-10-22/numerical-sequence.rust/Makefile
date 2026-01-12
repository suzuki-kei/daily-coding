
SRC := *.rs
OUT := a.out

.PHONY: run
run:
	@rustc -D warnings -o $(OUT) $(SRC) && ./$(OUT) && rm $(OUT)

