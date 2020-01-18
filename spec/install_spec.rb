# typed: false
require "./spec/spec_helper"

describe Install do
  subject { described_class.new(config) }

  let(:config) { YAML.safe_load(config_file) }

  before { allow(subject).to receive(:system) }

  describe "#run" do
    before { subject.run }

    context "when there's no configuration" do
      let(:config_file) { "" }

      it { expect(subject).to have_received(:system).with("gem install rubocop") }
    end

    context "when it's set to resolve dependencies through bundler" do
      let(:config_file) do
        <<~YAML
          bundle: true
        YAML
      end

      it { expect(subject).to have_received(:system).with("bundle install") }
    end

    context "when there's no version specified" do
      let(:config_file) do
        <<~YAML
          versions:
            - rubocop
        YAML
      end

      it { expect(subject).to have_received(:system).with("gem install rubocop") }
    end

    context "when the versions are specified" do
      let(:config_file) do
        <<~YAML
          versions:
            - rubocop: 0.79.0
            - rubocop-rails
            - rubocop-rspec: latest
        YAML
      end

      it { expect(subject).to have_received(:system).with("gem install rubocop:0.79.0 rubocop-rails rubocop-rspec") }

      context "when 'rubocop' is not included in the dependencies" do
        let(:config_file) do
          <<~YAML
            versions:
              - rubocop-rails
              - rubocop-rspec: 1.37.0
          YAML
        end

        it { expect(subject).to have_received(:system).with("gem install rubocop rubocop-rails rubocop-rspec:1.37.0") }
      end
    end
  end
end
