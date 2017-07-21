module RepoAudit::Checks
  class LastCommitCheck < BaseCheck
    register_check :last_commit_check

    def run(repo)
      commit = RepoAudit::RepositoryHelper.last_commit(user: repo.owner.login, name: repo.name)
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

