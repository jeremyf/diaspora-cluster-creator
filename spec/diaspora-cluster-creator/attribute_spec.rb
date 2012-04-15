require_relative '../spec_helper_lite'
require 'attribute'

describe Attribute do
  subject { Attribute.new('Hair Color')}

  describe '#to_s' do
    it 'should use the name' do
      subject.to_s.must_equal 'Hair Color'
    end
  end

  describe '#to_sym' do
    it 'should convert name to method friendly sym' do
      subject.to_sym.must_equal :hair_color
    end
  end

  describe '#name' do
    it 'should have a name' do
      subject.name.must_equal 'Hair Color'
    end
  end
  describe '#prefix' do
    it 'should allow override' do
      Attribute.new("Hair Color", '1').prefix.must_equal '1'
    end
    
    it 'should default to first character' do
      subject.prefix.must_equal 'H'
    end
  end
end
