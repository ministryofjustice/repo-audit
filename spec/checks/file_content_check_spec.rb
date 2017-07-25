require_relative '../spec_helper'

describe RepoAudit::Checks::FileContentCheck do
  let(:metadata)  { {description: 'check description', style_guide_url: 'www.example.com'} }
  let(:arguments) { {filename: 'document.txt', content_matchers: content_matchers} }
  let(:content_matchers) { ['MIT License', 'Copyright \(c\) [\d-]+ Crown copyright \(Ministry of Justice\)'] }

  subject { described_class.new(metadata, arguments) }

  it_behaves_like 'a Check', name: :file_content

  context '#run' do
    let(:repository) { double('Repository', full_name: 'org/repo-name') }

    before do
      allow(RepoAudit::FileRequestHelper).to receive(:fetch).with(
        'https://raw.githubusercontent.com/org/repo-name/master/document.txt'
      ).and_return(file_content)
    end

    context 'for a success result' do
      let(:file_content) { File.read('spec/fixtures/example-license.txt') }

      it 'returns the expected result' do
        expect(subject).to receive(:success)
        subject.run(repository)
      end
    end

    context 'for a failure result' do
      context 'all matchers were missing in the content' do
        let(:file_content) { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.' }

        it 'returns the expected result' do
          expect(subject).to receive(:failure)
          subject.run(repository)
        end
      end

      context 'some of the matchers were missing in the content' do
        let(:file_content) { 'Lorem ipsum dolor sit amet, MIT License.' }

        it 'returns the expected result' do
          expect(subject).to receive(:failure)
          subject.run(repository)
        end
      end
    end
  end
end
