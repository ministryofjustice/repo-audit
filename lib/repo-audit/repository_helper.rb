module RepoAudit
  class RepositoryHelper
    class << self
      def find(user:, name:)
        github_client.repos.find(user: user, repo: name)
      end

      def list(user:)
        github_client.repos.list(user: user)
      end

      private

      def github_client
        # auto_pagination: false - only look at 30 repos. Switch to true to look at
        # everything. Be warned, it's a bit slow.
        Github::Client.new(auto_pagination: false, oauth_token: ENV.fetch('GH_TOKEN'))
      end
    end
  end
end
