module RepoAudit
  class RepositoryHelper
    class << self
      def find(user:, name:)
        github_client.repos.find(user: user, repo: name)
      end

      def list(user:)
        github_client.repos.list(user: user)
      end

      def last_commit(user:, name:)
        github_client(auto_pagination: false)
          .repos
          .commits
          .list(user, name)
          .to_a
          .first
      end

      private

      # auto_pagination: false - only look at 30 repos. Switch to true to look at
      # everything. Be warned, it's a bit slow.
      def github_client(auto_pagination: false)
        Github::Client.new(auto_pagination: auto_pagination, oauth_token: ENV.fetch('GH_TOKEN'))
      end
    end
  end
end
