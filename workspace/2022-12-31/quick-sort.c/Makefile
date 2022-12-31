
SRC := main.c
OUT := main.out

.PHONY: build
build:
	gcc -Wall -o $(OUT) $(SRC)

.PHONY: clean
clean:
	rm -f $(OUT)

.PHONY: run
run: build
	./$(OUT)

