#!/usr/bin/env sh
# Plot UCLAP execution-time data recorded by the tests' timer.
#
# usage:
#   scripts/plot_times.sh [csv] [out.png]
#
# defaults:
#   csv = tests/.data/execution_times.csv (falls back to .data/execution_times.csv)
#   out = times_plot.png

set -eu

root="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

csv="${1:-}"
out="${2:-times_plot.png}"

if [ -z "$csv" ]; then
  if [ -f "$root/tests/.data/execution_times.csv" ]; then
    csv="$root/tests/.data/execution_times.csv"
  elif [ -f "$root/.data/execution_times.csv" ]; then
    csv="$root/.data/execution_times.csv"
  else
    echo "error: no execution_times.csv found (looked in tests/.data and .data)" >&2
    echo "       run the tests first, or pass a csv path." >&2
    exit 1
  fi
fi

if [ ! -f "$csv" ]; then
  echo "error: csv not found: $csv" >&2
  exit 1
fi

if ! command -v gnuplot >/dev/null 2>&1; then
  echo "error: gnuplot is not installed" >&2
  exit 1
fi

echo "plotting $csv -> $out"
exec gnuplot -e "csv='$csv'; out='$out'" "$root/scripts/plot_times.gp"