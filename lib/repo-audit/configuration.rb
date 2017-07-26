module RepoAudit
  class Configuration < SimpleDelegator
    def self.load(file, loader_class = Hashie::Mash)
      new loader_class.load(file)
    end
  end
end
