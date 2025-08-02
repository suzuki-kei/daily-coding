
SRC := $(wildcard *.cpp)
OUT := a.out

.PHONY: run
run:
	@g++ -std=c++23 -fmodules-ts -x c++-system-header print
	@g++ -std=c++23 -fmodules-ts -Wall -Werror -o $(OUT) $(SRC) && ./$(OUT)
	@rm -rf $(OUT) gcm.cache

