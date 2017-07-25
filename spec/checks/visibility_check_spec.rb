require_relative '../spec_helper'

describe RepoAudit::Checks::VisibilityCheck do
  let(:metadata)  { {description: 'visibility check', style_guide_url: 'www.example.com'} }
  subject(:check) { described_class.new(metadata) }

  it_behaves_like 'a Check', name: :visibility

  context 'for a public repo' do
    let(:repository) { double('Repository', private: false) }

    it 'returns the expected result' do
      expect(check.run(repository)).to \
        eq('RepoAudit::Checks::VisibilityCheck' => {
          result: { visibility: :public },
          description: 'visibility check'
        })
    end
  end

  context 'for a private repo' do
    let(:repository) { double('Repository', private: true) }

    it 'returns the expected result' do
      expect(check.run(repository)).to \
        eq('RepoAudit::Checks::VisibilityCheck' => {
          result: { visibility: :private },
          description: 'visibility check'
        })
    end
  end
end
