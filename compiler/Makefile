FLEXFILES=cool.flex
BISONFILES=cool.y
CFILES=cool.tab.c lex.yy.cc cool.c
CC=gcc
CXX=g++
YACC=bison
LEX=flex++
CFLAGS=-std=c++11 -lfl -Wall -g
YFLAGS=-kdv
TARGET=scanner


all: bison flex tree cpp

bison:
	$(YACC) $(YFLAGS) $(BISONFILES)

flex: bison
	$(LEX) $(FLEXFILES)

tree:
	python2 create_tree.py

c: flex bison tree
	$(CC) $(CFILES) $(CFLAGS) -o $(TARGET)

cpp: flex bison tree
	$(CXX) $(CFILES) $(CXXFLAGS) -o $(TARGET) 

clean:
	rm $(TARGET) lex.yy.cc cool.tab.h cool.tab.c cool.output
