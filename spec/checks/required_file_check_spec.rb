require_relative '../spec_helper'

describe RepoAudit::Checks::RequiredFileCheck do
  let(:metadata)  { {description: 'check description', style_guide_url: 'www.example.com'} }
  let(:arguments) { {filename: 'document.txt'} }

  subject { described_class.new(metadata, arguments) }

  it 'registered itself in the factory store' do
    expect(RepoAudit::ChecksFactory.fetch(:required_file_check)).to eq(described_class)
  end

  describe '.new' do
    it 'requires the metadata and the arguments' do
      expect { described_class.new }.to raise_error(ArgumentError, /given 0, expected 2/)
    end

    context 'configures the check with the metadata' do
      context '`description` declared in the metadata' do
        it 'has a description' do
          expect(subject.description).to eq('check description')
        end
      end

      context '`description` not declared in the metadata' do
        let(:metadata) { super().except(:description) }

        it 'raises an error' do
          expect { subject.description }.to raise_error(KeyError, /description/)
        end
      end

      context 'style_guide_url declared in the metadata' do
        it 'has a style_guide_url' do
          expect(subject.style_guide_url).to eq('www.example.com')
        end
      end

      context 'style_guide_url not declared in the metadata' do
        let(:metadata) { super().except(:style_guide_url) }

        it 'has a default style_guide_url value' do
          expect(subject.style_guide_url).to eq('n/a')
        end
      end
    end

    context 'configures the check with the arguments' do
      context 'when expected arguments are provided' do
        it 'sets the `name_matcher` value' do
          expect(subject.filename).to eq('document.txt')
        end
      end

      context 'when unexpected arguments are provided' do
        let(:arguments) { {whatever: 'hello'} }

        it 'raises an exception' do
          expect { subject.name_matcher }.to raise_error(NoMethodError, /whatever/)
        end
      end
    end
  end

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
