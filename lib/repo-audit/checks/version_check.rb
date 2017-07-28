module RepoAudit
  module Checks
    class VersionCheck < BaseCheck
      include RepoAudit::RepositoryContent

      register_check :version

      attr_accessor :version
      attr_accessor :file_matchers

      def run(repo)
        match_version?(repo) ? success : failure
      end

      private

      def match_version?(repo)
        file_matchers.detect do |matcher_hash|
          filename, regex = matcher_hash.flatten

          url = repository_file_url(repo, filename)
          file_content = FileRequestHelper.fetch(url)

          VersionMatcher.new(
            content: file_content,
            version_regex: regex
          ).satisfies?(version)
        end
      end
    end
  end
end
