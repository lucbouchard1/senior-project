PAPER_SRC = paper/title.md paper/s1-intro.md paper/references.md
PAPER_PDF = paper.pdf
FLAGS = --toc 
GEOM = -V geometry:margin=1in
BEFORE_BODY = utils/newpage.tex
REFERENCES = references.json

all: $(PAPER_PDF)

$(PAPER_PDF): $(PAPER_SRC) $(BEFORE_BODY) $(REFERENCES) 
	pandoc --bibliography $(REFERENCES) --filter pandoc-citeproc --csl utils/apa.csl \
		-B $(BEFORE_BODY) $(FLAGS) -s -f markdown -t latex -o $@ $(PAPER_SRC)

clean:
	rm -fr $(PAPER_PDF)
