require_relative '../spec_helper_lite'
require 'edge_drawer'

describe EdgeDrawer do
  subject { EdgeDrawer.new(context)}
  let(:context) { Object.new }
  
  describe '#draw' do
    it 'should return' do
      nodes = ['a','b','c']
      with_loaded_dice(0,subject) do
        output = subject.draw(nodes)
        
        output.must_include ['a','b']
        output.must_include ['a','c']
        output.must_include ['b','c']
        output.size.must_equal 3
      end
    end
  end
end