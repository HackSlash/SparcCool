YY=bison
YFLAGS=-kdv
YTARGET=parser.cpp
YFILES=parser.ypp

LL=flex
LTARGET=scanner.c
LFILES=scanner.l

PARSE_TARGET=parser_gen.ypp
TREE_TARGET=tree_gen.h

CC=g++
CFILES=$(YTARGET) $(LTARGET) compiler.cpp
CFLAGS=-std=c++11 -Wall -g -lfl
COBJ=parser.o scanner.o compiler.o
TARGET=compiler


all: gen_parser parser scanner tree cpp_obj cpp_exe

gen_parser:
	./create_error.py -i $(YFILES) -o $(PARSE_TARGET)

parser:
	$(YY) $(YFLAGS) -o $(YTARGET) $(PARSE_TARGET)

scanner: parser
	$(LL) -o $(LTARGET) $(LFILES)

tree:
	./create_tree.py -i $(YFILES) -o $(TREE_TARGET)

cpp_obj: scanner parser tree
	$(CC) $(CFILES) -c $(CFLAGS)

cpp_exe: cpp_obj
	$(CC) $(COBJ) -o $(TARGET) $(CFLAGS)

clean:
	rm -rf $(TARGET) $(LTARGET) parser.hpp $(YTARGET) scanner.cpp  parser.output $(TREE_TARGET) $(PARSE_TARGET) $(COBJ)

.PHONY: clean all
