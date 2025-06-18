# Semantic Boolean

[![Coverage Status](https://coveralls.io/repos/github/marian13/semantic_boolean/badge.svg?branch=main)](https://coveralls.io/github/marian13/semantic_boolean?branch=main)

## Usage

```ruby
require "semantic_boolean"

SemanticBoolean.to_ruby_bool(any_object)
# => true or false

SemanticBoolean.to_bool(any_object) # Alias for `to_ruby_bool`.
# => true or false

SemanticBoolean.to_env_bool(any_object)
# => true or false

SemanticBoolean.to_active_model_boolean_type(any_object)
# => true, false, or nil

SemanticBoolean.to_one_or_zero(any_object)
# => 1 or 0

SemanticBoolean.to_y_or_n(any_object)
# => "y" or "n"

SemanticBoolean.to_yes_or_no(any_object)
# => "yes" or "no"

SemanticBoolean.to_on_or_off(any_object)
# => "on" or "off"

##
# All `to_one_or_zero`, `to_y_or_n`, `to_yes_or_no`, and `to_on_or_off` methods accept `:as` keyword.
# `:ruby_bool` is the default value. `:env_bool` and `:active_model_boolean_type` are also available.
#
SemanticBoolean.to_one_or_zero(any_object)
SemanticBoolean.to_y_or_n(any_object, as: :ruby_bool)
SemanticBoolean.to_yes_or_no(any_object, as: :env_bool)
SemanticBoolean.to_on_or_off(any_object, as: :active_model_boolean_type)
```

<details>
  <summary>
    Click to open the comparison table.
  </summary>

  | object | to_ruby_bool | to_env_bool | to_active_model_boolean_type |
  | - | - | - | - |
  | `true` | `true` | `true` | `true` |
  | `false` | `false` | `false` | `false` |
  | | | | |
  | `nil` | `false` | `false` | `true` |
  | `""` | `true` | `false` | `nil` |
  | | | | |
  | `"t"` | `true` | `true` | `true` |
  | `"f"` | `true` | `false` | `false` |
  | | | | |
  | `:t` | `true` | `true` | `true` |
  | `:f` | `true` | `false` | `false` |
  | | | | |
  | `"T"` | `true` | `true` | `true` |
  | `"F"` | `true` | `false` | `false` |
  | | | | |
  | `:T` | `true` | `true` | `true` |
  | `:F` | `true` | `false` | `false` |
  | | | | |
  | `"true"` | `true` | `true` | `true` |
  | `"false"` | `true` | `false` | `false` |
  | | | | |
  | `:true` | `true` | `true` | `true` |
  | `:false` | `true` | `false` | `false` |
  | | | | |
  | `"True"` | `true` | `true` | `true` |
  | `"False"` | `true` | `false` | `true` |
  | | | | |
  | `:True` | `true` | `true` | `true` |
  | `:False` | `true` | `false` | `true` |
  | | | | |
  | `"tRuE"` | `true` | `false` | `true` |
  | `"fAlSe"` | `true` | `false` | `true` |
  | | | | |
  | `:tRuE` | `true` | `false` | `true` |
  | `:fAlSe` | `true` | `false` | `true` |
  | | | | |
  | `"TRUE"` | `true` | `true` | `true` |
  | `"FALSE"` | `true` | `false` | `false` |
  | | | | |
  | `:TRUE` | `true` | `true` | `true` |
  | `:FALSE` | `true` | `false` | `false` |
  | | | | |
  | `"on"` | `true` | `true` | `true` |
  | `"off"` | `true` | `false` | `false` |
  | | | | |
  | `:on` | `true` | `true` | `true` |
  | `:off` | `true` | `false` | `false` |
  | | | | |
  | `"On"` | `true` | `true` | `true` |
  | `"Off"` | `true` | `false` | `true` |
  | | | | |
  | `:On` | `true` | `true` | `true` |
  | `:Off` | `true` | `false` | `true` |
  | | | | |
  | `"oN"` | `true` | `false` | `true` |
  | `"oFf"` | `true` | `false` | `true` |
  | | | | |
  | `:oN` | `true` | `false` | `true` |
  | `:oFf` | `true` | `false` | `true` |
  | | | | |
  | `"ON"` | `true` | `true` | `true` |
  | `"OFF"` | `true` | `false` | `false` |
  | | | | |
  | `:ON` | `true` | `true` | `true` |
  | `:OFF` | `true` | `false` | `false` |
  | | | | |
  | `"y"` | `true` | `true` | `true` |
  | `"n"` | `true` | `false` | `true` |
  | | | | |
  | `:y` | `true` | `true` | `true` |
  | `:n` | `true` | `false` | `true` |
  | | | | |
  | `"yes"` | `true` | `true` | `true` |
  | `"no"` | `true` | `false` | `true` |
  | | | | |
  | `:yes` | `true` | `true` | `true` |
  | `:no` | `true` | `false` | `true` |
  | | | | |
  | `"Yes"` | `true` | `true` | `true` |
  | `"No"` | `true` | `false` | `true` |
  | | | | |
  | `:Yes` | `true` | `true` | `true` |
  | `:No` | `true` | `false` | `true` |
  | | | | |
  | `"yEs"` | `true` | `false` | `true` |
  | `"nO"` | `true` | `false` | `true` |
  | | | | |
  | `:yEs` | `true` | `false` | `true` |
  | `:nO` | `true` | `false` | `true` |
  | | | | |
  | `"YES"` | `true` | `true` | `true` |
  | `"NO"` | `true` | `false` | `true` |
  | | | | |
  | `:YES` | `true` | `true` | `true` |
  | `:NO` | `true` | `false` | `true` |
  | | | | |
  | `"1"` | `true` | `true` | `true` |
  | `"0"` | `true` | `false` | `false` |
  | | | | |
  | `:"1"` | `true` | `true` | `true` |
  | `:"0"` | `true` | `false` | `false` |
  | | | | |
  | `1` | `true` | `true` | `true` |
  | `0` | `true` | `false` | `false` |
  | | | | |
  | `"2"` | `true` | `true` | `true` |
  | `"-1"` | `true` | `false` | `true` |
  | | | | |
  | `:"2"` | `true` | `true` | `true` |
  | `:"-1"` | `true` | `false` | `true` |
  | | | | |
  | `2` | `true` | `true` | `true` |
  | `-1` | `true` | `false` | `true` |
  | | | | |
  | `"1.0"` | `true` | `false` | `true` |
  | `"0.0"` | `true` | `false` | `true` |
  | | | | |
  | `:"1.0"` | `true` | `false` | `true` |
  | `:"0.0"` | `true` | `false` | `true` |
  | | | | |
  | `1.0` | `true` | `false` | `true` |
  | `0.0` | `true` | `false` | `true` |
  | | | | |
  | `"2.0"` | `true` | `false` | `true` |
  | `"-1.0"` | `true` | `false` | `true` |
  | | | | |
  | `:"2.0"` | `true` | `false` | `true` |
  | `:"-1.0"` | `true` | `false` | `true` |
  | | | | |
  | `2.0` | `true` | `false` | `true` |
  | `-1.0` | `true` | `false` | `true` |
  | | | | |
  | `BigDecimal("1.0")` | `true` | `false` | `true` |
  | `BigDecimal("0.0")` | `true` | `false` | `true` |
  | | | | |
  | `BigDecimal("2.0")` | `true` | `false` | `true` |
  | `BigDecimal("-1.0")` | `true` | `false` | `true` |
  | | | | |
  | `1r` | `true` | `false` | `true` |
  | `0r` | `true` | `false` | `true` |
  | | | | |
  | `2r` | `true` | `false` | `true` |
  | `-1r` | `true` | `false` | `true` |
  | | | | |
  | `[]` | `true` | `false` | `true` |
  | `{}` | `true` | `false` | `true` |
  | `Object.new` | `true` | `false` | `true` |
  | `Class.new` | `true` | `false` | `true` |
</details>
