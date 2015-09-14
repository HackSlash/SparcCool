FLEXFILES=cool.flex
CFILES=lex.yy.c
CC=gcc
CFLAGS=-lfl
TARGET=scanner

all: flex c

flex: 
	flex $(FLEXFILES)

c:
	$(CC) $(CFILES) $(CFLAGS) -o $(TARGET)

test: flex c
	cat test.cl | ./$(TARGET)

clean:
	rm $(TARGET) lex.yy.c