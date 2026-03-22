
SRC := $(wildcard *.cpp)
HEADER_FILES := $(wildcard *.hpp)
OUT := a.out

.DEFAULT_GOAL := all

.PHONY: all
all: run clean

$(OUT): $(SRC) $(HEADER_FILES)
	@g++ -Wall -Werror -std=c++23 -o $(OUT) $(SRC)

.PHONY: build
build: $(OUT)

.PHONY: run
run: $(OUT)
	@./$(OUT)

.PHONY: clean
clean:
	@rm -rf $(OUT)

