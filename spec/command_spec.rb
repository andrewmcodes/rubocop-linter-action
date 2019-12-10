# frozen_string_literal: true

require './spec/spec_helper'

describe Command do
  let(:config) { YAML.safe_load(File.read('./spec/fixtures/config.yml')) }

  context 'when config file exists' do
    it 'returns built command' do
      command = Command.new(config).build
      expect(command).to eq(
        'git diff origin/master --name-only --diff-filter=AM | xargs rubocop --parallel '\
         '-f json --fail-level error -c .rubocop.yml --except Style/FrozenStringLiteralComment'
      )
    end
  end

  context 'when config file does not exist' do
    it 'returns base command' do
      command = Command.new(nil).build
      expect(command).to eq('rubocop --parallel -f json')
    end
  end
end
