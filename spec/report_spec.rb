require_relative 'spec_helper'

describe RepoAudit::Report do
  let(:repo) { double(Github::Mash, { full_name: 'some-user/not-a-real-repo' }) }
  let(:report) { described_class.new(repo) }
  let(:checker) { double(run: nil) }

  before do
    allow(RepoAudit::LicenseChecker).to receive(:new).with(repo).and_return(checker)
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
