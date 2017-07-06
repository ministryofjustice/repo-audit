require_relative 'spec_helper'

describe RepoAudit::Report do
  let(:repo) { double(Github::Mash, { full_name: 'some-user/not-a-real-repo' }) }
  let(:report) { described_class.new(repo: repo) }
  let(:checker) { double(run: nil) }

  before do
    allow(RepoAudit::LicenseChecker).to receive(:new).with(repo).and_return(checker)
  end

  it 'accepts a repo' do
    expect { described_class.new(repo: repo) }.to_not raise_error
  end

  it 'raises an exception when required arguments are not supplied' do
    expect { described_class.new(foo: 'bar') }.to raise_error(ArgumentError)
  end

  it 'reports on a repo' do
    expect(RepoAudit::LicenseChecker).to receive(:new).with(repo).and_return(checker)
    expect(checker).to receive(:run)

    report.run
  end

  it 'returns a report hash' do
    expect(report.run).to eq({ repo: "some-user/not-a-real-repo", results: {license_check: nil} })
  end
end
