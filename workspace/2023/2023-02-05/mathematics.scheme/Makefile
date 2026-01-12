
.DEFAULT_GOAL := test

.PHONY: run
run:
	@gosh -I. mathematics.scm

.PHONY: test
test: \
	test-set \
	test-mathematics

.PHONY: test-set
test-set:
	@gosh -I. set-test.scm

.PHONY: test-mathematics
test-mathematics:
	@gosh -I. mathematics-test.scm

