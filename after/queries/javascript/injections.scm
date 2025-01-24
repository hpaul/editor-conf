; extends

(call_expression
  function: (identifier) @_name
  (#eq? @_name "gql")
  arguments: (template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "graphql"))
