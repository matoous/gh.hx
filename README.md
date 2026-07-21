<div align="center">

# gh.hx

</div>

A [Helix](https://github.com/helix-editor/helix) plugin with GitHub repository helpers powered by the [`gh`](https://cli.github.com/) CLI.

## Install

Install:

```sh
forge pkg install --git https://github.com/matoous/gh.hx
```

Then expose the commands from `~/.config/helix/helix.scm`:

```scheme
(require "gh.hx")

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
```

The plugin does not install keybindings by default. Add your own bindings in
`~/.config/helix/helix.scm` if you want shortcuts.

## Usage

Open a file in a GitHub-hosted repository and run:

```text
:github_browse_file
:github_browse_file_at_line
:github_browse_file_blame
:github_browse_repo
:github_view_repo
:github_view_current_pr
:github_create_pr
:github_browse_prs
:github_browse_issues
:github_browse_actions_runs
:github_browse_releases
:github_browse_wiki
:github_browse_settings
:github_open_current_pr_checks
```

## Commands

| Helix command | Description | `gh` command |
| --- | --- | --- |
| `:github_browse_repo` | Open the current repository on GitHub. | `gh browse` |
| `:github_browse_file` | Open the focused file on GitHub. | `gh browse <current-file>` |
| `:github_browse_file_at_line` | Shows the direct shell form to use for cursor-line browsing. | `gh browse <current-file>:<cursor-line>` |
| `:github_browse_file_blame` | Open the focused file's blame view on GitHub. | `gh browse <current-file> --blame` |
| `:github_view_repo` | Open the current repository summary on GitHub. | `gh repo view --web` |
| `:github_view_current_pr` | Open the pull request for the current branch on GitHub. | `gh pr view --web` |
| `:github_create_pr` | Open GitHub's pull request creation flow for the current branch. | `gh pr create --web` |
| `:github_browse_prs` | Open the current repository's pull requests on GitHub. | `gh pr list --web` |
| `:github_browse_issues` | Open the current repository's issues on GitHub. | `gh issue list --web` |
| `:github_browse_actions_runs` | Open the current repository's GitHub Actions runs on GitHub. | `gh browse --actions` |
| `:github_browse_releases` | Open the current repository's releases on GitHub. | `gh browse --releases` |
| `:github_browse_wiki` | Open the current repository's wiki on GitHub. | `gh browse --wiki` |
| `:github_browse_settings` | Open the current repository's settings on GitHub. | `gh browse --settings` |
| `:github_open_current_pr_checks` | Open the current pull request's checks in the browser. | `gh pr checks --web` |

`github_browse_file_at_line` depends on Helix's command interpolation for the
cursor line, which is available to `:sh` commands. Use this command directly or
bind it yourself:

```scheme
(keymap (global)
        (normal ("space" (g (B ":sh gh browse %{buffer_name}:%{cursor_line}")))))
```

## Requirements

- `gh` must be installed, authenticated, and available on `PATH`.
- Commands should be run from files inside a Git worktree whose remote is hosted on GitHub.
