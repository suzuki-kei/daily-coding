
SRC := *.rs
OUT := a.out

.DEFAULT_GOAL := run

.PHONY: run
run:
	@rustc -o $(OUT) $(SRC) && ./$(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

