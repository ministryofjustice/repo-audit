module RepoAudit
  module Checks
    class AtLeastOneFileCheck < BaseCheck
      include RepoAudit::RepositoryContent

      register_check :at_least_one_file

      attr_accessor :filenames

      def run(repo)
        at_least_one_file_exists?(repo) ? success : failure
      end

      private

      def at_least_one_file_exists?(repo)
        filenames.detect do |filename|
          url = repository_file_url(repo, filename)
          FileRequestHelper.exists?(url)
        end
      end
    end
  end
end
