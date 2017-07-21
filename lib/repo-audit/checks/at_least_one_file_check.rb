module RepoAudit::Checks
  class AtLeastOneFileCheck < BaseCheck
    include RepoAudit::RepositoryContent

    register_check :at_least_one_file_check

    attr_accessor :filenames

    def run(repo)
      at_least_one_file_exists?(repo) ? success : failure
    end

    private

    def at_least_one_file_exists?(repo)
      filenames.detect do |filename|
        url = file_url(repo, filename)
        RepoAudit::FileRequestHelper.exists?(url)
      end
    end
  end
end
