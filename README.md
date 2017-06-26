# Analyse Ministry of Justice Github repos

Scan all our repos and report on whether they're following
the rules or not.

## Usage

* `bundle install`
* [Create a Github OAuth token](https://github.com/settings/tokens/new)
* `export GH_TOKEN=[your OAuth token]`
* `bin/analyse.rb`

# TODO

* Enable users to define the rules they want in a config file (cf. [Dangerfile](https://github.com/danger/danger))
* Create a plugin architecture (cf. http://danger.systems/guides/creating_your_first_plugin.html)
* Uses our Dangerfile
* Visibility (public/private)
* Activity (age of last update)
* Using CI (Travis/Circle)
* Merge strategy is the MoJ standard (whatever that is)
* Uses protected branches
* If ruby, check the version
* If rails, check the version
* Does it have individual contributors (bad, should be teams)
  * Make an exception for pre-defined external contributors (who cannot be added to teams)
* check the body of the LICENSE file for MIT License content
* Raise issues for failures
* Return all errors with the content of the license file, don't just fail on the first one
* For LICENSE file - automatically fix the problem (by using a standard license file) and raise a PR
* Add a "notes" field to error reports, giving explanatory text with useful links
* LICENSE file contains the current year in the copyright statement (waiting for a decision on whether this is really required)
