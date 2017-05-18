# Analyse Ministry of Justice Github repos

Scan all our repos and report on whether they're following
the rules or not.

## Usage

* `bundle install`
* [Create a Github OAuth token](https://github.com/settings/tokens/new)
* `export GH_TOKEN=[your OAuth token]`
* `bin/analyse.rb`

## Rules

* Using CI (Travis/Circle)
* Merge strategy is XXX
* Has a LICENSE file with the right content
* Uses protected branches
* Uses our Dangerfile
* If rails, check the version
* Does it have individual contributors (bad, should be teams)
  * Make an exception for pre-defined external contributors (who cannot be added to teams)


# TODO

* Enable users to define the rules they want in a config file (cf. [Dangerfile](https://github.com/danger/danger))
* Create a plugin architecture (cf. http://danger.systems/guides/creating_your_first_plugin.html)
