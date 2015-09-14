FLEXFILES=cool.flex
CFILES=lex.yy.c
CC=gcc
CFLAGS=-lfl

all: flex c

flex: 
	flex $(FLEXFILES)

c:
	$(CC) $(CFILES) $(CFLAGS)

test: flex c
	cat test.cl | ./a.out