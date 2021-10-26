
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

documents/%.pdf: %.md $(FIGURES) documents/header.yaml pandoc.make | documents
	pandoc documents/header.yaml $< -o $@ $(PANDOCFLAGS)

documents/%.epub: %.md $(FIGURES) pandoc.make | documents
	pandoc $< -o $@ $(PANDOCFLAGS)

documents:
	mkdir ./documents

clean: phony
	rm -rf ./documents

open: phony documents/readme.pdf
	evince documents/readme.pdf

# pandoc -o documents.pdf readme.md  --template documents/my_eisvogel.latex --listings -V lang=en
