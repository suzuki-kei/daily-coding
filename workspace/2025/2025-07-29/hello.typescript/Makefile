
SRC := $(wildcard *.ts)
OUT := main.js

.PHONY: run
run:
	@tsc --strict --outFile $(OUT) $(SRC) && node $(OUT); rm -rf $(OUT)

