require_relative 'spec_helper'

describe RepoAudit::FileRequestHelper do
  let(:http) { spy(Net::HTTP) }

  before do
    allow(Net::HTTP).to receive(:new).and_return(http)
  end

  describe '.exists?' do
    it 'builds an HTTP object from the given URL' do
      expect(Net::HTTP).to receive(:new).with('example.com', 443)
      described_class.exists?('https://example.com/file.txt')
    end

    it 'enables the SSL flag in the HTTP object' do
      expect(http).to receive(:use_ssl=).with(true)
      described_class.exists?('anything')
    end

    it 'sends a HEAD request to the given URL' do
      expect(http).to receive(:request_head).with('https://example.com/file.txt')
      described_class.exists?('https://example.com/file.txt')
    end

    context 'responses' do
      before do
        allow(http).to receive(:request_head).and_return(response)
      end

      context 'for a successful HEAD' do
        let(:response) { Net::HTTPSuccess.new('', 200, '') }

        it 'returns true' do
          expect(described_class.exists?('anything')).to eq(true)
        end
      end

      context 'for an unsuccessful HEAD' do
        let(:response) { Net::HTTPNotFound.new('', 404, '') }

        it 'returns false' do
          expect(described_class.exists?('anything')).to eq(false)
        end
      end
    end
  end
end
