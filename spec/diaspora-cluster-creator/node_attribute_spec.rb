require_relative '../spec_helper_lite'
require 'node_attribute'

describe NodeAttribute do
  subject { NodeAttribute.new(node, attribute) }
  let(:node) { Object.new }
  let(:attribute) { Object.new }

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
