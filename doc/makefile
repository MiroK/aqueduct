.PHONY: all clean

all: aqueduct.pdf

aqueduct.pdf: aqueduct.tex lollipop.tex
	latexmk -pdfps -pdflatex="pdflatex --shell-escape %O %S" $<

view: 
	evince aqueduct.pdf &

clean:
	latexmk -C
