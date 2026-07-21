(provide github-file-target
         github-file-line-target
         github-command-label)

(define (github-file-target file)
  file)

(define (github-file-line-target file line)
  (string-append file ":" (number->string line)))

(define (github-command-label args)
  (if (null? args)
      "gh"
      (foldl (lambda (arg result) (string-append result " " arg))
             "gh"
             args)))
