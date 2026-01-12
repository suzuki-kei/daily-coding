
SRC := *.cs
OUT := a.out

.PHONY: run
run:
	@csc -out:$(OUT) $(SRC) && mono $(OUT); rm -rf $(OUT)

