MELANGE=melange

all: ext/libgit2/libgit2.a build

.PHONY: build

INTERFACE_FILES = $(wildcard *.intr)
GENERATED_DYLAN_FILES = $(INTERFACE_FILES:.intr=.dylan)

UNAME := $(shell uname)

ifeq ($(UNAME), Darwin)
  EXTRA_CFLAGS="-arch i386 -arch x86_64"
endif

%.dylan: %.intr
	$(MELANGE) -Tc-ffi -Iext/libgit2/include $< $@

ext/libgit2/libgit2.a:
	$(MAKE) -C ext/libgit2 -f Makefile.embed EXTRA_CFLAGS=$(EXTRA_CFLAGS)

build: $(GENERATED_DYLAN_FILES)
	dylan-compiler -build libgit2

test: $(GENERATED_DYLAN_FILES)
	rm -rf temp_*
	dylan-compiler -build libgit2-test-suite-app
	_build/bin/libgit2-test-suite-app

clean:
	$(MAKE) -C ext/libgit2 -f Makefile.embed clean
