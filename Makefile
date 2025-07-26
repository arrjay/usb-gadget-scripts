PREFIX = /usr/local
NOW = $(shell date +%s)

install: $(DESTDIR)$(PREFIX)/lib/systemd/system
	install -m 0644 src/systemd-system/usb-gadget-base.service $(DESTDIR)$(PREFIX)/lib/systemd/system/usb-gadget-base.service
	install -m 0644 src/systemd-system/usb-gadget-finalize.service $(DESTDIR)$(PREFIX)/lib/systemd/system/usr-gadget-finalize.service

$(DESTDIR)$(PREFIX)/lib/systemd/system:
	install -d $@

debian/changelog: .git
	-rm $@
	EMAIL=code@xylate.net dch --create --package usb-gadget-scripts -v 0.$(NOW) "$(shell git log)"

debian/control: debian/changelog debian/control.in
	sed -e 's@CODEREV@$(NOW)@g' < debian/control.in > $@
