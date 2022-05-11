
.PHONY: phony

FIGURES = $(shell find . -name '*.svg') $(shell find documents -name '*.svg') 

PANDOCFLAGS =                        \
  --number-sections                  \
  --highlight-style=monochrome       \
  -V mainfont="Palatino"             \
  -V papersize=A4                    \
  -V geometry:margin=1in \
  --template documents/my_eisvogel.latex \
#   -V documentclass=report            \
#   --from=markdown                    \
#   --table-of-contents                \
#   --pdf-engine=xelatex               

all: phony documents/README.pdf

documents/README.pdf: documents/remove_first_line.md $(FIGURES) pandoc.make | documents
	pandoc documents/pandoc_header.yaml $< -o $@ $(PANDOCFLAGS)

documents/remove_first_line.md: README.md
	tail -n +2 $< > $@

documents/%.epub: %.md $(FIGURES) pandoc.make | documents
	pandoc $< -o $@ $(PANDOCFLAGS)

documents:
	mkdir ./documents

clean: phony
	rm -rf ./documents/README.pdf documents/remove_first_line.md

open: phony documents/README.pdf
	evince documents/README.pdf

# pandoc -o documents.pdf README.md  --template documents/my_eisvogel.latex --listings -V lang=en
