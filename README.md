[![.github/workflows/main.yml](https://github.com/johntfoster/CV/actions/workflows/main.yml/badge.svg)](https://github.com/johntfoster/CV/actions/workflows/main.yml)

Source files with PDF and HTML versions of Curriculum Vita.

To build versions run:

```
docker run -it -v $PWD:/usr/src/app -w /usr/src/app johntfoster/texlive latexmk cv.tex
docker run -it -v $PWD:/usr/src/app -w /usr/src/app johntfoster/texlive latexmk -pdf cv.tex
docker run -it -v $PWD:/usr/src/app -w /usr/src/app johntfoster/texlive latexmk -pdfxe cv.tex
```




