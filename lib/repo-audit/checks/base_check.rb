module RepoAudit::Checks
  class BaseCheck
    attr_reader :description
    attr_reader :style_guide_url

    def initialize(metadata, arguments = nil)
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
      return unless args.instance_of?(Hash)
      args.each { |k, v| public_send("#{k}=", v) }
    end

    def result(outcome)
      { self.class.name => { result: outcome, description: description } }
    end

    class << self
      protected

      def register_check(type)
        RepoAudit::ChecksFactory.register(type, self)
      end
    end
  end
end
