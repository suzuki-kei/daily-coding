
.PHONY: main
main:
	@$(call execute,$@)

.PHONY: struct
struct:
	@$(call execute,$@)

.PHONY: hello
hello:
	@$(call execute,$@)

define execute
	rustc -D warnings -A dead-code -o $1 $1.rs && ./$1 && rm -rf $1
endef

