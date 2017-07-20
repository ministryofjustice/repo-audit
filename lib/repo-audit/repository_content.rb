module RepoAudit
  module RepositoryContent
    URL_PATTERN = 'https://raw.githubusercontent.com/%{repo_full_name}/master/%{filename}'.freeze

    attr_accessor :filename

    private

    def file_url(repo)
      format(URL_PATTERN, repo_full_name: repo.full_name, filename: filename)
    end
  end
end
