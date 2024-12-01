;; Write your query here like `(node) @capture`,
;; put the cursor under the capture to highlight the matches.
;; extends

(expression_statement
  (assignment
    (identifier)
    (string
      (string_content) @injection.content
      (#contains? @injection.content "mutation")
      (#set! injection.language "graphql")
    )
  )
)

(expression_statement
  (assignment
    (identifier)
    (string
      (string_content) @injection.content
      (#contains? @injection.content "query")
      (#set! injection.language "graphql")
    )
  )
)
