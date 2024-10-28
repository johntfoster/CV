$latex = 'latex -shell-esc -interaction=nonstopmode %O \\\def\\\ispdf{1} \\\input %S';
$pdflatex = 'htlatex %S "myfonts, -css, NoFonts"';
$lualatex = 'lualatex -shell-esc -interaction=nonstopmode %O \\\def\\\iscockrell{1} \\\input %S';
$clean_ext = 'spl loc vrb m9 nav run.xml snm bbl synctex.gz tmp xref 4ct 4tc lg idv html fls';
