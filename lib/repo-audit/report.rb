module RepoAudit
  class Report
    attr_reader :repo
    attr_reader :checks

    def initialize(repo:, checks:)
      @repo = repo
      @checks = checks
    end

    def run
      {
        repo: repo.full_name,
        results: checks.run(repo)
      }
    end
  end
end
