module RepoAudit::Checks
  class FileContentCheck < BaseCheck
    include RepoAudit::RepositoryContent

    register_check :file_content_check

    attr_accessor :content_matchers

    def run(repo)
      url = file_url(repo)
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
