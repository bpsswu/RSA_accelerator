CC = gcc
CFLAGS =
LDFLAGS = -lm

.SUFFIXES : .c .o
.c.o :
	$(CC) -c $(CFLAGS) $<

rsa32: rsa32.o
	$(CC) -o $@ $< $(LDFLAGS)

clean:
	rm -rf rsa32 *.o
