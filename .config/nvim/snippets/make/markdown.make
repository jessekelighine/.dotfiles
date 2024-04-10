# Makefile

MAIN := index
STYLE := style.css

.PHONY: all clean

all: $(MAIN).html

$(MAIN).html: $(MAIN).md $(STYLE)
	pandoc \
		 $(MAIN).md \
		--from markdown+east_asian_line_breaks \
		--toc --number-sections \
		--standalone --mathjax \
		--css $(STYLE) \
		--output $@
		# --embed-resources --standalone --mathjax=mathjax-dynoload.js

FILES  = "*.html"
clean:
	eval "rm -rf ${FILES}"
