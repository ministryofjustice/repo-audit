module RepoAudit::Checks
  class RequiredFileCheck < BaseCheck
    register_check :required_file_check

    URL_PATTERN = 'https://raw.githubusercontent.com/%{repo_full_name}/master/%{filename}'.freeze

    attr_accessor :filename

    def run(repo)
      url = format(URL_PATTERN, repo_full_name: repo.full_name, filename: filename)
      file_exists?(url) ? success : failure
    end

    private

    def file_exists?(url)
      RepoAudit::FileRequestHelper.exists?(url)
    end
  end
end
