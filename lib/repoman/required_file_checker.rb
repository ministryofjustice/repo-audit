module Repoman
  class RequiredFileChecker
    attr_reader :repo, :repo_file, :missing_file_error

    def initialize(repo, repo_file, missing_file_error)
      @repo = repo
      @repo_file = repo_file
      @missing_file_error = missing_file_error
    end

    def fetch
      {
        success: true,
        content: FileFetcher.fetch(file_url),
        error: nil
      }
    rescue OpenURI::HTTPError => e
      if e.message =~ /404/
        {
          success: false,
          content: nil,
          error: missing_file_error
        }
      else
        raise e
      end
    end

    private

    def file_url
      "https://raw.githubusercontent.com/#{repo.full_name}/master/#{repo_file}"
    end
  end
end
