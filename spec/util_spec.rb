# typed: false
require "./spec/spec_helper"

describe Util do
  subject { Util }

  context "path doesn't exist" do
    it "#read_json" do
      expect(subject.read_json("fake/test/file.json")).to eq({})
      expect do
        subject.read_json("fake/test/file.json")
      end.to output("\"Notice: No file: fake/test/file.json\"\n").to_stdout
    end

    it "#read_yaml" do
      expect(subject.read_yaml("fake/test/file.yml")).to eq({})
      expect do
        subject.read_yaml("fake/test/file.yml")
      end.to output("\"Notice: No file: fake/test/file.yml\"\n").to_stdout
    end
  end

  context "path does exist" do
    it "#read_json" do
      expect(subject.read_json("./spec/fixtures/example.json")).to eq("example" => "json")
    end

    it "#read_yaml" do
      expect(subject.read_yaml("./spec/fixtures/example.yml")).to eq("example" => "yaml")
    end
  end
end
