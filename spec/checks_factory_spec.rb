require_relative 'spec_helper'

describe RepoAudit::ChecksFactory do
  let(:test_check_class) { spy }

  subject { described_class }

  describe '.register' do
    it 'adds a new check to the internal store' do
      expect {
        subject.register(:test_check, test_check_class)
      }.to change { subject.registered_checks.size }.by(1)
    end

    it 'register the check class with the given type' do
      subject.register(:test_check, test_check_class)
      expect(subject.registered_checks[:test_check]).to eq(test_check_class)
    end
  end

  describe '.fetch' do
    context 'for a check not found in the store' do
      it 'raises an exception' do
        expect {
          subject.fetch(:nonexistent)
        }.to raise_error(RepoAudit::ChecksFactory::CheckNotFoundError, 'nonexistent')
      end
    end

    context 'for an existing check' do
      before do
        allow(subject).to receive(:registered_checks).and_return(test_check: test_check_class)
      end

      it 'returns the check class' do
        expect(subject.fetch(:test_check)).to eq(test_check_class)
      end
    end
  end

  describe '.build' do
    before do
      allow(subject).to receive(:registered_checks).and_return(test_check: test_check_class)
    end

    it 'it retrieves the check from the store' do
      expect(subject).to receive(:fetch).with(:test_check).and_call_original
      subject.build(:test_check, nil, nil)
    end

    it 'instantiate a check, given their type' do
      subject.build(:test_check, {description: 'blah'}, {arg1: 'xxx'})
      expect(test_check_class).to have_received(:new).with({description: 'blah'}, {arg1: 'xxx'})
    end
  end
end
