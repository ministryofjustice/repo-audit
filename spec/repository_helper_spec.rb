require_relative 'spec_helper'

describe RepoAudit::RepositoryHelper do
  let(:github_client) { double('github_client', repos: spy) }

  before do
    allow(ENV).to receive(:fetch).with('GH_TOKEN').and_return('dummy-token')
    allow(Github::Client).to receive(:new).with(
      auto_pagination: false, oauth_token: 'dummy-token'
    ).and_return(github_client)
  end

  context '.find' do
    it 'raises an exception when required arguments are not supplied' do
      expect { described_class.find(foo: 'bar') }.to raise_error(ArgumentError)
    end

    it 'retrieves the repository using the Github client' do
      expect(github_client.repos).to receive(:find).with(user: 'user', repo: 'name')
      described_class.find(user: 'user', name: 'name')
    end
  end

  context '.list' do
    it 'raises an exception when required arguments are not supplied' do
      expect { described_class.list(foo: 'bar') }.to raise_error(ArgumentError)
    end

    it 'retrieves the list of repositories using the Github client' do
      expect(github_client.repos).to receive(:list).with(user: 'user')
      described_class.list(user: 'user')
    end
  end
end
