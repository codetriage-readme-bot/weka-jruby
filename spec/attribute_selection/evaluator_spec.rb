require 'spec_helper'

describe Weka::AttributeSelection::Evaluator do
  subject { described_class }

  it_behaves_like 'class builder'

  {
    CfsSubset:                  :CfsSubsetEval,
    CorrelationAttribute:       :CorrelationAttributeEval,
    GainRatioAttribute:         :GainRatioAttributeEval,
    InfoGainAttribute:          :InfoGainAttributeEval,
    OneRAttribute:              :OneRAttributeEval,
    ReliefFAttribute:           :ReliefFAttributeEval,
    SymmetricalUncertAttribute: :SymmetricalUncertAttributeEval,
    WrapperSubset:              :WrapperSubsetEval
  }.each do |class_name, super_class_name|
    it "defines a class #{class_name}" do
      expect(subject.const_defined?(class_name)).to be true
    end

    it "inherits class #{class_name} from #{super_class_name}" do
      scoped_class = "#{subject}::#{class_name}"
      scoped_super_class = "#{subject}::#{super_class_name}"

      evaluator_class = Object.module_eval(scoped_class, __FILE__, __LINE__)
      super_class = Object.module_eval(scoped_super_class, __FILE__, __LINE__)

      expect(evaluator_class.new).to be_kind_of super_class
    end
  end

  it 'defines a class PrincipalComponents' do
    expect(subject.const_defined?(:PrincipalComponents)).to be true
  end
end
