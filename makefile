PREFIX ?= usr/local
DESTDIR ?= /

dsp_files = $(wildcard *.dsp)
targets = $(dsp_files:%.dsp=%.lv2)

all: $(targets)

%.lv2: %.dsp
	faust2lv2 $<

install:
	install -d $(DESTDIR)${PREFIX}/lib/lv2
	cp -r *.lv2 $(DESTDIR)${PREFIX}/lib/lv2
