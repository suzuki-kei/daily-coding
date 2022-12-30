
.DEFAULT_GOAL := test

.PHONY: clean
clean:
	rm -rf target

.PHONY: test
test:
	bash src/test/daily-coding.bashrc.test.sh

