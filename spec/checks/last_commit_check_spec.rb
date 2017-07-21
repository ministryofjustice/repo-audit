require_relative '../spec_helper'

describe RepoAudit::Checks::LastCommitCheck do
  let(:metadata)  { {description: 'check description', style_guide_url: 'www.example.com'} }
  let(:arguments) { {} }
  subject(:check) { described_class.new(metadata, arguments) }

  it_behaves_like 'a Check', name: :last_commit_check
end
