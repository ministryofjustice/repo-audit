#!/usr/bin/env ruby

require_relative '../lib/repo-audit'

# Just check a few repos, for speed
RepoAudit::RepositoryHelper.list(user: 'ministryofjustice')[10..15].each do |repo|
  ap RepoAudit::Report.new(repo: repo).run
  puts
end
