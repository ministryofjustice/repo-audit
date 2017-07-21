module RepoAudit::Checks
  class RequiredFileCheck < BaseCheck
    include RepoAudit::RepositoryContent

    register_check :required_file_check

    attr_accessor :filename

    def run(repo)
      url = file_url(repo, filename)
      file_exists?(url) ? success : failure
    end

    private

    def file_exists?(url)
      RepoAudit::FileRequestHelper.exists?(url)
    end
  end
end
