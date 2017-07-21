module RepoAudit::Checks
  class RequiredFileCheck < BaseCheck
    include RepoAudit::RepositoryContent

    register_check :required_file_check

    def run(repo)
      url = file_url(repo)
      file_exists?(url) ? success : failure
    end

    private

    def file_exists?(url)
      RepoAudit::FileRequestHelper.exists?(url)
    end
  end
end
