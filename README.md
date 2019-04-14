# REDUCED in Wikidata SPARQL query logs

How often is the [`REDUCED`](https://www.w3.org/TR/sparql11-query/#modReduced) solution modified used in [Wikidata SPARQL query logs](https://analytics.wikimedia.org/datasets/one-off/wikidata/sparql_query_logs/)?

Also an exercise with using [ClojureScript](https://clojurescript.org) on Node.js.

1. Build the script to filter queries containing `REDUCED`: `./build.sh`
2. Download the logs: `./download.sh`
3. Analyze the logs: `./analyze.sh`

As of April 14, 2019, `REDUCED` appears in 0.0004 % of the 654M queries.
