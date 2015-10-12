FLEXFILES=cool.flex
BISONFILES=cool.y
CFILES=lex.yy.c
CC=gcc
CFLAGS=-lfl -Wall -g
TARGET=scanner

all: bison flex c

bison:
	bison $(BISONFILES)

flex:
	flex $(FLEXFILES)

c:
	$(CC) $(CFILES) $(CFLAGS) -o $(TARGET)

test: bison flex c
	cat test.cl | ./$(TARGET)

test2: bison flex c
	cat test2.cl | ./$(TARGET)

clean:
	rm $(TARGET) lex.yy.c
