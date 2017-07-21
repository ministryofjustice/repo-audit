#!/usr/bin/env ruby

require_relative '../lib/repo-audit'

config = RepoAudit::Configuration.load('repo-audit.yml')
checks = RepoAudit::ChecksCollection.new(config: config.checks)

# Just check a few repos, for speed
results = RepoAudit::RepositoryHelper.list(user: 'ministryofjustice')[10..15].collect do |repo|
  RepoAudit::Report.new(repo: repo, checks: checks).run
end

puts results.to_json
