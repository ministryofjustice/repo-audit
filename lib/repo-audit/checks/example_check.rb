module RepoAudit::Checks
  class ExampleCheck < BaseCheck
    # This method will register in the factory this check Class
    register_check :example_check

    # Checks can have configuration accessors needed for their task to be accomplished
    attr_accessor :name_matcher

    # Each check Class have a `#run` method in charge of checking whatever it is there
    # to check, and this method receive the repository being checked.
    # This should accordingly call `#success` or `#failure` depending on the result.
    def run(repo)
      Regexp.new(name_matcher).match(repo.name) ? success : failure
    end
  end
end
