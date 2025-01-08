PREFIX ?= usr/local
DESTDIR ?= /

dsp_files = $(wildcard *.dsp)
targets = $(dsp_files:%.dsp=%.lv2)

all: $(targets)

%.lv2: %.dsp
	faust2lv2 -nomidicc -uri-prefix "https://dfdx.eu/lv2/fps-faust-plugins.lv2" $<

install:
	install -d $(DESTDIR)/${PREFIX}/lib/lv2
	cp -r $(targets) $(DESTDIR)/${PREFIX}/lib/lv2

uninstall:
	for n in $(targets); do echo Removing: $(DESTDIR)/$(PREFIX)/lib/lv2/"$$n"; rm -rvf $(DESTDIR)/$(PREFIX)/lib/lv2/"$$n"; done
