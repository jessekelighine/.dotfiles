# LaTeX Makefile

MAIN := main
NAME :=

.PHONY: all clean compress

all: compress

compress: $(NAME).zip

clean:
	latexmk -C
	rm -rf $(NAME).pdf

$(NAME).zip: $(MAIN).pdf
	zip $(NAME).zip \
		$(NAME).pdf

$(NAME).pdf: $(MAIN).pdf
	cp $(MAIN).pdf $(NAME).pdf

$(MAIN).pdf: $(MAIN).tex .runcode
	# grep -o '.' $(MAIN).tex | rg '[^\x00-\x7F]' | wc -l | xargs echo "Chinese Word Count:"
	latexmk -shell-escape -xelatex -synctex=1 $(MAIN).tex

.runcode: code
	cd bin ; Rscript $(<F) ; cd ..
	touch $@

figures/%.pdf: figures/%.tex
	latexmk -xelatex -outdir=$(<D) $<
