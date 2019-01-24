
PAPER_SRC = paper/title.md paper/s1-intro.md
PAPER_PDF = paper.pdf
FLAGS = --toc 
BEFORE_BODY=utils/newpage.tex

all: $(PAPER_PDF)

$(PAPER_PDF): $(PAPER_SRC)
	pandoc -B $(BEFORE_BODY) $(FLAGS) -s -f markdown -t latex -o $@ $^
