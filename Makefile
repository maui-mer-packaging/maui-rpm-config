NAME=meego-rpm-config
VERSION = $(shell cat VERSION)
TAGVER = $(shell cat VERSION | sed -e "s/\([0-9\.]*\).*/\1/")

ifeq ($(VERSION), $(TAGVER))
        TAG = $(TAGVER)
else
        TAG = "HEAD"
endif

all:

clean:
	rm -f *~ 

install:
	mkdir -p $(DESTDIR)/usr/lib/rpm/meego
	cp -pr * $(DESTDIR)/usr/lib/rpm/meego/
	rm -f $(DESTDIR)/usr/lib/rpm/meego/Makefile
	rm -f $(DESTDIR)/usr/lib/rpm/meego/meego-rpm-config.spec

tag-archive:
	git tag -a $(VERSION)

create-archive:
	git archive --format=tar --prefix=meego-rpm-config-$(VERSION)/ HEAD | bzip2 -9v > meego-rpm-config-$(VERSION).tar.bz2
	@echo "The final archive is in $(NAME)-$(VERSION).tar.bz2"

archive: tag-archive create-archive
dist: create-archive
