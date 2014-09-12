Source files with PDF and HTML versions of Curriculum Vita.

To build

````
latexmk -pdfps -latex=latex -shell-esc -interaction=nonstopmode %O \def\ispdf{1} \input %S  cv.tex
htlatex cv.tex
````


