# frozen_string_literal: true

require_relative "semantic_boolean/version"

require "set"

# rubocop:disable Lint/BooleanSymbol
module SemanticBoolean
  class << self
    ##
    # Truthy values in `to_env_bool` terms.
    #
    # @return [Array<String>]
    #
    TO_ENV_BOOL_TRUE_VALUES = ["t", "T", "true", "True", "TRUE", "on", "On", "ON", "y", "Y", "yes", "Yes", "YES"].freeze

    ##
    # Falsy values in `ActiveModel::Type::Boolean` terms.
    #
    # @return [Array<String>]
    #
    # @see https://github.com/rails/rails/blob/v8.0.2/activemodel/lib/active_model/type/boolean.rb#L15
    #
    TO_ACTIVE_MODEL_BOOLEAN_TYPE_FALSE_VALUES = [false, 0, "0", :"0", "f", :f, "F", :F, "false", :false, "FALSE", :FALSE, "off", :off, "OFF", :OFF].to_set.freeze

    ##
    # @return [Regexp]
    # @see https://github.com/rails/rails/blob/v8.0.2/activesupport/lib/active_support/core_ext/object/blank.rb#L136
    #
    ACTIVE_SUPPORT_CORE_EXT_BLANK_RE = /\A[[:space:]]*\z/

    ##
    # @return [Hash]
    # @see https://github.com/rails/rails/blob/v8.0.2/activesupport/lib/active_support/core_ext/object/blank.rb#L137
    #
    ACTIVE_SUPPORT_CORE_EXT_ENCODED_BLANKS = ::Hash.new do |h, enc|
      h[enc] = ::Regexp.new(ACTIVE_SUPPORT_CORE_EXT_BLANK_RE.source.encode(enc), ACTIVE_SUPPORT_CORE_EXT_BLANK_RE.options | ::Regexp::FIXEDENCODING)
    end

    ##
    # Returns `false` when `object` is `false` or `nil`. Returns `true` for all the other cases. Just like Ruby does in the control expressions.
    #
    # @param object [Object] Can be any type.
    # @return [Boolean]
    #
    # @see https://docs.ruby-lang.org/en/3.4/syntax/control_expressions_rdoc.html
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
    # - Converts `object` to a string by the `#to_s` method and checks whether it is one of `["t", "T", "true", "True", "TRUE", "on", "On", "ON", "y", "Y", "yes", "Yes", "YES"]`.
    # - If yes, returns `true`, otherwise it converts `object` to an integer by `Kernel.Integer` and checks whether it is greater than zero.
    # - If yes, returns `true`, otherwise returns `false`.
    #
    # @param object [Object] Can be any type.
    # @return [Boolean]
    #
    if ::Gem::Version.create(::RUBY_VERSION) >= ::Gem::Version.create("2.6")
      def to_env_bool(object)
        string = object.to_s

        return false if string.empty?

        return true if TO_ENV_BOOL_TRUE_VALUES.include?(string)

        integer = ::Kernel.Integer(string, exception: false)

        return false unless integer

        integer > 0
      end
    else
      # rubocop:disable Lint/SuppressedExceptionInNumberConversion
      def to_env_bool(object)
        string = object.to_s

        return false if string.empty?

        return true if TO_ENV_BOOL_TRUE_VALUES.include?(string)

        integer =
          begin
            ::Kernel.Integer(string)
          rescue
            nil
          end

        return false unless integer

        integer > 0
      end
      # rubocop:enable Lint/SuppressedExceptionInNumberConversion
    end

    ##
    # Converts `object` to boolean using exactly the same logic as `object.blank?` does (but with `Hash` instead of `Concurent::Map` for string encodings storage).
    #
    # @param object [Object] Can be any type.
    # @return [Boolean]
    #
    def blank?(object)
      case object
      when NilClass
        true
      when FalseClass
        true
      when TrueClass
        false
      when Array
        object.empty?
      when Hash
        object.empty?
      when Symbol
        object.empty?
      when String
        object.empty? ||
          begin
            ACTIVE_SUPPORT_CORE_EXT_BLANK_RE.match?(object)
          rescue ::Encoding::CompatibilityError
            ACTIVE_SUPPORT_CORE_EXT_ENCODED_BLANKS[object.encoding].match?(object)
          end
      when Numeric
        false
      when Time
        false
      when Object
        respond_to?(:empty?) ? !!empty? : false
      else
        object.public_send(:blank?)
      end
    end

    ##
    # Converts `object` to boolean using exactly the same logic as `object.present?` does (but with `Hash` instead of `Concurent::Map` for string encodings storage).
    #
    # @param object [Object] Can be any type.
    # @return [Boolean]
    #
    def present?(object)
      !blank?(object)
    end

    ##
    # Converts `object` to boolean (or `nil`) using exactly the same logic as `ActiveModel::Type::Boolean.new.cast(object)` does.
    #
    # @param object [Object] Can be any type.
    # @return [Boolean, nil]
    #
    # @see https://github.com/rails/rails/blob/v8.0.2/activemodel/lib/active_model/type/boolean.rb#L39
    #
    def to_active_model_boolean_type(object)
      (object == "") ? nil : !TO_ACTIVE_MODEL_BOOLEAN_TYPE_FALSE_VALUES.include?(object)
    end

    ##
    # Converts `object` to `1` or `0`.
    # Uses `to_ruby_bool` method under the hood.
    # Accepts optional `by` keyword to rely on a different method.
    #
    # @param object [Object] Can be any type.
    # @param by [Symbol, String].
    # @return [Integer]
    #
    def to_one_or_zero(object, by: :to_ruby_bool)
      public_send(by, object) ? 1 : 0
    end

    ##
    # Converts `object` to `"y"` or `"n"`.
    # Uses `to_ruby_bool` method under the hood.
    # Accepts optional `by` keyword to rely on a different method.
    #
    # @param object [Object] Can be any type.
    # @param by [Symbol, String].
    # @return [String]
    #
    def to_y_or_n(object, by: :to_ruby_bool)
      public_send(by, object) ? "y" : "n"
    end

    ##
    # Converts `object` to `"yes"` or `"no"`.
    # Uses `to_ruby_bool` method under the hood.
    # Accepts optional `by` keyword to rely on a different method.
    #
    # @param object [Object] Can be any type.
    # @param by [Symbol, String].
    # @return [String]
    #
    def to_yes_or_no(object, by: :to_ruby_bool)
      public_send(by, object) ? "yes" : "no"
    end

    ##
    # Converts `object` to `"on"` or `"off"`.
    # Uses `to_ruby_bool` method under the hood.
    # Accepts optional `by` keyword to rely on a different method.
    #
    # @param object [Object] Can be any type.
    # @param by [Symbol, String].
    # @return [String]
    #
    def to_on_or_off(object, by: :to_ruby_bool)
      public_send(by, object) ? "on" : "off"
    end
  end
end
# rubocop:enable Lint/BooleanSymbol
