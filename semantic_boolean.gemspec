# frozen_string_literal: true

require_relative "lib/semantic_boolean/version"

Gem::Specification.new do |spec|
  spec.name = "semantic_boolean"
  spec.version = SemanticBoolean::VERSION
  spec.authors = ["Marian Kostyk"]
  spec.email = ["mariankostyk13895@gmail.com"]

  spec.summary = "Multiple ways to convert Ruby objects into booleans bundled in a single gem."
  spec.description = "Multiple ways to convert Ruby objects into booleans bundled in a single gem."
  spec.homepage = "https://github.com/marian13/semantic_boolean"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  spec.files = ::Dir["LICENSE.txt", "README.md", "lib/**/*"]

  spec.require_paths = ["lib"]

  spec.add_dependency "set"
end
