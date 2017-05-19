require 'bundler/setup'
require 'github_api'
require 'awesome_print'
require 'pp'
require 'pry-byebug'
require 'open-uri'

module Repoman
end

require_relative './repoman/checker'
require_relative './repoman/required_file_checker'
require_relative './repoman/file_fetcher'
require_relative './repoman/license_checker'
