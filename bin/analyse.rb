#!/usr/bin/env ruby

require_relative '../lib/repo-audit'

# auto_pagination: false - only look at 30 repos. Switch to true to look at
# everything. Be warned, it's a bit slow.
github = Github.new(auto_pagination: false, oauth_token: ENV.fetch('GH_TOKEN'))

# Just check a few repos, for speed
github.repos.list(user: 'ministryofjustice')[10..15].map do |repo|
  puts repo.full_name
  report = {}
  report[:license_check] = RepoAudit::LicenseChecker.new(repo).run
  ap report
  puts
end
