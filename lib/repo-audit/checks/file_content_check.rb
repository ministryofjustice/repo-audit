module RepoAudit::Checks
  class FileContentCheck < BaseCheck
    register_check :file_content_check

    URL_PATTERN = 'https://raw.githubusercontent.com/%{repo_full_name}/master/%{filename}'.freeze

    attr_accessor :filename
    attr_accessor :content_matchers

    def run(repo)
      url = format(URL_PATTERN, repo_full_name: repo.full_name, filename: filename)
      file_content_matches?(url) ? success : failure
    end

    private

    def file_content_matches?(url)
      file_content = RepoAudit::FileRequestHelper.fetch(url)

      content_matchers.all? do |regex|
        Regexp.new(regex).match(file_content)
      end
    end
  end
end
