.PHONY: pres doc

all: pres1 doc1

pres: IntroToContainers.md
	pandoc IntroToContainers.md -f markdown -t beamer --slide-level=3 --lua-filter=presentation.lua -s -o pres.pdf

doc: IntroToContainers.md
	pandoc IntroToContainers.md -f markdown  --lua-filter=document.lua -s -o doc.pdf

pres1: simple.md
	pandoc simple.md -f markdown -t beamer --slide-level=3 --lua-filter=presentation.lua -s -o pres.pdf

doc1: simple.md
	pandoc simple.md -f markdown  --lua-filter=document.lua -s -o doc.pdf
