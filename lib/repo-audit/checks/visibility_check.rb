module RepoAudit
  module Checks
    class VisibilityCheck < BaseCheck

      register_check :visibility

      def run(repo)
        repo.private ? failure : success
      end
    end
  end
end
