(require "../cogs/gh-core.scm")

(define (check label actual expected)
  (when (not (equal? actual expected))
    (error! (string-append label ": expected " expected ", got " actual))))

(check "file target" (github-file-target "README.md") "README.md")
(check "file line target" (github-file-line-target "README.md" 12) "README.md:12")
(check "empty command label" (github-command-label '()) "gh")
(check "command label" (github-command-label (list "pr" "checks" "--web")) "gh pr checks --web")
