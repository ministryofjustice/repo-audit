module RepoAudit
  module RepositoryContent
    URL_PATTERN = 'https://raw.githubusercontent.com/%{repo_full_name}/master/%{filename}'.freeze

    private

    def repository_file_url(repo, filename)
      format(URL_PATTERN, repo_full_name: repo.full_name, filename: filename)
    end
  end
end
