#!/usr/bin/env ruby

require_relative '../lib/repo-audit'

puts RepoAudit::CsvReport.new(
  config: [
    ["Repository", "repo"],
    ["License Check", "license_check"]
  ],
  data: JSON.parse(STDIN.read)
).to_csv
