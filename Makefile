all: analizador
analizador: src/main.s
	as --64 -o main.o $<
	ld -o $@ main.o
test: analizador
	python3 tests/test.py
clean:
	rm -f main.o analizador
.PHONY: all test clean
