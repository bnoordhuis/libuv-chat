CFLAGS = -Ideps/uv/include -Wall -Wextra -Wno-unused-parameter
LDFLAGS = -lm -lrt

.PHONY:	all clean

all:	chat-server

clean:
	rm -f chat-server src/main.o
	$(MAKE) $@ -C deps/uv

chat-server:	src/main.o deps/uv/libuv.a
	$(CC) $^ -o $@ $(LDFLAGS)

deps/uv/libuv.a:
	$(MAKE) all -C deps/uv
