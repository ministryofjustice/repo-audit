require 'bundler/setup'
require 'github_api'
require 'awesome_print'
require 'pp'
require 'pry-byebug'
require 'open-uri'

module RepoAudit
end

require_relative './repoaudit/checker'
require_relative './repoaudit/required_file_checker'
require_relative './repoaudit/file_fetcher'
require_relative './repoaudit/license_checker'
