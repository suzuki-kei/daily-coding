
SRC := $(wildcard *.ts)
OUT := a.js

.PHONY: run
run:
	@tsc --strict --lib dom,es2015 --target es2015 --outFile $(OUT) $(SRC) && node $(OUT); rm -rf $(OUT)

