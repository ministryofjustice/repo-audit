require 'bundler/setup'
require 'github_api'
require 'awesome_print'
require 'pp'
require 'pry-byebug'

module RepoAudit
end

require_relative './repo-audit/configuration'
require_relative './repo-audit/constants'
require_relative './repo-audit/checks_factory'
require_relative './repo-audit/checks_collection'
require_relative './repo-audit/file_request_helper'
require_relative './repo-audit/repository_helper'
require_relative './repo-audit/repository_content'
require_relative './repo-audit/report'
require_relative './repo-audit/version_matcher'

require_relative './repo-audit/checks/base_check'

# This will take care of requiring all the checks, without having to add
# each of them individually to this file (as eventually could be a lot)
Dir[File.join(Pathname.getwd, 'lib', 'repo-audit', 'checks', '*.rb')].each { |file| require file }
