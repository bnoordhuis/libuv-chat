# Copyright (c) 2012, Ben Noordhuis <info@bnoordhuis.nl>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

CFLAGS = -Ideps/uv/include -Wall -Wextra -Wno-unused-parameter
LDFLAGS = -lm

ifeq ($(shell uname),Darwin)
LDFLAGS += -framework CoreServices
endif

ifeq ($(shell uname),Linux)
LDFLAGS += -lrt
endif

.PHONY:	all clean

all:	chat-server

clean:
	rm -f chat-server src/main.o
	$(MAKE) $@ -C deps/uv

chat-server:	src/main.o deps/uv/libuv.a
	$(CC) $^ -o $@ $(LDFLAGS)

deps/uv/libuv.a:
	$(MAKE) all -C deps/uv
