module RepoAudit
  module Checks
    class VisibilityCheck < BaseCheck

      register_check :visibility

      def run(repo)
        visibility = repo.private ? :private : :public
        result(visibility: visibility)
      end
    end
  end
end
