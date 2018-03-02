#!/bin/bash

name=`basename $1`

name=${name%.gp}

echo "load '$name.gp'
set terminal epsl col sol lw 2
set output '${name}.tex'
rep" | gnuplot

# Genera el archivo fig.tex
echo '\documentclass{article}' > fig.tex
echo '\usepackage{graphicx}' >> fig.tex
echo '\usepackage{color}' >> fig.tex
echo '\usepackage{amsmath}' >> fig.tex
echo '\usepackage{amssymb}' >> fig.tex
echo '\renewcommand{\v}[1]{{\boldsymbol #1}}'  >> fig.tex
echo '' >> fig.tex
echo '\newcommand{\PROM}[1]{\left\langle #1\right\rangle}' >> fig.tex
echo '\pagestyle{empty}' >> fig.tex
echo '\begin{document}' >> fig.tex
echo '\large' >> fig.tex
echo '\input{'$name'}' >> fig.tex
echo '' >> fig.tex
echo '\end{document}' >> fig.tex

## Latex to Pdf
latex fig
dvips -E fig -o fig.eps
epstopdf fig.eps -o "$name".pdf
rm "$name".eps

pdfcrop "$name".pdf
mv "$name"-crop.pdf "$name".pdf

rm "$name".tex
rm fig.aux fig.dvi fig.tex fig.log
rm fig.eps
evince "$name".pdf &
