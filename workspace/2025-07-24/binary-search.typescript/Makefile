
SRC := $(wildcard *.ts)
OUT := main.js

.PHONY: run
run:
	@tsc --strict --lib dom,es2022 --outFile $(OUT) $(SRC) && node $(OUT); rm -rf $(OUT)

