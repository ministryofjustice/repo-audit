#!/usr/bin/env ruby

require 'bundler/setup'
require 'github_api'
require 'awesome_print'
require 'pp'
require 'pry-byebug'

Github.repos.list(user: 'ministryofjustice', auto_pagination: true).map do |repo|
  puts "--------------------------------------------"
  ap repo
  puts
end

