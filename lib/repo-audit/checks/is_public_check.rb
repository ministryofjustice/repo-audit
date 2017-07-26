module RepoAudit
  module Checks
    class IsPublicCheck < BaseCheck

      register_check :is_public

      def run(repo)
        repo.private ? failure : success
      end
    end
  end
end
