# frozen_string_literal: true

require "bigdecimal"

# rubocop:disable Lint/BooleanSymbol
RSpec.describe SemanticBoolean do
  example_group "to_bool methods" do
    def bulk_to_bool(object)
      {
        ruby_bool: SemanticBoolean.to_ruby_bool(object),
        env_bool: SemanticBoolean.to_env_bool(object),
        active_model_boolean_type: SemanticBoolean.to_active_model_boolean_type(object)
      }
    end

    specify { expect(bulk_to_bool(true)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(false)).to eq({ruby_bool: false, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool(nil)).to eq({ruby_bool: false, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: nil}) }

    specify { expect(bulk_to_bool("t")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("f")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool(:t)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:f)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool("T")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("F")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool(:T)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:F)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool("true")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("false")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool(:true)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:false)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool("True")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("False")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(:True)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:False)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool("tRuE")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("fAlSe")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(:tRuE)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:fAlSe)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool("TRUE")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("FALSE")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool(:TRUE)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:FALSE)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool("on")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("off")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool(:on)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:off)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool("On")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("Off")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(:On)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:Off)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool("oN")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("oFf")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(:oN)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:oFf)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool("ON")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("OFF")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool(:ON)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:OFF)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool("y")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("n")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(:y)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:n)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool("yes")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("no")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(:yes)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:no)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool("Yes")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("No")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(:Yes)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:No)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool("yEs")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("nO")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(:yEs)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:nO)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool("YES")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("NO")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(:YES)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:NO)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool("1")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool(:"1")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:"0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool(1)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(0)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: false}) }

    specify { expect(bulk_to_bool("2")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("-1")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(:"2")).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:"-1")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(2)).to eq({ruby_bool: true, env_bool: true, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(-1)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool("1.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("0.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(:"1.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:"0.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(1.0)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(0.0)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool("2.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool("-1.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(:"2.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(:"-1.0")).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(2.0)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(-1.0)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(BigDecimal("1.0"))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(BigDecimal("0.0"))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(BigDecimal("2.0"))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(BigDecimal("-1.0"))).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(1r)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(0r)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool(2r)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(-1r)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }

    specify { expect(bulk_to_bool([])).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool({})).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(Object.new)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
    specify { expect(bulk_to_bool(Class.new)).to eq({ruby_bool: true, env_bool: false, active_model_boolean_type: true}) }
  end

  describe "#to_one_or_zero" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_one_or_zero(false)).to eq(0) }
      specify { expect(SemanticBoolean.to_one_or_zero(false, as: :ruby_bool)).to eq(0) }
      specify { expect(SemanticBoolean.to_one_or_zero(false, as: :env_bool)).to eq(0) }
      specify { expect(SemanticBoolean.to_one_or_zero(false, as: :active_model_boolean_type)).to eq(0) }
      specify { expect { SemanticBoolean.to_one_or_zero(false, as: :not_supported) }.to raise_error(NoMethodError) }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_one_or_zero(true)).to eq(1) }
      specify { expect(SemanticBoolean.to_one_or_zero(true, as: :ruby_bool)).to eq(1) }
      specify { expect(SemanticBoolean.to_one_or_zero(true, as: :env_bool)).to eq(1) }
      specify { expect(SemanticBoolean.to_one_or_zero(true, as: :active_model_boolean_type)).to eq(1) }
      specify { expect { SemanticBoolean.to_one_or_zero(true, as: :not_supported) }.to raise_error(NoMethodError) }
    end
  end

  describe "#to_y_or_n" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_y_or_n(false)).to eq("n") }
      specify { expect(SemanticBoolean.to_y_or_n(false, as: :ruby_bool)).to eq("n") }
      specify { expect(SemanticBoolean.to_y_or_n(false, as: :env_bool)).to eq("n") }
      specify { expect(SemanticBoolean.to_y_or_n(false, as: :active_model_boolean_type)).to eq("n") }
      specify { expect { SemanticBoolean.to_y_or_n(false, as: :not_supported) }.to raise_error(NoMethodError) }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_y_or_n(true)).to eq("y") }
      specify { expect(SemanticBoolean.to_y_or_n(true, as: :ruby_bool)).to eq("y") }
      specify { expect(SemanticBoolean.to_y_or_n(true, as: :env_bool)).to eq("y") }
      specify { expect(SemanticBoolean.to_y_or_n(true, as: :active_model_boolean_type)).to eq("y") }
      specify { expect { SemanticBoolean.to_y_or_n(true, as: :not_supported) }.to raise_error(NoMethodError) }
    end
  end

  describe "#to_yes_or_no" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_yes_or_no(false)).to eq("no") }
      specify { expect(SemanticBoolean.to_yes_or_no(false, as: :ruby_bool)).to eq("no") }
      specify { expect(SemanticBoolean.to_yes_or_no(false, as: :env_bool)).to eq("no") }
      specify { expect(SemanticBoolean.to_yes_or_no(false, as: :active_model_boolean_type)).to eq("no") }
      specify { expect { SemanticBoolean.to_yes_or_no(false, as: :not_supported) }.to raise_error(NoMethodError) }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_yes_or_no(true)).to eq("yes") }
      specify { expect(SemanticBoolean.to_yes_or_no(true, as: :ruby_bool)).to eq("yes") }
      specify { expect(SemanticBoolean.to_yes_or_no(true, as: :env_bool)).to eq("yes") }
      specify { expect(SemanticBoolean.to_yes_or_no(true, as: :active_model_boolean_type)).to eq("yes") }
      specify { expect { SemanticBoolean.to_yes_or_no(true, as: :not_supported) }.to raise_error(NoMethodError) }
    end
  end

  describe "#to_on_or_off" do
    context "when `object` is falsy" do
      specify { expect(SemanticBoolean.to_on_or_off(false)).to eq("off") }
      specify { expect(SemanticBoolean.to_on_or_off(false, as: :ruby_bool)).to eq("off") }
      specify { expect(SemanticBoolean.to_on_or_off(false, as: :env_bool)).to eq("off") }
      specify { expect(SemanticBoolean.to_on_or_off(false, as: :active_model_boolean_type)).to eq("off") }
      specify { expect { SemanticBoolean.to_on_or_off(false, as: :not_supported) }.to raise_error(NoMethodError) }
    end

    context "when `object` is truthy" do
      specify { expect(SemanticBoolean.to_on_or_off(true)).to eq("on") }
      specify { expect(SemanticBoolean.to_on_or_off(true, as: :ruby_bool)).to eq("on") }
      specify { expect(SemanticBoolean.to_on_or_off(true, as: :env_bool)).to eq("on") }
      specify { expect(SemanticBoolean.to_on_or_off(true, as: :active_model_boolean_type)).to eq("on") }
      specify { expect { SemanticBoolean.to_on_or_off(true, as: :not_supported) }.to raise_error(NoMethodError) }
    end
  end
end
# rubocop:enable Lint/BooleanSymbol
