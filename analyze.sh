#!/usr/bin/env bash

set -e

die () {
  echo >&2 "$@"
  exit 1
}

command -v node >/dev/null 2>&1 ||
die "Please install Node.js as node (e.g., brew install nodejs)!"

[ -f out/filter_sparql_reduced.js ] ||
die "Please compile via ./build.sh first!"

count () {
  gzip -cd ${1} |
  wc -l
}
export -f count

count_reduced () {
  gzip -cd ${1} |
  cut -f 1 |
  grep -i REDUCED |
  node out/filter_sparql_reduced.js |
  wc -l
}
export -f count_reduced

NUM_CPUS=$(sysctl hw.logicalcpu | cut -d " " -f 2) # OSX-specific
FILES=$(find logs -name "*.tsv.gz")
NUM_FILES=$(echo "$FILES" | wc -l)

# Count queries

echo "$FILES" |
xargs \
  -n 1 \
  -P ${NUM_CPUS} \
  -I {} \
  bash -c 'count "$@"' _ {} |
(cat && printf -- '-%d\n' ${NUM_FILES}) |
awk '{s+=$1} END {printf "%.0f", s}'

# Count queries containing REDUCED

echo "$FILES" |
xargs \
  -n 1 \
  -P ${NUM_CPUS} \
  -I {} \
  bash -c 'count_reduced "$@"' _ {} |
awk '{s+=$1} END {printf "%.0f", s}'
