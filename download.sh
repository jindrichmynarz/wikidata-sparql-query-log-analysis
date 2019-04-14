#!/usr/bin/env bash

set -e

wget \
  --accept all.tsv.gz \
  --directory-prefix logs \
  --execute robots=off \
  --level 2 \
  --no-directories \
  --no-parent \
  --no-verbose \
  --recursive \
  https://analytics.wikimedia.org/datasets/one-off/wikidata/sparql_query_logs/
