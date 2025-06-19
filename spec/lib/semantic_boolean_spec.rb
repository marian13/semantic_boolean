# frozen_string_literal: true

require "bigdecimal"
require "set"

# rubocop:disable Lint/BooleanSymbol
RSpec.describe SemanticBoolean do
  example_group "to_bool methods" do
    def normalize_message(message)
      message.gsub("`", "'")
    end

    def bulk_to_bool(object)
      ruby_bool =
        begin
          SemanticBoolean.to_ruby_bool(object)
        rescue => exception
          [exception.class, normalize_message(exception.message)]
        end

      env_bool =
        begin
          SemanticBoolean.to_env_bool(object)
        rescue => exception
          [exception.class, normalize_message(exception.message)]
        end

      active_model_boolean_type =
        begin
          SemanticBoolean.to_active_model_boolean_type(object)
        rescue => exception
          [exception.class, normalize_message(exception.message)]
        end

      blank =
        begin
          SemanticBoolean.blank?(object)
        rescue => exception
          [exception.class, normalize_message(exception.message)]
        end

      present =
        begin
          SemanticBoolean.present?(object)
        rescue => exception
          [exception.class, normalize_message(exception.message)]
        end

      {
        ruby_bool: ruby_bool,
        env_bool: env_bool,
        active_model_boolean_type: active_model_boolean_type,
        blank: blank,
        present: present
      }
    end

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
    specify { expect(bulk_to_bool(BasicObject.new)).to eq({ruby_bool: true, env_bool: [TypeError, "can't convert BasicObject into String"], active_model_boolean_type: [NoMethodError, "undefined method 'hash' for an instance of BasicObject"], blank: [NoMethodError, "undefined method 'blank?' for an instance of BasicObject"], present: [NoMethodError, "undefined method 'blank?' for an instance of BasicObject"]}) }

    specify { expect(bulk_to_bool(Class)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(Module)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(Object)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
    specify { expect(bulk_to_bool(BasicObject)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true, blank: false, present: true}) }
  end

  describe "#to_one_or_zero" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_one_or_zero(false)).to eq(0) }
      specify { expect(SemanticBoolean.to_one_or_zero(false, by: :to_ruby_bool)).to eq(0) }
      specify { expect(SemanticBoolean.to_one_or_zero(false, by: :to_env_bool)).to eq(0) }
      specify { expect(SemanticBoolean.to_one_or_zero(false, by: :to_active_model_boolean_type)).to eq(0) }
      specify { expect { SemanticBoolean.to_one_or_zero(false, by: :not_supported) }.to raise_error(NoMethodError) }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_one_or_zero(true)).to eq(1) }
      specify { expect(SemanticBoolean.to_one_or_zero(true, by: :to_ruby_bool)).to eq(1) }
      specify { expect(SemanticBoolean.to_one_or_zero(true, by: :to_env_bool)).to eq(1) }
      specify { expect(SemanticBoolean.to_one_or_zero(true, by: :to_active_model_boolean_type)).to eq(1) }
      specify { expect { SemanticBoolean.to_one_or_zero(true, by: :not_supported) }.to raise_error(NoMethodError) }
    end
  end

  describe "#to_y_or_n" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_y_or_n(false)).to eq("n") }
      specify { expect(SemanticBoolean.to_y_or_n(false, by: :to_ruby_bool)).to eq("n") }
      specify { expect(SemanticBoolean.to_y_or_n(false, by: :to_env_bool)).to eq("n") }
      specify { expect(SemanticBoolean.to_y_or_n(false, by: :to_active_model_boolean_type)).to eq("n") }
      specify { expect { SemanticBoolean.to_y_or_n(false, by: :not_supported) }.to raise_error(NoMethodError) }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_y_or_n(true)).to eq("y") }
      specify { expect(SemanticBoolean.to_y_or_n(true, by: :to_ruby_bool)).to eq("y") }
      specify { expect(SemanticBoolean.to_y_or_n(true, by: :to_env_bool)).to eq("y") }
      specify { expect(SemanticBoolean.to_y_or_n(true, by: :to_active_model_boolean_type)).to eq("y") }
      specify { expect { SemanticBoolean.to_y_or_n(true, by: :not_supported) }.to raise_error(NoMethodError) }
    end
  end

  describe "#to_yes_or_no" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_yes_or_no(false)).to eq("no") }
      specify { expect(SemanticBoolean.to_yes_or_no(false, by: :to_ruby_bool)).to eq("no") }
      specify { expect(SemanticBoolean.to_yes_or_no(false, by: :to_env_bool)).to eq("no") }
      specify { expect(SemanticBoolean.to_yes_or_no(false, by: :to_active_model_boolean_type)).to eq("no") }
      specify { expect { SemanticBoolean.to_yes_or_no(false, by: :not_supported) }.to raise_error(NoMethodError) }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_yes_or_no(true)).to eq("yes") }
      specify { expect(SemanticBoolean.to_yes_or_no(true, by: :to_ruby_bool)).to eq("yes") }
      specify { expect(SemanticBoolean.to_yes_or_no(true, by: :to_env_bool)).to eq("yes") }
      specify { expect(SemanticBoolean.to_yes_or_no(true, by: :to_active_model_boolean_type)).to eq("yes") }
      specify { expect { SemanticBoolean.to_yes_or_no(true, by: :not_supported) }.to raise_error(NoMethodError) }
    end
  end

  describe "#to_on_or_off" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_on_or_off(false)).to eq("off") }
      specify { expect(SemanticBoolean.to_on_or_off(false, by: :to_ruby_bool)).to eq("off") }
      specify { expect(SemanticBoolean.to_on_or_off(false, by: :to_env_bool)).to eq("off") }
      specify { expect(SemanticBoolean.to_on_or_off(false, by: :to_active_model_boolean_type)).to eq("off") }
      specify { expect { SemanticBoolean.to_on_or_off(false, by: :not_supported) }.to raise_error(NoMethodError) }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_on_or_off(true)).to eq("on") }
      specify { expect(SemanticBoolean.to_on_or_off(true, by: :to_ruby_bool)).to eq("on") }
      specify { expect(SemanticBoolean.to_on_or_off(true, by: :to_env_bool)).to eq("on") }
      specify { expect(SemanticBoolean.to_on_or_off(true, by: :to_active_model_boolean_type)).to eq("on") }
      specify { expect { SemanticBoolean.to_on_or_off(true, by: :not_supported) }.to raise_error(NoMethodError) }
    end
  end
end
# rubocop:enable Lint/BooleanSymbol
