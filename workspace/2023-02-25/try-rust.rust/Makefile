
SRC := *.rs
OUT := a.out

.DEFAULT_GOAL := run-main

.PHONY: run-main
run-main:
	@rustc -o $(OUT) main.rs && ./$(OUT)

.PHONY: run-string
run-string:
	@rustc -o $(OUT) string.rs && ./$(OUT)

.PHONY: run-struct
run-struct:
	@rustc -o $(OUT) struct.rs && ./$(OUT)

.PHONY: run-enum
run-enum:
	@rustc -o $(OUT) enum.rs && ./$(OUT)

.PHONY: run-option
run-option:
	@rustc -o $(OUT) option.rs && ./$(OUT)

.PHONY: run-match
run-match:
	@rustc -o $(OUT) match.rs && ./$(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

