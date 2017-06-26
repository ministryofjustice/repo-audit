#!/usr/bin/env ruby

require_relative '../lib/repo-audit'

user = ARGV.shift
name = ARGV.shift

if (user.to_s.empty? or name.to_s.empty?)
  puts <<~USAGE
  USAGE: #{$0} [github username] [repository name]

    e.g. #{$0} ministryofjustice repo-audit

  USAGE
  exit(1)
end

ap RepoAudit::Report.new(user: user, name: name).run
puts

