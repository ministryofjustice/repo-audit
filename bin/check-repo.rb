#!/usr/bin/env ruby

require_relative '../lib/repoman'

user = ARGV.shift
name = ARGV.shift

if (user.to_s.empty? or name.to_s.empty?)
  puts <<~USAGE
  USAGE: #{$0} [github username] [repository name]

    e.g. #{$0} ministryofjustice repoman

  USAGE
  exit(1)
end

ap Repoman::Report.new(user: user, name: name).run
puts

