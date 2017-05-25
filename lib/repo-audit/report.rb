module RepoAudit
  class Report
    attr_reader :repo

    def initialize(params)
      if params.has_key?(:repo)
        @repo = params.fetch(:repo)
      else
        @repo = fetch_repo(user: params.fetch(:user), name: params.fetch(:name))
      end
    end

    def run
      {
        repo: repo.full_name,
        results: {
          license_check: LicenseChecker.new(repo).run
        }
      }
    end

    private

    def fetch_repo(user:, name:)
      # auto_pagination: false - only look at 30 repos. Switch to true to look at
      # everything. Be warned, it's a bit slow.
      github = Github::Client.new(auto_pagination: false, oauth_token: ENV.fetch('GH_TOKEN'))
      github.repos.find(user: user, repo: name)
    end
  end
end
