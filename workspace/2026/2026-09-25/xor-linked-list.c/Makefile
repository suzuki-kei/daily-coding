
SRC := $(wildcard *.c)
OUT := a.out

.PHONY: test
test:
	@gcc -Wall -Werror -o $(OUT) $(SRC) && ./$(OUT); rm -rf $(OUT)

