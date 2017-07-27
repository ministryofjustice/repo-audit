#!/usr/bin/env ruby

# Pass a match expression as an optional argument to only run mutant
# on classes that match. Example: `bin/mutant.rb RepoAudit::ChecksFactory`

flags = '--use rspec --fail-fast'.freeze
klasses = Array(ARGV[0] || 'RepoAudit*').freeze

klasses.each do |klass|
  unless system("bundle exec mutant #{flags} #{klass}")
    raise 'Mutation testing failed'
  end
end
