$latex = 'latex -shell-esc -interaction=nonstopmode %O \\\def\\\ispdf{1} \\\input %S';
$pdfxelatex = 'latex -shell-esc -interaction=nonstopmode %O \\\def\\\iscockrell{1} \\\input %S' -jobname="cv_cockrell"
$pdflatex = 'htlatex %S "myfonts, -css, NoFonts"';
$pdf_mode = 2;
$view = 'pdf';
$pdf_previewer = 'open -a /Applications/TeX/TeXShop.app';
$clean_ext = 'spl loc vrb m9 nav run.xml snm bbl synctex.gz tmp xref 4ct 4tc lg idv html fls';
