require_relative '../spec_helper'

describe RepoAudit::Checks::AtLeastOneFileCheck do
  let(:metadata)  { {description: 'check description', style_guide_url: 'www.example.com'} }
  let(:arguments) { {filenames: %w[file1.txt file2.txt]} }

  subject { described_class.new(metadata, arguments) }

  it_behaves_like 'a Check', name: :at_least_one_file_check

  context '#run' do
    let(:repository) { double('Repository', full_name: 'org/repo-name') }

    context 'for a success result in the first file' do
      it 'returns the expected result' do
        expect(RepoAudit::FileRequestHelper).to receive(:exists?).with(
          'https://raw.githubusercontent.com/org/repo-name/master/file1.txt'
        ).and_return(true)

        expect(RepoAudit::FileRequestHelper).not_to receive(:exists?).with(
          'https://raw.githubusercontent.com/org/repo-name/master/file2.txt'
        )

        expect(subject).to receive(:success)
        subject.run(repository)
      end
    end

    context 'for a failure result in the first file and success result in the second file' do
      it 'returns the expected result' do
        expect(RepoAudit::FileRequestHelper).to receive(:exists?).with(
          'https://raw.githubusercontent.com/org/repo-name/master/file1.txt'
        ).and_return(false)

        expect(RepoAudit::FileRequestHelper).to receive(:exists?).with(
          'https://raw.githubusercontent.com/org/repo-name/master/file2.txt'
        ).and_return(true)

        expect(subject).to receive(:success)
        subject.run(repository)
      end
    end

    context 'for a failure result' do
      it 'returns the expected result' do
        expect(RepoAudit::FileRequestHelper).to receive(:exists?).with(
          'https://raw.githubusercontent.com/org/repo-name/master/file1.txt'
        ).and_return(false)

        expect(RepoAudit::FileRequestHelper).to receive(:exists?).with(
          'https://raw.githubusercontent.com/org/repo-name/master/file2.txt'
        ).and_return(false)

        expect(subject).to receive(:failure)
        subject.run(repository)
      end
    end
  end
end
