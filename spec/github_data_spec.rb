# typed: false
require "./spec/spec_helper"

describe Github::Data do
  subject { Github::Data.new(event) }

  it "#sha" do
    expect(subject.sha).to eq("sha")
  end

  it "#token" do
    expect(subject.token).to eq("token")
  end

  context "environment variables exist" do
    it "#owner" do
      expect(subject.owner).to eq("owner")
    end

    it "#repo" do
      expect(subject.repo).to eq("repository_name")
    end
  end

  it "#workspace" do
    expect(subject.workspace).to eq("workspace")
  end
end
