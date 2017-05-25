module RepoAudit
  class Report
    attr_reader :repo

    def initialize(repo)
      @repo = repo
    end

    def run
      {
        repo: repo.full_name,
        results: {
          license_check: LicenseChecker.new(repo).run
        }
      }
    end
  end
end
