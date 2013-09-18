SHELL=/bin/sh

basename=cv

BASEPATH=/Users/john/Documents/LaTeX/CV
TEXPATH=/usr/local/texlive/2012/bin/x86_64-darwin

.PHONY: clean veryclean

all: filename=${basename}
html: filename=${basename}_html
short: filename=${basename}_short

all: pdf clean

short: shorten pdf clean

html: htmlify clean

pdf:
	${TEXPATH}/pdflatex  ${filename}; \
	${TEXPATH}/pdflatex  ${filename}; \
	${TEXPATH}/pdflatex  ${filename}; \
	${TEXPATH}/bibtex ${filename} || true ; \
	${TEXPATH}/pdflatex  ${filename}; \
	${TEXPATH}/pdflatex  ${filename};

htmlify:
	sed 's"\\usepackage\[urw"%\\usepackage\[urw"g' ${basename}.tex > ${filename}.tex ; \
	sed -i '' 's"%\\usepackage\[html"\\usepackage\[html"g' ${filename}.tex ; \
	sed -i '' 's"%\\HCode"\\HCode"g' ${filename}.tex ; \
	${TEXPATH}/latex  ${filename}; \
	${TEXPATH}/latex  ${filename}; \
	${TEXPATH}/latex  ${filename}; \
	${TEXPATH}/bibtex ${filename} || true ; \
	${TEXPATH}/latex  ${filename}; \
	${TEXPATH}/latex  ${filename}; \
	${TEXPATH}/htlatex ${filename} "${basename}.cfg,html"; 

shorten:
	sed 's"\\input{sections/tech_reports"%\\input{sections/tech_reports"g' ${basename}.tex > ${filename}.tex ; \
	sed -i '' 's"\\input{sections/oral_presentations"%\\input{sections/oral_presentations"g' ${filename}.tex ; \
	sed -i '' 's"\\input{sections/grants"%\\input{sections/grants"g' ${filename}.tex ; \
	sed -i '' 's"\\input{sections/students"%\\input{sections/students"g' ${filename}.tex ; \
	sed -i '' 's"\\input{sections/other"%\\input{sections/other"g' ${filename}.tex ;

	#sed -i '' 's"\\input{sections/tech_reports"%\\input{sections/tech_reports"g' ${filename}.tex ; \
	#sed 's"\\input{sections/conf_proceedings"%\\input{sections/conf_proceedings"g' ${basename}.tex > ${filename}.tex ; \

veryclean:
	rm -f *.ps *.pdf *.log *.aux *.out *.dvi *.bbl *.blg *_short* *_html* *.4ct *.lg *.idv *.tmp *.xref

clean:
	rm -f ${filename}.ps ${filename}.log ${filename}.aux ${filename}.out ${filename}.dvi ${filename}.bbl ${filename}.blg ${filename}.4ct ${filename}.4tc ${filename}.lg ${filename}.idv ${filename}.tmp ${filename}.xref
		
