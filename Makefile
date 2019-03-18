PAPER_SRC = paper/title.md paper/s1-intro.md paper/s2-physics.md paper/s3-kalman-filter.md paper/s4-software-architecture.md paper/references.md
PAPER_PDF = paper.pdf
FLAGS = --toc --number-sections
GEOM = -V geometry:margin=1in
BEFORE_BODY = utils/newpage.tex
REFERENCES = references.json
TEMPLATE=utils/template.latex

all: $(PAPER_PDF)

$(PAPER_PDF): $(PAPER_SRC) $(BEFORE_BODY) $(REFERENCES) $(TEMPLATE)
	pandoc --template=$(TEMPLATE) --bibliography $(REFERENCES) --filter pandoc-citeproc --csl utils/apa.csl \
		-B $(BEFORE_BODY) $(FLAGS) -s -f markdown -t latex -o $@ $(PAPER_SRC)

clean:
	rm -fr $(PAPER_PDF)
