require_relative 'spec_helper'

describe RepoAudit::Configuration do
  let(:config_file) { 'spec/fixtures/example-config.yml' }
  let(:loader_class) { class_double('Loader') }

  subject { described_class.load(config_file) }

  describe '.load' do
    it 'returns a Configuration instance' do
      expect(subject).to be_an_instance_of(described_class)
    end

    it 'uses the loader class to read the file' do
      expect(loader_class).to receive(:load).with(config_file)
      described_class.load(config_file, loader_class)
    end
  end

  describe 'access configuration with method-based reading' do
    it { expect(subject.checks.size).to eq(2) }

    it { expect(subject.checks.first.type).to eq(:check_a) }
    it { expect(subject.checks.first.metadata?).to eq(true) }
    it { expect(subject.checks.first.metadata.description).to eq('My check A description') }
    it { expect(subject.checks.first.arguments?).to eq(true) }
    it { expect(subject.checks.first.arguments.whatever).to eq('just a test') }

    it { expect(subject.checks.last.type).to eq(:check_b) }
    it { expect(subject.checks.last.arguments?).to eq(false) }
    it { expect(subject.checks.last.arguments).to be_nil }
  end
end
