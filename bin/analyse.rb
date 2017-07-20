#!/usr/bin/env ruby

require_relative '../lib/repo-audit'

config = RepoAudit::Configuration.load('repo-audit.yml')
checks = RepoAudit::ChecksCollection.new(config: config.checks)

# Just check a few repos, for speed
RepoAudit::RepositoryHelper.list(user: 'ministryofjustice')[10..15].each do |repo|
  ap RepoAudit::Report.new(repo: repo, checks: checks).run
  puts
end
