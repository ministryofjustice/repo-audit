module RepoAudit
  class ChecksCollection < SimpleDelegator
    def initialize(config:)
      super build_checks(config)
    end

    def run(repo)
      map { |check| check.run(repo) }
    end

    private

    def build_checks(config)
      config.map do |c|
        RepoAudit::ChecksFactory.build(c.type, c.metadata, c.arguments)
      end
    end
  end
end
