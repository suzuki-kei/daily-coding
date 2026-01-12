
SRC := src/*.erl
TARGET_DIR := target

.DEFAULT_GOAL := run

.PHONY: run
run: clean build
	@ERL_CRASH_DUMP=$(TARGET_DIR)/erl_crash.dump erl -noshell -pa $(TARGET_DIR) -s main main -s init stop

.PHONY: build
build:
	@mkdir -p $(TARGET_DIR)
	@erlc -Wall -Werror -o $(TARGET_DIR) $(SRC)

.PHONY: clean
clean:
	@rm -rf $(TARGET_DIR)

