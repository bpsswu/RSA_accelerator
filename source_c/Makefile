CC = gcc
CFLAGS =
LDFLAGS = -lm

.SUFFIXES : .c .o
.c.o :
	$(CC) -c $(CFLAGS) $<

ALL = rsa32 MM

all: $(ALL)

rsa32: rsa32.o
	$(CC) -o $@ $< $(LDFLAGS)

MM: MM.o
	$(CC) -o $@ $< $(LDFLAGS)	

clean:
	rm -rf rsa32 *.o
