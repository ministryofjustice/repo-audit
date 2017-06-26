require_relative 'spec_helper'

describe RepoAudit::Report do
  let(:repo) { double(Github::Mash, { full_name: 'some-user/not-a-real-repo' }) }
  let(:report) { described_class.new(repo: repo) }
  let(:checker) { double(run: nil) }

  before do
    allow(RepoAudit::LicenseChecker).to receive(:new).with(repo).and_return(checker)
    allow(ENV).to receive(:fetch).with('GH_TOKEN').and_return('dummy-token')
  end

  it 'accepts a repo' do
    expect { described_class.new(repo: repo) }.to_not raise_error
  end

  it 'accepts a user & repo name' do
    expect { described_class.new(user: 'some-user', repo: 'some-repo') }.to_not raise_error
  end

  it 'raises an exception when required parameters are not supplied' do
    expect { described_class.new(foo: 'bar') }.to raise_error(KeyError)
  end

  it 'reports on a repo' do
    expect(RepoAudit::LicenseChecker).to receive(:new).with(repo).and_return(checker)
    expect(checker).to receive(:run)

    report.run
  end

  it 'retrieves a repo given a user & name' do
    repos = double(find: repo)
    github = double(repos: repos)

    expect(Github::Client).to receive(:new).and_return(github)
    expect(github).to receive(:repos).and_return(repos)
    expect(repos).to receive(:find).with(user: 'some-user', repo: 'some-repo').and_return(repo)

    described_class.new(user: 'some-user', name: 'some-repo').run
  end

  it 'returns a report hash' do
    expect(report.run).to eq({ repo: "some-user/not-a-real-repo", results: {license_check: nil} })
  end
end
