module RepoAudit
  class VersionMatcher
    attr_reader :content
    attr_reader :version_regex

    def initialize(content:, version_regex:)
      @content = content
      @version_regex = version_regex
    end

    def satisfies?(version)
      Gem::Requirement.create(version).satisfied_by?(matched_version)
    end

    private

    def matched_version
      match = Regexp.new(version_regex).match(content) || {}
      Gem::Version.new(match[:version])
    end
  end
end
