
.DEFAULT_GOAL := run

go.mod:
	@go mod init localhost
	@go get golang.org/x/crypto/ssh/terminal

.PHONY: run
run: go.mod
	@echo 'Ex) go run main.go one two three'
	@echo 'Ex) seq 10 | go run main.go one two three'

