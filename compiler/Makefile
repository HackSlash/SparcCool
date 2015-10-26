FLEXFILES=cool.flex
BISONFILES=cool.y
CFILES=lex.yy.c
CC=g++
YACC=bison
LEX=flex
CFLAGS=-std=gnu++11 -lfl -Wall -g
YFLAGS=-kdv
TARGET=scanner


all: bison flex tree c

bison:
	$(YACC) $(YFLAGS) $(BISONFILES)

flex: bison
	$(LEX) $(FLEXFILES)

tree:
	python2 create_tree.py

c: flex bison tree
	$(CC) $(CFILES) $(CFLAGS) -o $(TARGET)

test: bison flex tree c
	cat test.cl | ./$(TARGET)

test2: bison flex tree c
	cat test2.cl | ./$(TARGET)

clean:
	rm $(TARGET) lex.yy.c cool.tab.h cool.tab.c cool.output
