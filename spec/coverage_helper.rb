# frozen_string_literal: true

require "simplecov"
require "simplecov-lcov"

SimpleCov::Formatter::LcovFormatter.config do |config|
  config.report_with_single_file = true

  config.single_report_path = File.join("coverage", RUBY_ENGINE, RUBY_ENGINE_VERSION, "lcov.info")
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::LcovFormatter
])

SimpleCov.start do
  if Gem::Version.create(RUBY_VERSION) >= ::Gem::Version.create("2.5")
    enable_coverage :branch
  end

  add_filter "/spec/"
end
