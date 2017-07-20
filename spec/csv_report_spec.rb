require_relative 'spec_helper'

describe RepoAudit::CsvReport do
  let(:entry) {
    {
      "repo" => "repository name",
      "results" => {
        "license_check" => {
          "result" => "failed"
        }
      }
    }
  }

  let(:data) { [entry] }

  let(:config) {
    [
      ["Repository", "repo"],
      ["License Check", "license_check"]
    ]
  }

  let(:transformer) { described_class.new(data: data, config: config) }

  it "transforms to CSV" do
    csv = <<~CSV
    Repository,License Check
    repository name,failed
    CSV
    expect(transformer.to_csv).to eq(csv)
  end

end

