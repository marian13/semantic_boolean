# frozen_string_literal: true

##
# @author Marian Kostyk <mariankostyk13895@gmail.com>
# @license MIT <https://opensource.org/license/mit>
##

require "bigdecimal"
require "set"

# rubocop:disable Lint/BooleanSymbol
RSpec.describe SemanticBoolean do
  example_group "constants" do
    describe "::VERSION" do
      it "returns version" do
        expect(described_class::VERSION).to be_instance_of(String)
      end

      it "follows Semantic Versioning" do
        expect(described_class::VERSION).to match(/\d+\.\d+\.\d+/)
      end
    end
  end

  example_group "to_bool methods" do
    def bulk_to_bool(object)
      ruby_bool =
        begin
          SemanticBoolean.to_ruby_bool(object)
        rescue => exception
          [exception.class]
        end

      env_bool =
        begin
          SemanticBoolean.to_env_bool(object)
        rescue => exception
          [exception.class]
        end

      active_model_boolean_type =
        begin
          SemanticBoolean.to_active_model_boolean_type(object)
        rescue => exception
          [exception.class]
        end

      blank =
        begin
          SemanticBoolean.blank?(object)
        rescue => exception
          [exception.class]
        end

      present =
        begin
          SemanticBoolean.present?(object)
        rescue => exception
          [exception.class]
        end

      {
        ruby_bool: ruby_bool,
        env_bool: env_bool,
        active_model_boolean_type: active_model_boolean_type,
        blank: blank,
        present: present
      }
    end

    let(:custom_class_with_blank) do
      Class.new do
        def blank?
          true
        end
      end
    end

    let(:custom_object_with_blank) { custom_class_with_blank.new }

    specify { expect(bulk_to_bool(true)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(false)).to eq({ruby_bool: false, env_bool: false, active_model_boolean_type: false, blank: true, present: false}) }

    specify { expect(bulk_to_bool(nil)).to eq({ruby_bool: false, env_bool: false, active_model_boolean_type: true, blank: true, present: false}) }
    specify { expect(bulk_to_bool("")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: nil, blank: true, present: false}) }

    specify { expect(bulk_to_bool("t")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("f")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:t)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:f)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool("T")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("F")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:T)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:F)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool("true")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("false")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:true)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:false)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool("True")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("False")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:True)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:False)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool("tRuE")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("fAlSe")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:tRuE)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:fAlSe)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool("TRUE")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("FALSE")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:TRUE)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:FALSE)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool("on")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("off")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:on)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:off)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool("On")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("Off")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:On)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:Off)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool("oN")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("oFf")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:oN)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:oFf)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool("ON")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("OFF")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:ON)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:OFF)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool("y")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("n")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:y)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:n)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool("yes")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("no")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:yes)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:no)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool("Yes")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("No")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:Yes)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:No)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool("yEs")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("nO")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:yEs)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:nO)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool("YES")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("NO")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:YES)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:NO)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool("1")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:"1")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:"0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool(1)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(0)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }

    specify { expect(bulk_to_bool("2")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("-1")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:"2")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:"-1")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(2)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(-1)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool("1.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("0.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:"1.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:"0.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(1.0)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(0.0)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool("2.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool("-1.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(:"2.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(:"-1.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(2.0)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(-1.0)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(Kernel.BigDecimal("1.0"))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    if RUBY_ENGINE.match?("jruby")
      specify { expect(bulk_to_bool(Kernel.BigDecimal("0.0"))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false, blank: false, present: true}) }
    else
      specify { expect(bulk_to_bool(Kernel.BigDecimal("0.0"))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    end

    specify { expect(bulk_to_bool(Kernel.BigDecimal("2.0"))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(Kernel.BigDecimal("-1.0"))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(1r)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(0r)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(2r)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(-1r)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool([])).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: true, present: false}) }
    specify { expect(bulk_to_bool([:foo])).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool({})).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: true, present: false}) }
    specify { expect(bulk_to_bool({foo: :bar})).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(Set[])).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: true, present: false}) }
    specify { expect(bulk_to_bool(Set[:foo])).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(Class.new)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(Module.new)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(Object.new)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    if RUBY_ENGINE.match?("jruby")
      specify { expect(bulk_to_bool(BasicObject.new)).to eq({ruby_bool: true, env_bool: [NoMethodError], active_model_boolean_type: true, blank: [NoMethodError], present: [NoMethodError]}) }
    else
      specify { expect(bulk_to_bool(BasicObject.new)).to eq({ruby_bool: true, env_bool: [NoMethodError], active_model_boolean_type: [NoMethodError], blank: [NoMethodError], present: [NoMethodError]}) }
    end

    specify { expect(bulk_to_bool(Class)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(Module)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(Object)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(BasicObject)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    ##
    # NOTE: Used from Rails.
    # - https://github.com/rails/rails/blob/v8.0.2/activesupport/test/core_ext/object/blank_test.rb#L27
    #
    Encoding.list.reject(&:dummy?).each do |encoding|
      specify { expect(bulk_to_bool(" ".encode(encoding))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: true, present: false}) }
      specify { expect(bulk_to_bool("a".encode(encoding))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    end

    specify { expect(bulk_to_bool("   ")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: true, present: false}) }
    specify { expect(bulk_to_bool("  \n\t  \r ")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: true, present: false}) }
    specify { expect(bulk_to_bool("　")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: true, present: false}) }
    specify { expect(bulk_to_bool("\u00a0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: true, present: false}) }

    specify { expect(bulk_to_bool(Time.now)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(Date.new(2025))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(DateTime.new(2025))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }

    specify { expect(bulk_to_bool(custom_object_with_blank)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: true, present: false}) }
  end

  describe "#boolean?" do
    specify { expect(SemanticBoolean.boolean?(true)).to eq(true) }
    specify { expect(SemanticBoolean.boolean?(false)).to eq(true) }
    specify { expect(SemanticBoolean.boolean?(nil)).to eq(false) }
    specify { expect(SemanticBoolean.boolean?(42)).to eq(false) }
  end

  describe "#true?" do
    specify { expect(SemanticBoolean.true?(true)).to eq(true) }
    specify { expect(SemanticBoolean.true?(false)).to eq(false) }
    specify { expect(SemanticBoolean.true?(nil)).to eq(false) }
    specify { expect(SemanticBoolean.true?(42)).to eq(false) }
  end

  describe "#false?" do
    specify { expect(SemanticBoolean.false?(true)).to eq(false) }
    specify { expect(SemanticBoolean.false?(false)).to eq(true) }
    specify { expect(SemanticBoolean.false?(nil)).to eq(false) }
    specify { expect(SemanticBoolean.false?(42)).to eq(false) }
  end

  describe "#to_one_or_zero" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_one_or_zero(false)).to eq(0) }
      specify { expect(SemanticBoolean.to_one_or_zero(false, by: :to_ruby_bool)).to eq(0) }
      specify { expect(SemanticBoolean.to_one_or_zero(false, by: :to_env_bool)).to eq(0) }
      specify { expect(SemanticBoolean.to_one_or_zero(false, by: :to_active_model_boolean_type)).to eq(0) }
      specify { expect(SemanticBoolean.to_one_or_zero(false, by: :blank?)).to eq(1) }
      specify { expect(SemanticBoolean.to_one_or_zero(false, by: :present?)).to eq(0) }
      specify { expect { SemanticBoolean.to_one_or_zero(false, by: :not_supported) }.to raise_error(NoMethodError) }
      specify { expect(SemanticBoolean.to_one_or_zero(false, unknown: "default")).to eq(0) }
      specify { expect(SemanticBoolean.to_one_or_zero(nil, unknown: "default")).to eq("default") }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_one_or_zero(true)).to eq(1) }
      specify { expect(SemanticBoolean.to_one_or_zero(true, by: :to_ruby_bool)).to eq(1) }
      specify { expect(SemanticBoolean.to_one_or_zero(true, by: :to_env_bool)).to eq(1) }
      specify { expect(SemanticBoolean.to_one_or_zero(true, by: :to_active_model_boolean_type)).to eq(1) }
      specify { expect(SemanticBoolean.to_one_or_zero(true, by: :blank?)).to eq(0) }
      specify { expect(SemanticBoolean.to_one_or_zero(true, by: :present?)).to eq(1) }
      specify { expect { SemanticBoolean.to_one_or_zero(true, by: :not_supported) }.to raise_error(NoMethodError) }
      specify { expect(SemanticBoolean.to_one_or_zero(true, unknown: "default")).to eq(1) }
    end
  end

  describe "#to_y_or_n" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_y_or_n(false)).to eq("n") }
      specify { expect(SemanticBoolean.to_y_or_n(false, by: :to_ruby_bool)).to eq("n") }
      specify { expect(SemanticBoolean.to_y_or_n(false, by: :to_env_bool)).to eq("n") }
      specify { expect(SemanticBoolean.to_y_or_n(false, by: :to_active_model_boolean_type)).to eq("n") }
      specify { expect(SemanticBoolean.to_y_or_n(false, by: :blank?)).to eq("y") }
      specify { expect(SemanticBoolean.to_y_or_n(false, by: :present?)).to eq("n") }
      specify { expect { SemanticBoolean.to_y_or_n(false, by: :not_supported) }.to raise_error(NoMethodError) }
      specify { expect(SemanticBoolean.to_y_or_n(false, unknown: "default")).to eq("n") }
      specify { expect(SemanticBoolean.to_y_or_n(nil, unknown: "default")).to eq("default") }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_y_or_n(true)).to eq("y") }
      specify { expect(SemanticBoolean.to_y_or_n(true, by: :to_ruby_bool)).to eq("y") }
      specify { expect(SemanticBoolean.to_y_or_n(true, by: :to_env_bool)).to eq("y") }
      specify { expect(SemanticBoolean.to_y_or_n(true, by: :to_active_model_boolean_type)).to eq("y") }
      specify { expect(SemanticBoolean.to_y_or_n(true, by: :blank?)).to eq("n") }
      specify { expect(SemanticBoolean.to_y_or_n(true, by: :present?)).to eq("y") }
      specify { expect { SemanticBoolean.to_y_or_n(true, by: :not_supported) }.to raise_error(NoMethodError) }
      specify { expect(SemanticBoolean.to_y_or_n(true, unknown: "default")).to eq("y") }
    end
  end

  describe "#to_yes_or_no" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_yes_or_no(false)).to eq("no") }
      specify { expect(SemanticBoolean.to_yes_or_no(false, by: :to_ruby_bool)).to eq("no") }
      specify { expect(SemanticBoolean.to_yes_or_no(false, by: :to_env_bool)).to eq("no") }
      specify { expect(SemanticBoolean.to_yes_or_no(false, by: :to_active_model_boolean_type)).to eq("no") }
      specify { expect(SemanticBoolean.to_yes_or_no(false, by: :blank?)).to eq("yes") }
      specify { expect(SemanticBoolean.to_yes_or_no(false, by: :present?)).to eq("no") }
      specify { expect { SemanticBoolean.to_yes_or_no(false, by: :not_supported) }.to raise_error(NoMethodError) }
      specify { expect(SemanticBoolean.to_yes_or_no(false, unknown: "default")).to eq("no") }
      specify { expect(SemanticBoolean.to_yes_or_no(nil, unknown: "default")).to eq("default") }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_yes_or_no(true)).to eq("yes") }
      specify { expect(SemanticBoolean.to_yes_or_no(true, by: :to_ruby_bool)).to eq("yes") }
      specify { expect(SemanticBoolean.to_yes_or_no(true, by: :to_env_bool)).to eq("yes") }
      specify { expect(SemanticBoolean.to_yes_or_no(true, by: :to_active_model_boolean_type)).to eq("yes") }
      specify { expect(SemanticBoolean.to_yes_or_no(true, by: :blank?)).to eq("no") }
      specify { expect(SemanticBoolean.to_yes_or_no(true, by: :present?)).to eq("yes") }
      specify { expect { SemanticBoolean.to_yes_or_no(true, by: :not_supported) }.to raise_error(NoMethodError) }
      specify { expect(SemanticBoolean.to_yes_or_no(true, unknown: "default")).to eq("yes") }
    end
  end

  describe "#to_on_or_off" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_on_or_off(false)).to eq("off") }
      specify { expect(SemanticBoolean.to_on_or_off(false, by: :to_ruby_bool)).to eq("off") }
      specify { expect(SemanticBoolean.to_on_or_off(false, by: :to_env_bool)).to eq("off") }
      specify { expect(SemanticBoolean.to_on_or_off(false, by: :to_active_model_boolean_type)).to eq("off") }
      specify { expect(SemanticBoolean.to_on_or_off(false, by: :blank?)).to eq("on") }
      specify { expect(SemanticBoolean.to_on_or_off(false, by: :present?)).to eq("off") }
      specify { expect { SemanticBoolean.to_on_or_off(false, by: :not_supported) }.to raise_error(NoMethodError) }
      specify { expect(SemanticBoolean.to_on_or_off(false, unknown: "default")).to eq("off") }
      specify { expect(SemanticBoolean.to_on_or_off(nil, unknown: "default")).to eq("default") }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_on_or_off(true)).to eq("on") }
      specify { expect(SemanticBoolean.to_on_or_off(true, by: :to_ruby_bool)).to eq("on") }
      specify { expect(SemanticBoolean.to_on_or_off(true, by: :to_env_bool)).to eq("on") }
      specify { expect(SemanticBoolean.to_on_or_off(true, by: :to_active_model_boolean_type)).to eq("on") }
      specify { expect(SemanticBoolean.to_on_or_off(true, by: :blank?)).to eq("off") }
      specify { expect(SemanticBoolean.to_on_or_off(true, by: :present?)).to eq("on") }
      specify { expect { SemanticBoolean.to_on_or_off(true, by: :not_supported) }.to raise_error(NoMethodError) }
      specify { expect(SemanticBoolean.to_on_or_off(true, unknown: "default")).to eq("on") }
    end
  end

  describe "#to_true_or_false" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_true_or_false(false)).to eq(false) }
      specify { expect(SemanticBoolean.to_true_or_false(false, by: :to_ruby_bool)).to eq(false) }
      specify { expect(SemanticBoolean.to_true_or_false(false, by: :to_env_bool)).to eq(false) }
      specify { expect(SemanticBoolean.to_true_or_false(false, by: :to_active_model_boolean_type)).to eq(false) }
      specify { expect(SemanticBoolean.to_true_or_false(false, by: :blank?)).to eq(true) }
      specify { expect(SemanticBoolean.to_true_or_false(false, by: :present?)).to eq(false) }
      specify { expect { SemanticBoolean.to_true_or_false(false, by: :not_supported) }.to raise_error(NoMethodError) }
      specify { expect(SemanticBoolean.to_true_or_false(false, unknown: "default")).to eq(false) }
      specify { expect(SemanticBoolean.to_true_or_false(nil, unknown: "default")).to eq("default") }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_true_or_false(true)).to eq(true) }
      specify { expect(SemanticBoolean.to_true_or_false(true, by: :to_ruby_bool)).to eq(true) }
      specify { expect(SemanticBoolean.to_true_or_false(true, by: :to_env_bool)).to eq(true) }
      specify { expect(SemanticBoolean.to_true_or_false(true, by: :to_active_model_boolean_type)).to eq(true) }
      specify { expect(SemanticBoolean.to_true_or_false(true, by: :blank?)).to eq(false) }
      specify { expect(SemanticBoolean.to_true_or_false(true, by: :present?)).to eq(true) }
      specify { expect { SemanticBoolean.to_true_or_false(true, by: :not_supported) }.to raise_error(NoMethodError) }
      specify { expect(SemanticBoolean.to_true_or_false(true, unknown: "default")).to eq(true) }
    end
  end
end
# rubocop:enable Lint/BooleanSymbol
