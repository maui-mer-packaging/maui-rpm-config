NAME=maui-rpm-config
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
	mkdir -p $(DESTDIR)/usr/lib/rpm/maui
	cp -pr * $(DESTDIR)/usr/lib/rpm/maui/
	rm -f $(DESTDIR)/usr/lib/rpm/maui/Makefile
	rm -f $(DESTDIR)/usr/lib/rpm/maui/maui-rpm-config.spec

tag-archive:
	git tag -a $(VERSION)

create-archive:
	git archive --format=tar --prefix=maui-rpm-config-$(VERSION)/ HEAD | bzip2 -9v > maui-rpm-config-$(VERSION).tar.bz2
	@echo "The final archive is in $(NAME)-$(VERSION).tar.bz2"

archive: tag-archive create-archive
dist: create-archive
