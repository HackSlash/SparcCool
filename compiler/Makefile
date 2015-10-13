FLEXFILES=cool.flex
BISONFILES=cool.y
CFILES=lex.yy.c
CC=gcc
YACC=bison
LEX=flex
CFLAGS=-lfl -Wall -g
YFLAGS=-kdv
TARGET=scanner


all: bison flex c

bison:
	$(YACC) $(YFLAGS) $(BISONFILES)

flex:
	$(LEX) $(FLEXFILES)

c:
	$(CC) $(CFILES) $(CFLAGS) -o $(TARGET)

test: bison flex c
	cat test.cl | ./$(TARGET)

test2: bison flex c
	cat test2.cl | ./$(TARGET)

clean:
	rm $(TARGET) lex.yy.c cool.tab.h cool.tab.c
