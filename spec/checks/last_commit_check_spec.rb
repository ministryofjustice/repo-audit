require_relative '../spec_helper'

describe RepoAudit::Checks::LastCommitCheck do
  let(:metadata)  { {description: 'check description', style_guide_url: 'www.example.com'} }
  subject(:check) { described_class.new(metadata) }

  it_behaves_like 'a Check', name: :last_commit

  context '#run' do
    let(:repository) { double('Repository', name: 'my-repo') }
    let(:date) { "2017-07-20T09:39:39Z" }
    let(:commit_hash) {
      {
        "commit" => {
          "author" => {
            "name" => "Jesus Laiz",
            "email" => "zheileman@users.noreply.github.com",
            "date" => date
          }
        }
      }
    }

    before do
      allow(repository).to receive_message_chain(:owner, login: 'ministryofjustice')
      allow(RepoAudit::RepositoryHelper).to receive(:last_commit).and_return(commit_hash)
    end

    it 'returns the expected result' do
      expect(check.run(repository)).to \
        eq('RepoAudit::Checks::LastCommitCheck' => {
          result: {
            timestamp: DateTime.parse(date),
            author: {
              name: "Jesus Laiz",
              email: "zheileman@users.noreply.github.com"
            }
          },
          description: 'check description'
      })
    end

  end

end
