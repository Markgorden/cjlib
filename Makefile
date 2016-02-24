CC:=gcc
CFLAG:=-Werror -Wall

OBJS:=cj_array.o

include config.mk

.PHONY: cj_lib clean

ifeq ($(TEST),1)
# compile and testing
cjlib: $(OBJS)
	for obj in $(OBJS); do \
		./$$obj; \
	done

%.o: %.c %.h
	$(CC) $(CFALG) -fno-common -D CJ_TEST $< -o $@
else
# just compile objects and archive them into a library
cjlib: $(OBJS)
	ar rcs cjlib.a $(OBJS)
%.o: %.c %.h
	$(CC) $(CFALG) -c $< -o $@
endif

clean:
	rm -f *.o 
	rm -f cjlib.a
