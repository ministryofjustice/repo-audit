module RepoAudit
  module Checks
    class LastCommitCheck < BaseCheck
      register_check :last_commit

      def run(repo)
        commit = RepositoryHelper.last_commit(user: repo.owner.login, name: repo.name)
        author = commit.fetch("commit").fetch("author")
        result(
          timestamp: DateTime.parse(author.fetch("date")),
          author: {
            name: author.fetch("name"),
            email: author.fetch("email")
          }
        )
      end
    end
  end
end
