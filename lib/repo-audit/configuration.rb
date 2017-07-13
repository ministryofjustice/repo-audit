module RepoAudit
  class Configuration < SimpleDelegator
    def self.load(file)
      new Hashie::Mash.load(file)
    end
  end
end
