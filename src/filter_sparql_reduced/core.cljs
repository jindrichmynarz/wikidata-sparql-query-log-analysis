(ns filter-sparql-reduced.core
  (:require [goog.string :refer [urlDecode]]
            [sparqljs :refer [Parser]])) 

(def parse-query
  "Parse SPARQL `query` string."
  (let [parser (Parser.)]
    (fn [query]
      (try (-> parser
               (.parse query)
               (js->clj :keywordize-keys true))
           (catch js/Error _)))))

(def has-reduced?
  "Test if parsed SPARQL `query` uses the REDUCED clause"
  (letfn [(children [query]
            (mapcat (some-fn :patterns vector) (:where query)))]
    (fn [query]
      (->> query
           (tree-seq map? children)
           (some :reduced)))))

(defn main
  "Print `line` when it is a URL-encoded SPARQL query containing REDUCED."
  [line]
  (when-let [query (parse-query (urlDecode line))]
    (when (has-reduced? query)
      (println line))))

(defn -main
  [& _]
  (let [readline (js/require "readline")
        rl (.createInterface readline #js {:input js/process.stdin
                                           :output js/process.stdout
                                           :terminal false})]
    (.on rl "line" main)))

(set! *main-cli-fn* -main)
