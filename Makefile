CC      = clang
AR      = ar
LIBS    = glfw
CFLAGS  = -Wall -Wextra -Werror -std=c17 -O3 -DGLFW_INCLUDE_NONE
LDFLAGS = $(foreach lib,$(LIBS),-l$(lib))
LIBNAME = glfw3webgpu
LIBFILE = lib$(LIBNAME).a
PREFIX  = /usr/local
UNAME   = $(shell uname)

ifeq ($(UNAME), Darwin)
	LDFLAGS += -framework Cocoa -framework CoreVideo -framework IOKit -framework QuartzCore
	CFLAGS  += -x objective-c -DGLFW_EXPOSE_NATIVE_COCOA
endif

install: lib
	install -d $(PREFIX)/lib
	install -d $(PREFIX)/include/webgpu
	install -m 644 build/$(LIBFILE) $(PREFIX)/lib
	install -m 644 glfw3webgpu.h $(PREFIX)/include/webgpu

lib : build/glfw3webgpu.o
	$(AR) rcs build/$(LIBFILE) build/glfw3webgpu.o

build/glfw3webgpu.o : build glfw3webgpu.c
	$(CC) $(CFLAGS) -c glfw3webgpu.c -o build/glfw3webgpu.o

build :
	mkdir -p build
