module RepoAudit
  module Checks
    class RequiredFileCheck < BaseCheck
      include RepoAudit::RepositoryContent

      register_check :required_file

      attr_accessor :filename

      def run(repo)
        file_exists?(repo) ? success : failure
      end

      private

      def file_exists?(repo)
        url = repository_file_url(repo, filename)
        FileRequestHelper.exists?(url)
      end
    end
  end
end
