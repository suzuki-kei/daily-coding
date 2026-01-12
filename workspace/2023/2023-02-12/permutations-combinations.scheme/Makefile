
.DEFAULT_GOAL := test

.PHONY: test
test: \
	test-set \
	test-permutations-combinations

.PHONY: test-set
test-set:
	@gosh -I. set-test.scm

.PHONY: test-permutations-combinations
test-permutations-combinations:
	@gosh -I. permutations-combinations-test.scm

