$latex = 'latex -shell-esc -interaction=nonstopmode %O \\\def\\\ispdf{1} \\\input %S';
$pdflatex = 'htlatex %S "myfonts, -css, NoFonts"';
$xelatex = 'xelatex -shell-esc -interaction=nonstopmode %O \\\def\\\iscockrell{1} \\\input %S';
$pdf_mode = 5;  # use xelatex
$postscript_mode = 0;
$view = 'pdf';
$pdf_previewer = 'open -a /Applications/TeX/TeXShop.app';
$clean_ext = 'spl loc vrb m9 nav run.xml snm bbl synctex.gz tmp xref 4ct 4tc lg idv html fls';
