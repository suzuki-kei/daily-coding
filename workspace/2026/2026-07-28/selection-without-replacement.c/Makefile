
SRC := $(wildcard *.c)
OUT := a.out

.PHONH: run
run:
	@gcc -Wall -Werror -o $(OUT) $(SRC) && ./$(OUT); rm -rf $(OUT)

