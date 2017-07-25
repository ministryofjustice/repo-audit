require_relative 'spec_helper'

describe RepoAudit::Report do
  let(:repo) { double(full_name: 'some-user/not-a-real-repo') }
  let(:checks_collection) { spy('checks_collection') }

  subject { described_class.new(repo: repo, checks: checks_collection) }

  it 'accepts a repo and their checks' do
    expect { described_class.new(repo: repo, checks: checks_collection) }.to_not raise_error
  end

  it 'raises an exception when required arguments are not supplied' do
    expect { described_class.new(foo: 'bar') }.to raise_error(ArgumentError)
  end

  it 'reports on a repo' do
    expect(checks_collection).to receive(:run).with(repo)
    expect(repo).to receive(:full_name)

    subject.run
  end

  it 'returns a report hash' do
    expect(checks_collection).to receive(:run).and_return(
      [{'TestCheck' => {result: :success, description: 'A description'}}]
    )
    expect(subject.run).to eq(
      { repo: "some-user/not-a-real-repo", results: [{'TestCheck' => {result: :success, description: 'A description'}}] }
    )
  end
end
