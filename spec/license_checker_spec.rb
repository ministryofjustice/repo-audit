require_relative 'spec_helper'

describe Repoman::LicenseChecker do
  let(:repo) { double(Github::Mash, { full_name: 'not-a-real-repo' }) }
  let(:checker) { described_class.new(repo) }
  let(:check_passed) { { result: :passed } }
  let(:license_text) { '' }
  let(:license_url) { 'https://raw.githubusercontent.com/not-a-real-repo/master/LICENSE' }

  it 'fetches the license file' do
    expect(Repoman::FileFetcher).to receive(:fetch).with(license_url).and_return(license_text)
    checker.run
  end

  context 'when the license is missing' do
    let(:missing_license) { {result: :failed, reason: 'No LICENSE file'} }

    before do
      expect(Repoman::FileFetcher).to receive(:fetch).with(license_url).and_raise(OpenURI::HTTPError.new('404', nil))
    end

    it 'fails with missing license error' do
      expect(checker.run).to eq(missing_license)
    end
  end

  context 'when the license file exists' do
    before do
      expect(Repoman::FileFetcher).to receive(:fetch).and_return(license_text)
    end

    context 'when the license is OK' do
      let(:license_text) { File.read('LICENSE') }

      it 'passes' do
        expect(checker.run).to eq(check_passed)
      end
    end

    context 'when the license has errors' do
      let(:license_text) { 'This is not a valid license' }
      let(:check_failed) {
        {result: :failed, reason: 'Not MIT licensed'}
      }

      it 'fails with non-mit error' do
        expect(checker.run).to eq(check_failed)
      end
    end
  end
end
