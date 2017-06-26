module RepoAudit
  class Checker
    attr_reader :repo

    def initialize(repo)
      @repo = repo
      @errors = []
    end

    private

    def add_error(error)
      @errors << error
    end

    def result
      @errors.any? ? { result: :failed, errors: @errors } : passed
    end

    def passed
      { result: :passed }
    end
  end
end
