
SRC := $(wildcard *.erl)

.PHONY: run
run:
	@erlc -Wall -Werror $(SRC) && erl -noshell -s main main; rm -rf *.beam

