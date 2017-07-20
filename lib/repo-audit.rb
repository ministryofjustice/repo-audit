require 'bundler/setup'
require 'awesome_print'
require 'github_api'
require 'open-uri'
require 'pp'
require 'pry-byebug'

module RepoAudit
end

require_relative './repo-audit/configuration'
require_relative './repo-audit/checks_factory'
require_relative './repo-audit/checks_collection'
require_relative './repo-audit/checker'
require_relative './repo-audit/required_file_checker'
require_relative './repo-audit/file_fetcher'
require_relative './repo-audit/license_checker'
require_relative './repo-audit/repository_helper'
require_relative './repo-audit/report'

require_relative './repo-audit/checks/base_check'

# This will take care of requiring all the checks, without having to add
# each of them individually to this file (as eventually could be a lot)
Dir[File.join(Pathname.getwd, 'lib', 'repo-audit', 'checks', '*.rb')].each { |file| require file }
