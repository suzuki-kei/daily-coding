
SRC := $(wildcard *.cpp)
OUT := a.out

.PHONY: run
run:
	@g++ -Wall -Werror -std=c++23 -o $(OUT) $(SRC) && ./$(OUT) || true
	@rm -rf $(OUT)

