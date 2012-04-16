require_relative '../spec_helper_lite'
require 'node_attribute'

describe NodeAttribute do
  subject { NodeAttribute.new(node, attribute) }
  let(:node) { Object.new }
  let(:attribute) { Object.new }

  describe '#to_s' do
    it 'should incorporate attribute' do
      with_loaded_dice(-4, subject) do
        subject.to_s.must_equal "#{attribute}-4"
      end
    end
  end

  describe '#to_i' do
    it 'should be the value' do
      with_loaded_dice(4, subject) do
        subject.to_i.must_equal 4
      end
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
