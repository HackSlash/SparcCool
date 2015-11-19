YY=bison
YFLAGS=-kdv
YTARGET=parser.cpp
YFILES=parser.ypp

LL=flex
LTARGET=scanner.c
LFILES=scanner.l

PY=python2
PFILES=create_tree.py
PYTARGET=tree_gen.h

CC=g++
CFILES=$(YTARGET) $(LTARGET) compiler.cpp
CFLAGS=-std=c++11 -Wall -g -lfl
COBJ=parser.o scanner.o compiler.o
TARGET=compiler


all: parser scanner tree cpp_obj cpp_exe

parser:
	$(YY) $(YFLAGS) -o $(YTARGET) $(YFILES)

scanner: parser
	$(LL) -o $(LTARGET) $(LFILES)

tree:
	./create_tree.py -i $(YFILES) -o $(PYTARGET)

cpp_obj: scanner parser tree
	$(CC) $(CFILES) -c $(CFLAGS)

cpp_exe: cpp_obj
	$(CC) $(COBJ) -o $(TARGET) $(CFLAGS)

clean:
	rm -rf $(TARGET) $(LTARGET) parser.hpp $(YTARGET) scanner.cpp  parser.output $(PYTARGET) $(COBJ)

.PHONY: clean all
