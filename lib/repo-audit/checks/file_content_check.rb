module RepoAudit::Checks
  class FileContentCheck < BaseCheck
    include RepoAudit::RepositoryContent

    register_check :file_content_check

    attr_accessor :filename
    attr_accessor :content_matchers

    def run(repo)
      file_content_matches?(repo) ? success : failure
    end

    private

    def file_content_matches?(repo)
      url = file_url(repo, filename)
      file_content = RepoAudit::FileRequestHelper.fetch(url)

      content_matchers.all? do |regex|
        Regexp.new(regex).match(file_content)
      end
    end
  end
end
