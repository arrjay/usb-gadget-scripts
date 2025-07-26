PREFIX = /usr/local
DEFREV = 0.$(shell date +%s)
ifeq ($(CODEREV),)
CODEREV = $(DEFREV)
endif

install: $(DESTDIR)$(PREFIX)/lib/systemd/system build/systemd-system/usb-gadget-base.service
	install -m 0644 build/systemd-system/usb-gadget-base.service $(DESTDIR)$(PREFIX)/lib/systemd/system/usb-gadget-base.service
	install -m 0644 src/systemd-system/usb-gadget-finalize.service $(DESTDIR)$(PREFIX)/lib/systemd/system/usr-gadget-finalize.service

build/systemd-system/%.service: src/systemd-system/%.service.in
	mkdir -p $(@D)
	sed -e 's@PREFIX@$(PREFIX)@g' < $< > $@

$(DESTDIR)$(PREFIX)/lib/systemd/system:
	install -d $@

debian/changelog: .git
	-rm $@
	EMAIL=code@xylate.net dch --create --package usb-gadget-scripts -v $(CODEREV) "$(shell git log)"

debian/control: debian/changelog debian/control.in
	sed -e 's@CODEREV@$(CODEREV)@g' < debian/control.in > $@

deb: debian/control
	dpkg-buildpackage -b
