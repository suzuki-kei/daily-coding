
OUT := a.out

.DEFAULT_GOAL := main

.PHONY: main
main:
	@rustc -o $(OUT) main.rs && ./$(OUT)

.PHONY: variable
variable:
	@rustc -o $(OUT) variable.rs && ./$(OUT)

.PHONY: function
function:
	@rustc -o $(OUT) function.rs && ./$(OUT)

.PHONY: control_flow
control_flow:
	@rustc -o $(OUT) control_flow.rs && ./$(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

