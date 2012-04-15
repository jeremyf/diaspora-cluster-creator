require_relative '../spec_helper_lite'
require 'cluster'

describe Cluster do
  subject { Cluster.new(settings, names) }
  let(:settings) { Object.new }
  let(:names) { ['a'] }

  describe '#each' do
    it 'should yield a built node' do
      built_object = Object.new
      transformed_object = Object.new
      guarantor = MiniTest::Mock.new
      builder = MiniTest::Mock.new
      builder.expect(:call, built_object, [subject,'a'])
      guarantor.expect(:call, [transformed_object], [[built_object]])
      
      subject.node_builder = builder
      subject.node_guarantor = guarantor
      @yielded = []
      subject.each {|object| @yielded << object  }
      builder.verify
      guarantor.verify
      @yielded.must_equal [transformed_object]
    end
  end
  
  describe '#edges' do
    it 'should delegate edge drawing to the edge_drawer' do
      expected_output = ['output']
      drawer = MiniTest::Mock.new
      drawer.expect(:call, expected_output)
      subject.edge_drawer = drawer
      subject.edges.must_equal(expected_output)
      drawer.verify
    end
  end
end
