YY=/opt/bison-3.0.2/bin/bison
YFLAGS=-kdv
YTARGET=parser.cpp
YFILES=parser.ypp

LL=flex
LTARGET=scanner.c
LFILES=scanner.l

CC=g++
CFILES=$(YTARGET) $(LTARGET) compiler.cpp tree.cpp
CFLAGS=-std=c++11 -Wall -g -lfl
COBJ=parser.o scanner.o compiler.o tree.o
TARGET=compiler


all: parser scanner cpp_obj cpp_exe

parser:
	$(YY) $(YFLAGS) -o $(YTARGET) $(YFILES)

scanner: parser
	$(LL) -o $(LTARGET) $(LFILES)


cpp_obj: scanner parser
	$(CC) $(CFILES) -c $(CFLAGS)

cpp_exe: cpp_obj
	$(CC) $(COBJ) -o $(TARGET) $(CFLAGS)

clean:
	rm -rf $(TARGET) $(LTARGET) parser.hpp $(YTARGET) scanner.cpp  parser.output $(TREE_TARGET) $(COBJ)

.PHONY: clean all
