# frozen_string_literal: true

require_relative "semantic_boolean/version"

# rubocop:disable Lint/BooleanSymbol
module SemanticBoolean
  class << self
    TO_ENV_BOOL_TRUE_VALUES = ["t", "T", "true", "True", "TRUE", "on", "On", "ON", "y", "Y", "yes", "Yes", "YES"].to_set.freeze
    TO_ACTIVE_MODEL_BOOLEAN_TYPE_FALSE_VALUES = [false, 0, "0", :"0", "f", :f, "F", :F, "false", :false, "FALSE", :FALSE, "off", :off, "OFF", :OFF].to_set.freeze

    ##
    # Returns `false` when `object` is `false` or `nil`. Returns `true` for all the other cases.
    #
    # @param object [Object] Can be any type.
    # @return [Boolean]
    #
    def to_ruby_bool(object)
      !!object
    end

    ##
    # A handy alias for `to_ruby_bool`.
    #
    # @return [Boolean]
    #
    alias_method :to_bool, :to_ruby_bool

    ##
    # Converts `object` to a boolean by the following logic:
    # - Converts `object` to string by `#to_s` and checks whether it is one of `["t", "T", "true", "True", "TRUE", "on", "On", "ON", "y", "Y", "yes", "Yes", "YES"]`.
    # - If yes, returns `true`, otherwise it converts `object` to an integer by `Kernel.Integer` and checks whether it is greater than zero.
    # - If yes, returns `true`, otherwise returns `false`.
    #
    # @param object [Object] Can be any type.
    # @return [Boolean]
    #
    def to_env_bool(object)
      string = object.to_s

      return false if string.empty?

      return true if TO_ENV_BOOL_TRUE_VALUES.include?(string)

      integer = ::Kernel.Integer(string, exception: false)

      return false unless integer

      integer > 0
    end

    ##
    # Converts `object` to boolean (or `nil`) using exactly the same logic as `ActiveModel::Type::Boolean.new.cast(object)` does.
    #
    # @param object [Object] Can be any type.
    # @return [Boolean, nil]
    # @see https://github.com/rails/rails/blob/v8.0.2/activemodel/lib/active_model/type/boolean.rb#L39
    #
    def to_active_model_boolean_type(object)
      (object == "") ? nil : !TO_ACTIVE_MODEL_BOOLEAN_TYPE_FALSE_VALUES.include?(object)
    end

    ##
    # @param object [Object] Can be any type.
    # @param as [Symbol, String].
    # @return [Integer]
    #
    def to_one_or_zero(object, as: :ruby_bool)
      public_send("to_#{as}", object) ? 1 : 0
    end

    ##
    # @param object [Object] Can be any type.
    # @param as [Symbol, String].
    # @return [String]
    #
    def to_y_or_n(object, as: :ruby_bool)
      public_send("to_#{as}", object) ? "y" : "n"
    end

    ##
    # @param object [Object] Can be any type.
    # @param as [Symbol, String].
    # @return [String]
    #
    def to_yes_or_no(object, as: :ruby_bool)
      public_send("to_#{as}", object) ? "yes" : "no"
    end

    ##
    # @param object [Object] Can be any type.
    # @param as [Symbol, String].
    # @return [String]
    #
    def to_on_or_off(object, as: :ruby_bool)
      public_send("to_#{as}", object) ? "on" : "off"
    end
  end
end
# rubocop:enable Lint/BooleanSymbol
