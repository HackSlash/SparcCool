FLEXFILES=cool.flex
CFILES=lex.yy.c
CC=gcc
CFLAGS=-lfl -Wall -g
TARGET=scanner

all: flex c

flex: 
	flex $(FLEXFILES)

c:
	$(CC) $(CFILES) $(CFLAGS) -o $(TARGET)

test: flex c
	cat test.cl | ./$(TARGET)

test2: flex c
	cat test2.cl | ./$(TARGET)

clean:
	rm $(TARGET) lex.yy.c
