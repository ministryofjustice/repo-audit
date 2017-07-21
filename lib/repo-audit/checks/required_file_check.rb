module RepoAudit::Checks
  class RequiredFileCheck < BaseCheck
    include RepoAudit::RepositoryContent

    register_check :required_file_check

    attr_accessor :filename

    def run(repo)
      file_exists?(repo) ? success : failure
    end

    private

    def file_exists?(repo)
      url = file_url(repo, filename)
      RepoAudit::FileRequestHelper.exists?(url)
    end
  end
end
