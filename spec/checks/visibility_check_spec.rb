require_relative '../spec_helper'

describe RepoAudit::Checks::VisibilityCheck do
  let(:metadata)  { {description: 'visibility check', style_guide_url: 'www.example.com'} }
  subject(:check) { described_class.new(metadata) }

  it_behaves_like 'a Check', name: :visibility

  context 'for a public repo' do
    let(:repository) { double('Repository', private: false) }

    it 'passes' do
      expect(check).to receive(:success)
      check.run(repository)
    end
  end

  context 'for a private repo' do
    let(:repository) { double('Repository', private: true) }

    it 'fails' do
      expect(check).to receive(:failure)
      check.run(repository)
    end
  end
end
