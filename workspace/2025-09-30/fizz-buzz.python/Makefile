
SRC := $(wildcard *.py)

.PHONY: run
run:
	@mypy --cache-dir /dev/null $(SRC)
	@python3 main.py

