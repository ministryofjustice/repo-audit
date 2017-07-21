require_relative '../spec_helper'

describe RepoAudit::Checks::RequiredFileCheck do
  let(:metadata)  { {description: 'check description', style_guide_url: 'www.example.com'} }
  let(:arguments) { {filename: 'document.txt'} }

  subject { described_class.new(metadata, arguments) }

  it_behaves_like 'a Check', name: :required_file_check

  context '#run' do
    let(:repository) { double('Repository', full_name: 'org/repo-name') }

    before do
      allow(RepoAudit::FileRequestHelper).to receive(:exists?).with(
        'https://raw.githubusercontent.com/org/repo-name/master/document.txt'
      ).and_return(exists_result)
    end

    context 'for a success result' do
      let(:exists_result) { true }

      it 'returns the expected result' do
        expect(subject).to receive(:success)
        subject.run(repository)
      end
    end

    context 'for a failure result' do
      let(:exists_result) { false }

      it 'returns the expected result' do
        expect(subject).to receive(:failure)
        subject.run(repository)
      end
    end
  end
end
