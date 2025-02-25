# frozen_string_literal: true

require "test_helper"

class RubocleanTest < BaseTest
  def test_that_it_has_a_version_number
    refute_nil ::Ruboclean::VERSION
  end

  def test_run_from_cli_without_silent_option
    using_fixture_files("02_input_empty.yml") do |fixture_path|
      assert_output(/^Using path '.*' \.\.\. done.$/) do
        Ruboclean.run_from_cli!([fixture_path])
      end
    end
  end

  def test_run_from_cli_with_silent_option
    using_fixture_files("02_input_empty.yml") do |fixture_path|
      assert_output(/^$/) do
        Ruboclean.run_from_cli!([fixture_path, "--silent"])
      end
    end
  end
end
