require_relative '../spec_helper_lite'
require 'attribute'

describe Attribute do
  subject { Attribute.new(name) }
  let(:name) { 'shoe-size' }

  describe '#name' do
    it 'should be initially assigned' do
      subject.name.must_equal name
    end
  end

  describe '#prefix' do
    it 'should be derived from the name' do
      subject.prefix.must_equal 'S'
    end
  end
  
  describe '#value' do
    it 'should be the result of a roll' do
      with_loaded_dice(4, subject) do
        subject.value.must_equal 4
      end
    end
    it 'should be overridable' do
      subject.value = 2
      subject.value.must_equal 2
    end
  end
end
