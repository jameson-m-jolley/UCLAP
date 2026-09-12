# UCLAP execution-times plotter
#
# usage:
#   gnuplot -e "csv='FILE.csv'; out='out.png'" scripts/plot_times.gp
#   (or gnuplot scripts/plot_times.gp with defaults below)
#
# defaults: csv=tests/.data/execution_times.csv  out=times_plot.png
# reads the `name,time` (ms) rows RecordTimeDelta appends to the csv,
# writes a two-panel PNG: a per-function timeline (µs, log y) and a
# per-function candlestick/boxplot (min / q1 / median / q3 / max).

if (!exists("csv")) { csv = "tests/.data/execution_times.csv"; if (ARGC >= 1) csv = ARG1 }
if (!exists("out")) { out = "times_plot.png"; if (ARGC >= 2) out = ARG2 }

if (system(sprintf("test -f '%s' && echo yes || echo no", csv)) ne "yes") {
  print sprintf("ERROR: csv not found: %s", csv)
  exit 1
}

system("rm -f /tmp/uclap_*.dat 2>/dev/null")

# one raw file per function:  index<TAB>title<TAB>microseconds
system(sprintf("awk -F, 'NR>1{print (NR-1), $1, $2*1000 > sprintf(\"/tmp/uclap_%%s.dat\", $1)}' '%s'", csv))

names = system("ls /tmp/uclap_*.dat 2>/dev/null | sed -E 's#^/tmp/uclap_##; s#\\.dat$##' | sort")
if (words(names) == 0) {
  print "ERROR: no data rows in csv"
  exit 1
}

# per-name percentiles (nearest-rank), one line: name min q1 med q3 max count
system("for f in /tmp/uclap_*.dat; do n=$(basename \"$f\" .dat); sort -k3,3n \"$f\" | awk -v nm=\"$n\" '{v[NR]=$3} END{n=NR; printf \"%s\\t%.3f\\t%.3f\\t%.3f\\t%.3f\\t%.3f\\t%d\\n\", nm, v[1], v[int(0.25*(n+1)+0.999)], v[int(0.5*(n+1)+0.999)], v[int(0.75*(n+1)+0.999)], v[n], n}' ; done | sort -k3,3n > /tmp/uclap_stats.dat")

set term pngcairo size 1600,1050 font ",11"
set output out
set datafile separator whitespace
set bars 0.5
set multiplot layout 2,1 margins 0.12,0.98,0.12,0.95 spacing 0.13

# --- Panel 1: timeline -----------------------------------------------
set title "Per-function timeline  (warm-up spike = first sample of each run)"
set xlabel "sample index"
set ylabel "time (µs)"
set logscale y
set yrange [1:200]
set grid ytics
set key outside right top
ptlist = "1 2 3 4 5 6 7 8 9 10 11 12 13"
plot for [i=1:words(names)] sprintf('/tmp/uclap_%s.dat', word(names, i)) using 1:3 with points pt word(ptlist, i) ps 0.9 lc i title word(names, i)

# --- Panel 2: box plot ------------------------------------------------
unset logscale y
unset key
set title "Per-function distribution  (box = q1..q3, whiskers = min..max, dot = median)"
set xlabel ""
set ylabel "time (µs)"
set xtics nomirror rotate by -25 right
set grid ytics
plot '/tmp/uclap_stats.dat' using 0:3:2:6:5:xtic(1) with candlesticks lt 1 lc rgb '#4682b4' title 'range', \
     '' using 0:4 with points pt 7 lc rgb '#b22222' ps 0.8 title 'median'

unset multiplot
unset output
system("rm -f /tmp/uclap_*.dat 2>/dev/null")
print sprintf("wrote %s (%d functions)", out, words(names))