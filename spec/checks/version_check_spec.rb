require_relative '../spec_helper'

describe RepoAudit::Checks::VersionCheck do
  let(:metadata)  { {description: 'check description', style_guide_url: 'www.example.com'} }
  let(:arguments) { {version: '~> 2.2', file_matchers: [{'Gemfile' => "^ruby '(?<version>\.*)'$"}]} }

  subject { described_class.new(metadata, arguments) }

  it_behaves_like 'a Check', name: :version

  context '#run' do
    let(:repository) { double('Repository', full_name: 'org/repo-name') }

    before do
      allow(RepoAudit::FileRequestHelper).to receive(:fetch).with(
        'https://raw.githubusercontent.com/org/repo-name/master/Gemfile'
      ).and_return(file_content)
    end

    context 'for a success result' do
      let(:file_content) { "ruby '2.3.3'" }

      it 'invokes the `success` result' do
        expect(subject).to receive(:success)
        subject.run(repository)
      end
    end

    context 'for a failure result' do
      context 'the version found in the file content does not satisfy the required version' do
        let(:file_content) { "ruby '2.1.1'" }

        it 'invokes the `failure` result' do
          expect(subject).to receive(:failure)
          subject.run(repository)
        end
      end

      context 'no version was found in the file content' do
        let(:file_content) { 'Lorem ipsum dolor sit amet, MIT License.' }

        it 'invokes the `failure` result' do
          expect(subject).to receive(:failure)
          subject.run(repository)
        end
      end
    end
  end
end
