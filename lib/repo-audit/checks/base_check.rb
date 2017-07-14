module RepoAudit::Checks
  class BaseCheck
    attr_reader :description
    attr_reader :style_guide_url

    def initialize(metadata, arguments)
      @description = metadata.fetch(:description)
      @style_guide_url = metadata.fetch(:style_guide_url, 'n/a')

      set_attributes(arguments)
    end

    def run
      raise 'implement in subclasses'
    end

    protected

    def success
      result(:success)
    end

    def failure
      result(:failure)
    end

    private

    def set_attributes(args)
      return unless args.is_a?(Hash)
      args.each { |k, v| send("#{k}=", v) }
    end

    def result(result)
      { self.class.name => { result: result, description: description } }
    end

    class << self
      protected

      def register_check(type)
        RepoAudit::ChecksFactory.register(type, self)
      end
    end
  end
end
