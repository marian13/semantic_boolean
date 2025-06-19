# Semantic Boolean

[![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)](https://www.ruby-lang.org/en/)

[![Gem Version](https://badge.fury.io/rb/semantic_boolean.svg)](https://rubygems.org/gems/semantic_boolean) [![Gem Downloads](https://img.shields.io/gem/dt/semantic_boolean.svg)](https://rubygems.org/gems/semantic_boolean)  ![GitHub repo size](https://img.shields.io/github/repo-size/marian13/semantic_boolean) [![GitHub Actions CI](https://github.com/marian13/semantic_boolean/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/marian13/semantic_boolean/actions/workflows/ci.yml) [![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard) [![Coverage Status](https://coveralls.io/repos/github/marian13/semantic_boolean/badge.svg)](https://coveralls.io/github/marian13/semantic_boolean?branch=main) 
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Multiple ways to convert Ruby objects into booleans bundled in a single gem.

## TL;DR

```ruby
require "semantic_boolean"

##
# Converts an object to the boolean using `!!`.
#
SemanticBoolean.to_ruby_bool(any_object)
# => true or false

##
# Alias for `SemanticBoolean.to_ruby_bool`.
#
SemanticBoolean.to_bool(any_object)
# => true or false

##
# Converts `true`, `"t"`, `"T"`, `"true"`, `"True"`, `"TRUE"`, `"on"`, `"On"`, `"ON"`, `"y"`,
# `"Y"`, `"yes"`, `"Yes"`, `"YES"`, positive numbers (like `1`, `1.0`, `BibDecimal("1")`)
# and strings with positive numbers (like `"1"`, `"1.0"`) to `true`.
# Returns `false` for anything else.
#
# Useful for parsing values read from `ENV`, CLI options, etc.
#
SemanticBoolean.to_env_bool(any_object)
# => true or false

##
# Converts to a boolean just like `ActiveModel::Type::Boolean.new.cast(object)` does.
# - https://api.rubyonrails.org/classes/ActiveModel/Type/Boolean.html
#
SemanticBoolean.to_active_model_boolean_type(any_object)
# => true, false, or nil

##
# Converts to a boolean just like Rails `blank?` does.
# - https://api.rubyonrails.org/classes/Object.html#method-i-blank-3F
#
SemanticBoolean.blank?(any_object)
# => true or false

##
# Converts to a boolean just like Rails `present?` does.
# - https://api.rubyonrails.org/classes/Object.html#method-i-present-3F
#
SemanticBoolean.present?(any_object)
# => true or false

##
# The following methods do not return boolean values, but they are often utilized in a boolean context.
##
SemanticBoolean.to_one_or_zero(any_object)
# => 1 or 0

SemanticBoolean.to_y_or_n(any_object)
# => "y" or "n"

SemanticBoolean.to_yes_or_no(any_object)
# => "yes" or "no"

SemanticBoolean.to_on_or_off(any_object)
# => "on" or "off"

SemanticBoolean.to_true_or_false(any_object)
# => true or false

##
# All the `to_one_or_zero`, `to_y_or_n`, `to_yes_or_no`, `to_on_or_off`, and `to_true_or_false` methods accept the `:by` keyword.
# `:to_ruby_bool` is the default value.
# `:to_bool`, `:to_env_bool`, `:to_active_model_boolean_type`, `:blank?` and `:present?` are also available.
#
SemanticBoolean.to_one_or_zero(any_object)
SemanticBoolean.to_y_or_n(any_object, by: :to_ruby_bool)
SemanticBoolean.to_yes_or_no(any_object, by: :to_bool)
SemanticBoolean.to_on_or_off(any_object, by: :to_env_bool)
SemanticBoolean.to_true_or_false(any_object, by: :to_active_model_boolean_type)
SemanticBoolean.to_one_or_zero(any_object, by: :blank?)
SemanticBoolean.to_y_or_n(any_object, by: :present?)

##
# Also there is the `:unknown` keyword.
# It allows to specify what should be returned when `object` is `nil`.
#
SemanticBoolean.to_one_or_zero(any_object, unknown: 127)
SemanticBoolean.to_yes_or_no(any_object, by: :to_env_bool, unknown: "unavailable")
```

Check the [specs](https://github.com/marian13/semantic_boolean/blob/main/spec/lib/semantic_boolean_spec.rb) to see a comprehensive comparison of all Semantic Boolean methods.

## Installation

### Bundler

Add the following line to your Gemfile:

```ruby
gem "semantic_boolean"
```

And then run:

```bash
bundle install
```

### Without Bundler

Execute the command below:

```bash
gem install semantic_boolean
```

## Performance

This gem is especially useful for one-time Ruby scripts, CLI applications, configuration parsers that are reading values from `ENV`, YAML files, etc.

However, if you have a code snippet where performance is a requirement, prefer using the original implementations (if you need [blank?](https://github.com/rails/rails/blob/main/activesupport/lib/active_support/core_ext/object/blank.rb), [present?](https://github.com/rails/rails/blob/main/activesupport/lib/active_support/core_ext/object/blank.rb), or [to_active_model_boolean_type](https://github.com/rails/rails/blob/main/activemodel/lib/active_model/type/boolean.rb)) or dive into the [Semantic Boolean source](https://github.com/marian13/semantic_boolean/blob/main/lib/semantic_boolean.rb) to extract only the parts that your application can leverage the most effectively.

## Credits

To the CLI enthusiasts, who allow me to pass words, numbers, and shortcuts to the same shell commands options depending on my mood.

```bash
DEBUG=1
SKIP_AUTH=no
--verbose=y
--tracking=off
```

To the Rails team. They made me a Ruby dev who can't live without Rails goodies in the non-Rails projects.
