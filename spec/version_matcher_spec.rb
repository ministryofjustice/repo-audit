require_relative 'spec_helper'

describe RepoAudit::VersionMatcher do
  let(:content) { 'content' }
  let(:version_regex) { 'version_regex' }

  subject { described_class.new(content: content, version_regex: version_regex) }

  describe '.new' do
    it 'receives the content and the version regex' do
      expect { subject }.not_to raise_error
    end

    it 'raise an error if wrong arguments' do
      expect { described_class.new }.to raise_error(/missing keywords: content, version_regex/)
    end
  end

  describe '#satisfies?' do
    context 'for successful results' do
      let(:content) { '1.2.3' }
      let(:version_regex) { '^(?<version>\S+)$' }

      it { expect(subject.satisfies?('1.2.3')).to eq(true) }
      it { expect(subject.satisfies?('> 1.2')).to eq(true) }
      it { expect(subject.satisfies?('>= 1.2')).to eq(true) }
      it { expect(subject.satisfies?('< 2.0')).to eq(true) }
      it { expect(subject.satisfies?('<= 1.2.3')).to eq(true) }
      it { expect(subject.satisfies?('~> 1.2.2')).to eq(true) }
      it { expect(subject.satisfies?('~> 1.0')).to eq(true) }
    end

    context 'for unsuccessful results' do
      let(:content) { '1.2.3' }
      let(:version_regex) { '^(?<version>\S+)$' }

      it { expect(subject.satisfies?('1.2.4')).to eq(false) }
      it { expect(subject.satisfies?('> 1.3')).to eq(false) }
      it { expect(subject.satisfies?('>= 1.3')).to eq(false) }
      it { expect(subject.satisfies?('< 1.2.3')).to eq(false) }
      it { expect(subject.satisfies?('<= 1.2.2')).to eq(false) }
      it { expect(subject.satisfies?('~> 1.3')).to eq(false) }
      it { expect(subject.satisfies?('~> 0.9')).to eq(false) }

      context 'when no match was found in content' do
        let(:content) { 'lorem ipsum' }
        it { expect(subject.satisfies?('1.2.3')).to eq(false) }
      end
    end
  end
end
