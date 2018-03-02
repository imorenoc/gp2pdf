reset

set xlab "$x$"
set ylab "$f(x)$"
set xtics("0" 0, "$\\pi/2$" pi/2, "$\\pi$" pi, "$3\\pi/2$" 3*pi/2, "$2 \\pi$" 2*pi)
set xrange[0:7]

f(x) = sin(x)

plot f(x)

