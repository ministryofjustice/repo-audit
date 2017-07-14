require_relative 'spec_helper'

describe RepoAudit::ChecksCollection do
  let(:check1) { spy('check1') }
  let(:check2) { spy('check2') }
  let(:checks_config) { [check1, check2] }

  subject { described_class.new(config: checks_config) }

  describe '.new' do
    before do
      allow(RepoAudit::ChecksFactory).to receive(:build)
    end

    it 'builds the checks using their configuration' do
      expect(subject).to be_an_instance_of(described_class)

      expect(check1).to have_received(:type)
      expect(check1).to have_received(:metadata)
      expect(check1).to have_received(:arguments)

      expect(check2).to have_received(:type)
      expect(check2).to have_received(:metadata)
      expect(check2).to have_received(:arguments)
    end

    it 'behaves like an array' do
      expect(subject.size).to eq(2)
      expect(subject.each).to be_an_instance_of(Enumerator)
    end
  end

  describe '#run' do
    let(:repo) { double('repository') }

    before do
      allow(RepoAudit::ChecksFactory).to receive(:build).and_return(check1, check2)
    end

    it 'should receive the repository as argument' do
      expect { subject.run }.to raise_error(ArgumentError)
    end

    it 'iterates through the checks, invoking their `#run` method' do
      subject.run(repo)
      expect(check1).to have_received(:run).with(repo)
      expect(check2).to have_received(:run).with(repo)
    end

    context 'results' do
      before do
        allow(check1).to receive(:run).and_return('result1')
        allow(check2).to receive(:run).and_return('result2')
      end

      it 'returns a collection with the results of the checks' do
        expect(subject.run(repo)).to eq(%w[result1 result2])
      end
    end
  end
end
