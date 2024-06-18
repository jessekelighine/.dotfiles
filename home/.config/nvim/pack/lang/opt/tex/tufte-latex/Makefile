# Latex Makefile

MAIN := main
NAME := tufte-example

.PHONY: all clean

all: $(NAME).pdf

clean:
	latexmk -C
	rm -rf $(NAME).pdf

$(NAME).pdf: $(MAIN).pdf
	cp $(MAIN).pdf $(NAME).pdf

$(MAIN).pdf: $(MAIN).tex *.sty
	latexmk -xelatex -synctex=1 $(MAIN).tex
