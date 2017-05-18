# Analyse Ministry of Justice Github repos

Scan all our repos and report on whether they're following
the rules or not.

Initially, this will scan public, ruby repos. The intention
is to widen coverage, over time.

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
