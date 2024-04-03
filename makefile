PREFIX ?= /usr/local

dsp_files = $(wildcard *.dsp)
targets = $(dsp_files:%.dsp=%.lv2)

all: $(targets)

%.lv2: %.dsp
	faust2lv2 $<

install:
	install -d ${PREFIX}/lib/lv2
	cp -r *.lv2 ${PREFIX}/lib/lv2
