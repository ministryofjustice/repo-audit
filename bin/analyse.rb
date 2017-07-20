#!/usr/bin/env ruby

require_relative '../lib/repo-audit'

# Just check a few repos, for speed
results = RepoAudit::RepositoryHelper.list(user: 'ministryofjustice')[10..15].inject([]) do |list, repo|
  list << RepoAudit::Report.new(repo: repo).run
end

puts results.to_json
