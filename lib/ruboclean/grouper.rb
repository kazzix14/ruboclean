# frozen_string_literal: true

module Ruboclean
  # Groups the rubocop configuration items into three categories:
  #   - base: base configuration like 'require', 'inherit_from', etc
  #   - namespaces: every item which does **not** include an "/"
  #   - cops: every item which **includes** an "/"
  class Grouper
    def initialize(configuration_hash)
      @configuration_hash = configuration_hash
    end

    def group_config
      configuration_hash.each_with_object(empty_groups) do |item, result|
        key, value = item
        target_group = find_target_group(key)
        result[target_group].merge!({ key => value })
      end
    end

    private

    attr_reader :configuration_hash

    def empty_groups
      { base: {}, namespaces: {}, cops: {} }
    end

    def find_target_group(key)
      return :base if key.start_with?(/[a-z]/)
      return :cops if key.include?("/")

      :namespaces
    end
  end
end
