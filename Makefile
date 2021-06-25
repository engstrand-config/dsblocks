PREFIX := /usr/local

CC := gcc
CFLAGS := -O3 -Wall -Wextra

DEPCFLAGS := $(shell pkg-config --cflags gio-2.0 libmpdclient)
DEPLIBS := $(shell pkg-config --libs gio-2.0 libmpdclient)
X11CFLAGS := $(shell pkg-config --cflags x11)
X11LIBS := $(shell pkg-config --libs x11)

BLOCKS := $(wildcard blocks/*.c)

all: dsblocks sigdsblocks/sigdsblocks xgetrootname/xgetrootname

dsblocks.o: dsblocks.c blocks.h shared.h
	${CC} -o $@ -c ${CFLAGS} -Wno-missing-field-initializers -Wno-unused-parameter ${X11CFLAGS} ${DEPCFLAGS} $<

util.o: util.c util.h shared.h
	${CC} -o $@ -c ${CFLAGS} ${X11CFLAGS} ${DEPCFLAGS} $< ${DEPLIBS} ${X11LIBS}

blocks/%.o: blocks/%.c blocks/%.h util.h shared.h
	${CC} -o $@ -c ${CFLAGS} -Wno-unused-parameter ${DEPCFLAGS} ${X11CFLAGS} $< ${DEPLIBS} ${X11LIBS}

dsblocks: dsblocks.o util.o ${BLOCKS:c=o}
	${CC} -o $@ $^ ${X11LIBS} ${DEPLIBS}

sigdsblocks/sigdsblocks: sigdsblocks/sigdsblocks.c
	${CC} -o $@ ${CFLAGS} ${X11CFLAGS} $< ${X11LIBS}

xgetrootname/xgetrootname: xgetrootname/xgetrootname.c
	${CC} -o $@ ${CFLAGS} ${X11CFLAGS} $< ${X11LIBS}

clean:
	rm -f blocks/*.o *.o dsblocks sigdsblocks/sigdsblocks xgetrootname/xgetrootname

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	install -m 0755 dsblocks ${DESTDIR}${PREFIX}/bin/dsblocks
	install -m 0755 sigdsblocks/sigdsblocks ${DESTDIR}${PREFIX}/bin/sigdsblocks
	install -m 0755 xgetrootname/xgetrootname ${DESTDIR}${PREFIX}/bin/xgetrootname

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dsblocks ${DESTDIR}${PREFIX}/bin/sigdsblocks ${DESTDIR}${PREFIX}/bin/xgetrootname

.PHONY: all clean install uninstall
