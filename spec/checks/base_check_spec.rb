require_relative '../spec_helper'

describe RepoAudit::Checks::BaseCheck do
  let(:metadata)  { {description: 'check description', style_guide_url: 'www.example.com'} }
  subject(:check) { described_class.new(metadata) }

  context 'when arguments is not a hash' do
    let(:arguments) { 'this is not a hash' }

    it 'ignores arguments' do
      described_class.new(metadata, arguments)
    end
  end

  context 'with arguments hash' do
    let(:arguments) { { foo: 'bar' } }

    class Wibble < RepoAudit::Checks::BaseCheck
      attr_accessor :foo
    end

    it 'sets attributes from arguments' do
      check = Wibble.new(metadata, arguments)
      expect(check.foo).to eq('bar')
    end
  end

  context 'without description' do
    let(:metadata)  { {style_guide_url: 'www.example.com'} }

    it 'fails to initalise' do
      expect{ described_class.new(metadata) }.to raise_error(KeyError)
    end
  end

  context 'without style_guide_url' do
    let(:metadata)  { {description: 'check description'} }

    it 'defaults style_guide_url' do
      expect(check.style_guide_url).to eq('n/a')
    end
  end

  it 'sets style_guide_url from metadata' do
    expect(check.style_guide_url).to eq('www.example.com')
  end

  it 'sets description from metadata' do
    expect(check.description).to eq('check description')
  end

  it 'raises when run' do
    expect {
      check.run
    }.to raise_error('implement in subclasses')
  end

  it 'calls result with :failure' do
    expect(check).to receive(:result).with(:failure)
    check.send(:failure)
  end

  it 'calls result with :success' do
    expect(check).to receive(:result).with(:success)
    check.send(:success)
  end

  it 'returns a result hash' do
    result = check.send(:result, 'whatever')

    expect(result).to eq({
      'RepoAudit::Checks::BaseCheck' => {
        result: 'whatever',
        description: 'check description'
      }
    })
  end
end
