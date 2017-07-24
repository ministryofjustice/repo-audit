require_relative '../spec_helper'

RSpec.shared_examples 'a Check' do |options|
  let(:name) { options.fetch(:name) }

  it 'registered itself in the factory store' do
    expect(RepoAudit::ChecksFactory.fetch(name)).to eq(described_class)
  end

  describe '.new' do
    it 'requires the metadata and optionally the arguments' do
      expect { described_class.new }.to raise_error(ArgumentError, /given 0, expected 1..2/)
    end

    context 'configures the check with the metadata' do
      context '`description` declared in the metadata' do
        it 'has a description' do
          expect(subject.description).to eq(metadata[:description])
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
          expect(subject.style_guide_url).to eq(metadata[:style_guide_url])
        end
      end

      context 'style_guide_url not declared in the metadata' do
        let(:metadata) { super().except(:style_guide_url) }

        it 'has a default style_guide_url value' do
          expect(subject.style_guide_url).to eq('n/a')
        end
      end
    end

    context 'when unexpected arguments are provided' do
      let(:arguments) { {whatever: 'hello'} }

      it 'raises an exception' do
        expect { subject.whatever }.to raise_error(NoMethodError, /whatever/)
      end
    end
  end
end
