require_relative 'spec_helper'

describe RepoAudit::RequiredFileChecker do
  let(:repo) { double(Github::Mash, { full_name: 'not-a-real-repo' }) }
  let(:filename) { 'some-file' }
  let(:file_content) { 'this is a test' }
  let(:error_message) { "It's not there" }
  let(:checker) { described_class.new(repo, filename, error_message) }
  let(:file_url) { 'https://raw.githubusercontent.com/not-a-real-repo/master/some-file' }
  let(:success) { { success: true, content: file_content, error: nil } }
  let(:failure) { { success: false, content: nil, error: error_message } }

  it 'derives the file url' do
    expect(RepoAudit::FileFetcher).to receive(:fetch).with(file_url)
    checker.fetch
  end

  context 'when the file is missing' do
    before do
      expect(RepoAudit::FileFetcher).to receive(:fetch).with(file_url).and_raise(OpenURI::HTTPError.new('404', nil))
    end

    it 'fails, returning the error' do
      expect(checker.fetch).to eq(failure)
    end
  end

  context 'when the file exists' do
    before do
      expect(RepoAudit::FileFetcher).to receive(:fetch).and_return(file_content)
    end

    it 'returns the content of the file' do
      expect(checker.fetch).to eq(success)
    end
  end
end
