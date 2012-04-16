require_relative '../spec_helper_lite'
require 'guarantor'

describe Node do
  subject { Guarantor.new(attribute_name, minimum_value) }
  let(:attribute_name) { 'shoe_size'}
  let(:minimum_value) { 2 }
  let(:mock_node) {
    Class.new do
      include Comparable
      def initialize(value)
        self.shoe_size = value
      end
      attr_accessor :shoe_size
      def <=>(other)
        shoe_size <=> other.shoe_size
      end
    end
  }
  describe '#guarantee! with defined attribute' do
    it 'should adjust technology rating without altering the sort order' do
      @node_a = mock_node.new(-1)
      @node_b = mock_node.new(0)
      @node_c = mock_node.new(1)
      input = [@node_b, @node_c, @node_a]
      subject.guarantee!(input).must_equal(input) # Don't change the order
      @node_a.shoe_size.must_equal 2 # change the value
      @node_b.shoe_size.must_equal 0
      @node_c.shoe_size.must_equal 2
    end

    it 'should not adjust technology rating if one is already adequate' do
      @node_a = mock_node.new(-2)
      @node_b = mock_node.new(0)
      @node_c = mock_node.new(3)
      input = [@node_b, @node_c, @node_a]
      subject.guarantee!(input).must_equal(input) # Don't change the order
      @node_a.shoe_size.must_equal(-2) # not change the value
      @node_b.shoe_size.must_equal 0
      @node_c.shoe_size.must_equal 3
    end
  end
  describe '#guarantee! without attribute' do
    let(:attribute_name) { 'clearly_we_are_not_doing_this' }
    it 'should fail gracefully if method is not defined' do
      @node_a = mock_node.new(-2)
      @node_b = mock_node.new(0)
      @node_c = mock_node.new(3)
      input = [@node_b, @node_c, @node_a]
      subject.guarantee!(input).must_equal(input) # Don't change the order
    end
  end

end
