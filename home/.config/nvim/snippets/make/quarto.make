# Makefile

MAIN := main
STYLE := style.css

.PHONY: all clean

all: $(MAIN).html

$(MAIN).html: $(MAIN).qmd $(STYLE)
	quarto render $< --to html --output $(MAIN).html

FILES  = "*.html"
clean:
	eval "rm -rf ${FILES}"
