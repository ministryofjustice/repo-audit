module RepoAudit
  module Checks
    class FileContentCheck < BaseCheck
      include RepoAudit::RepositoryContent

      register_check :file_content

      attr_accessor :filename
      attr_accessor :content_matchers

      def run(repo)
        file_content_matches?(repo) ? success : failure
      end

      private

      def file_content_matches?(repo)
        url = repository_file_url(repo, filename)
        file_content = FileRequestHelper.fetch(url)

        content_matchers.all? do |regex|
          Regexp.new(regex).match(file_content)
        end
      end
    end
  end
end
