require 'bundler/setup'
require 'github_api'
require 'awesome_print'
require 'pp'
require 'pry-byebug'
require 'open-uri'

module RepoAudit
end

require_relative './repo-audit/configuration'
require_relative './repo-audit/checker'
require_relative './repo-audit/required_file_checker'
require_relative './repo-audit/file_fetcher'
require_relative './repo-audit/license_checker'
require_relative './repo-audit/repository_helper'
require_relative './repo-audit/report'
