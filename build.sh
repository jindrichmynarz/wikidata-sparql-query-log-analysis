#!/usr/bin/env bash

set -e

die () {
  echo >&2 "$@"
  exit 1
}

command -v clj >/dev/null 2>&1 ||
die "Please install clj (e.g., brew install clojure)!"

clj \
  --main cljs.main \
  --compile-opts build.edn \
  --verbose \
  --compile
