
SRC := $(wildcard *.ts)
OUT := a.js

.PHONY: run
run:
	@tsc --strict --outFile $(OUT) $(SRC) && node $(OUT); rm -rf $(OUT)

