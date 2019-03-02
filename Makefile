PAPER_SRC = paper/title.md paper/s1-intro.md
PAPER_PDF = paper.pdf
FLAGS = --toc 
GEOM = -V geometry:margin=1in
BEFORE_BODY=utils/newpage.tex

all: $(PAPER_PDF)

$(PAPER_PDF): $(BEFORE_BODY) bib.json
	pandoc --bibliography bib.json --filter pandoc-citeproc --csl utils/apa.csl \
		-B $(BEFORE_BODY) $(FLAGS) -s -f markdown -t latex -o $@ $(PAPER_SRC)

clean:
	rm -fr $(PAPER_PDF)
