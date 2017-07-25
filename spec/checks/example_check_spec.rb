require_relative '../spec_helper'

describe RepoAudit::Checks::ExampleCheck do
  let(:metadata)  { {description: 'check description', style_guide_url: 'www.example.com'} }
  let(:arguments) { {name_matcher: 'hello'} }

  subject { described_class.new(metadata, arguments) }

  it_behaves_like 'a Check', name: :example

  context '#run' do
    let(:repository) { double('Repository', name: repo_name) }

    context 'for a success result' do
      let(:repo_name) { 'hello-world-service' }

      it 'returns the expected result' do
        expect(subject.run(repository)).to \
          eq('RepoAudit::Checks::ExampleCheck' => {result: :success, description: 'check description'})
      end
    end

    context 'for a failure result' do
      let(:repo_name) { 'world-deploy' }

      it 'returns the expected result' do
        expect(subject.run(repository)).to \
          eq('RepoAudit::Checks::ExampleCheck' => {result: :failure, description: 'check description'})
      end
    end
  end
end
