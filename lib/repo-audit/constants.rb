module RepoAudit::Constants
  RUBY_VERSION_FILES = [
    ['Gemfile',       '^ruby \'(?<version>\S+)\''],
    ['.ruby-version', '^(?<version>\S+)$'],
    ['.travis.yml',   '^rvm: (?<version>\S+)$']
  ].freeze

  RAILS_VERSION_FILES = [
    ['Gemfile.lock',  '^\s+rails \((?<version>\S+)\)$']
  ].freeze
end
