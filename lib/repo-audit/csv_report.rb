module RepoAudit

  # Transform the parsed JSON output of the bin/analyse.rb script
  # into CSV data.
  class CsvReport

    # Takes:: A single hash with keys;
    #
    # * data:: A list of hashes where each hash is the RepoAudit::Report output from a
    #          single github repository
    #
    # * config:: A list of 2-element arrays, where the first element is the column heading
    #            and the second is the name of the key in the *data* hash whose value will
    #            populate the column. Provided the key name is unique, it is not necessary
    #            to specify it's 'path' in the hash. e.g. the key name _baz_ will find the
    #            key in the hash;
    #
    #                { foo: { bar: { baz: { result: 'passed' } } } }
    #
    #            If the value of _key_ is a hash with a key of _result_ (as per the example
    #            above), then the value of result is returned, otherwise the value of _key_
    #            is returned.
    #
    def initialize(params)
      @config = params.fetch(:config)
      @data = params.fetch(:data)
    end

    def to_csv
      [header, lines].join
    end

    private

    def header
      @config.map {|t| t[0]}.to_csv
    end

    def lines
      @data.inject([]) do |arr, entry|
        res = Hashie::Mash.new(entry)
        res.extend Hashie::Extensions::DeepFind

        arr << line(res)
      end
    end

    def line(entry)
      @config.map {|t| t[1]}
      .inject([]) {|arr, key| arr << value(entry, key)}
      .to_csv
    end

    def value(entry, key)
      val = entry.deep_find(key)
      val.respond_to?(:result) ? val.result : val
    end
  end
end
