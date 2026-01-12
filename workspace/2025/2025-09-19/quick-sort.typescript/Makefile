
SRC := $(wildcard *.ts)
OUT := a.out

.PHONY: run
run:
	@tsc --strict --outFile $(OUT) $(SRC) && node $(OUT); rm -rf $(OUT)

