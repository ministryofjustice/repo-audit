# Analyse Ministry of Justice Github repos

Scan all our repos and report on whether they're following
the rules or not.

## Usage

* `bundle install`
* [Create a Github OAuth token](https://github.com/settings/tokens/new) with at least the following scopes enabled: _read:org, read:repo_hook, read:user, repo:status_
* `export GH_TOKEN=[your OAuth token]`

To analyse all repositories in the ministryofjustice organisation:
* `bin/analyse.rb`

To analyse a specific repository:
* `bin/check-repo.rb [username] [repository name]`

# TODO

There is a [list of issues](https://github.com/ministryofjustice/repo-audit/issues) with assorted checks awaiting to be implemented as well as improvements to the current code.
