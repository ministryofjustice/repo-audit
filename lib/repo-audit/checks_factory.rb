module RepoAudit
  class ChecksFactory
    class CheckNotFoundError < RuntimeError; end

    class << self
      def build(type, metadata, arguments)
        fetch(type).new(metadata, arguments)
      end

      def register(type, klass)
        registered_checks.store(type, klass)
      end

      def fetch(type)
        registered_checks.fetch(type) { raise CheckNotFoundError, type }
      end

      def registered_checks
        @_registered_checks ||= {}
      end
    end
  end
end
