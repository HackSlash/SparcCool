YY=bison
YFLAGS=-kdv
YTARGET=parser.cpp
YFILES=parser.ypp

LL=flex++
LTARGET=scanner.cpp
LFILES=scanner.l

PY=python2
PFILES=create_tree.py

CC=g++
CFILES=parser.cpp scanner.cpp compiler.cpp
CFLAGS=-std=c++11 -lfl -Wall -g
COBJ=parser.o scanner.o compiler.o
TARGET=compiler


all: parser scanner tree cpp_obj cpp_exe

parser:
	$(YY) $(YFLAGS) -o $(YTARGET) $(YFILES)

scanner: parser
	$(LL) -o $(LTARGET) $(LFILES)

tree:
	$(PY) $(PFILES)

cpp_obj: scanner parser tree
	$(CC) $(CFILES) -c $(CFLAGS)

cpp_exe: cpp_obj
	$(CC) $(COBJ) -o $(TARGET) $(CFLAGS)

clean:
	rm -rf $(TARGET) $(LTARGET) parser.hpp $(YTARGET) parser.output tree_gen.h $(COBJ)

.PHONY: clean