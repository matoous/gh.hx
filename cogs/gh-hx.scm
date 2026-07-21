(require-builtin steel/process)
(require-builtin steel/filesystem)
(require "helix/misc.scm")
(require (prefix-in helix.static. "helix/static.scm"))
(require "gh.hx/cogs/gh-core.scm")

(provide github_browse_repo
         github_browse_file
         github_browse_file_at_line
         github_browse_file_blame
         github_view_repo
         github_view_current_pr
         github_create_pr
         github_browse_prs
         github_browse_issues
         github_browse_actions_runs
         github_browse_releases
         github_browse_wiki
         github_browse_settings
         github_open_current_pr_checks)

(define (current-file)
  (helix.static.cx->current-file))

(define (current-dir)
  (let ([file (current-file)])
    (if file
        (parent-name file)
        ".")))

(define (run-gh args label)
  (let* ([child (~> (command "gh" args)
                    (with-current-dir (current-dir))
                    with-stdout-piped
                    spawn-process
                    unwrap-ok)])
    (unwrap-ok (wait->stdout child))
    (set-status! (string-append "gh.hx: " label))))

;;@doc
;; Open the current repository on GitHub.
(define (github_browse_repo)
  (run-gh (list "browse") "opened repository"))

;;@doc
;; Open the focused file on GitHub.
(define (github_browse_file)
  (let ([file (current-file)])
    (if file
        (run-gh (list "browse" (github-file-target file)) "opened file")
        (set-warning! "gh.hx: focused buffer has no file"))))

;;@doc
;; Open the focused file at the cursor line on GitHub.
(define (github_browse_file_at_line)
  (set-warning! "gh.hx: bind this to \":sh gh browse %{buffer_name}:%{cursor_line}\""))

;;@doc
;; Open the focused file's blame view on GitHub.
(define (github_browse_file_blame)
  (let ([file (current-file)])
    (if file
        (run-gh (list "browse" (github-file-target file) "--blame") "opened file blame")
        (set-warning! "gh.hx: focused buffer has no file"))))

;;@doc
;; Open the current repository summary on GitHub.
(define (github_view_repo)
  (run-gh (list "repo" "view" "--web") "opened repository summary"))

;;@doc
;; Open the pull request for the current branch on GitHub.
(define (github_view_current_pr)
  (run-gh (list "pr" "view" "--web") "opened current pull request"))

;;@doc
;; Create a pull request for the current branch.
(define (github_create_pr)
  (run-gh (list "pr" "create" "--web") "opened pull request creation"))

;;@doc
;; Open the current repository's pull requests on GitHub.
(define (github_browse_prs)
  (run-gh (list "pr" "list" "--web") "opened pull requests"))

;;@doc
;; Open the current repository's issues on GitHub.
(define (github_browse_issues)
  (run-gh (list "issue" "list" "--web") "opened issues"))

;;@doc
;; Open the current repository's GitHub Actions runs on GitHub.
(define (github_browse_actions_runs)
  (run-gh (list "browse" "--actions") "opened workflow runs"))

;;@doc
;; Open the current repository's releases on GitHub.
(define (github_browse_releases)
  (run-gh (list "browse" "--releases") "opened releases"))

;;@doc
;; Open the current repository's wiki on GitHub.
(define (github_browse_wiki)
  (run-gh (list "browse" "--wiki") "opened wiki"))

;;@doc
;; Open the current repository's settings on GitHub.
(define (github_browse_settings)
  (run-gh (list "browse" "--settings") "opened settings"))

;;@doc
;; Open the current pull request checks in the browser.
(define (github_open_current_pr_checks)
  (run-gh (list "pr" "checks" "--web") "opened pull request checks"))
