PREFIX = /usr/local

install: $(PREFIX)/lib/systemd/system
	install -m 0644 src/systemd-system/usb-gadget-base.service $(PREFIX)/lib/systemd/system/usb-gadget-base.service
	install -m 0644 src/systemd-system/usb-gadget-finalize.service $(PREFIX)/lib/systemd/system/usr-gadget-finalize.service

$(PREFIX)/lib/systemd/system:
	install -d $@
