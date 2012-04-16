require_relative '../spec_helper_lite'
require 'attribute'

describe Attribute do
  describe 'with assumed prefix' do
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
      it 'should default to first character' do
        subject.prefix.must_equal 'H'
      end
    end

    describe '#label' do
      it 'should be the prefix' do
        subject.label.must_equal(subject.prefix)
      end
    end
  end

  describe 'with extracted prefix' do
    subject { Attribute.new('H(a)ir Color')}

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
      it 'should be extracted' do
        subject.prefix.must_equal 'A'
      end
    end
    describe '#label' do
      it 'should be the prefix' do
        subject.label.must_equal(subject.prefix)
      end
    end
  end
end
