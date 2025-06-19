# Semantic Boolean

[![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)](https://www.ruby-lang.org/en/)

[![Gem Version](https://badge.fury.io/rb/semantic_boolean.svg)](https://rubygems.org/gems/semantic_boolean) [![Gem Downloads](https://img.shields.io/gem/dt/semantic_boolean.svg)](https://rubygems.org/gems/semantic_boolean)  ![GitHub repo size](https://img.shields.io/github/repo-size/marian13/semantic_boolean) [![GitHub Actions CI](https://github.com/marian13/semantic_boolean/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/marian13/semantic_boolean/actions/workflows/ci.yml) [![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard) [![Coverage Status](https://coveralls.io/repos/github/marian13/semantic_boolean/badge.svg)](https://coveralls.io/github/marian13/semantic_boolean?branch=main) 
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Multiple ways to convert Ruby objects into booleans bundled in a single gem.

## Usage

```ruby
require "semantic_boolean"

SemanticBoolean.to_ruby_bool(any_object)
# => true or false

SemanticBoolean.to_bool(any_object) # Alias for `to_ruby_bool`.
# => true or false

SemanticBoolean.to_env_bool(any_object)
# => true or false

SemanticBoolean.to_active_model_boolean_type(any_object) # https://api.rubyonrails.org/classes/ActiveModel/Type/Boolean.html
# => true, false, or nil

SemanticBoolean.blank?(any_object) # https://api.rubyonrails.org/classes/Object.html#method-i-blank-3F
# => true or false

SemanticBoolean.present?(any_object) # https://api.rubyonrails.org/classes/Object.html#method-i-present-3F
# => true or false

SemanticBoolean.to_one_or_zero(any_object)
# => 1 or 0

SemanticBoolean.to_y_or_n(any_object)
# => "y" or "n"

SemanticBoolean.to_yes_or_no(any_object)
# => "yes" or "no"

SemanticBoolean.to_on_or_off(any_object)
# => "on" or "off"

##
# All `to_one_or_zero`, `to_y_or_n`, `to_yes_or_no`, and `to_on_or_off` methods accept `:by` keyword.
# `:to_ruby_bool` is the default value. `:to_env_bool`, `:to_active_model_boolean_type`, `:blank?` and `:present?` are also available.
#
SemanticBoolean.to_one_or_zero(any_object)
SemanticBoolean.to_y_or_n(any_object, by: :to_ruby_bool)
SemanticBoolean.to_y_or_n(any_object, by: :to_bool)
SemanticBoolean.to_yes_or_no(any_object, by: :to_env_bool)
SemanticBoolean.to_yes_or_no(any_object, by: :to_active_model_boolean_type)
SemanticBoolean.to_on_or_off(any_object, by: :blank?)
SemanticBoolean.to_on_or_off(any_object, by: :present?)
```
