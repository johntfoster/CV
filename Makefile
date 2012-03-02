SHELL=/bin/sh

basename=cv

.PHONY: clean veryclean

all: filename=${basename}
html: filename=${basename}_html
short: filename=${basename}_short

all: pdf clean

short: shorten pdf clean

html: htmlify clean

pdf:
	pdflatex  ${filename} ; \
	pdflatex  ${filename} ; \
	pdflatex  ${filename} ; \
	bibtex ${filename} || true ; \
	pdflatex  ${filename} ; \
	pdflatex  ${filename} ;

htmlify:
	sed 's"\\usepackage\[urw"%\\usepackage\[urw"g' ${basename}.tex > ${filename}.tex ; \
	latex  ${filename} ; \
	latex  ${filename} ; \
	latex  ${filename} ; \
	bibtex ${filename} || true ; \
	latex  ${filename} ; \
	latex  ${filename} ; \
	htlatex ${filename} "html"; 

shorten:
	sed 's"\\input{sections/conf_proceedings"%\\input{sections/conf_proceedings"g' ${basename}.tex > ${filename}.tex ; \
	sed -i '' 's"\\input{sections/tech_reports"%\\input{sections/tech_reports"g' ${filename}.tex ; \
	sed -i '' 's"\\input{sections/oral_presentations"%\\input{sections/oral_presentations"g' ${filename}.tex ; \
	sed -i '' 's"\\input{sections/other"%\\input{sections/other"g' ${filename}.tex ;

veryclean:
	rm -f *.ps *.pdf *.log *.aux *.out *.dvi *.bbl *.blg *_short* *_html* *.4ct *.lg *.css *.idv *.tmp *.xref

clean:
	rm -f ${filename}.ps ${filename}.log ${filename}.aux ${filename}.out ${filename}.dvi ${filename}.bbl ${filename}.blg ${filename}.4ct ${filename}.4tc ${filename}.lg ${filename}.idv ${filename}.tmp ${filename}.xref
		
