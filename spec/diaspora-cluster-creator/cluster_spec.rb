require_relative '../spec_helper_lite'
require 'cluster'

describe Cluster do
  subject { Cluster.new(names, attribute_names) }
  let(:attribute_names) { ['tech'] }
  let(:names) { ['a'] }

  describe '#nodes' do
    it 'should delegate node creation to node_maker' do
      expected_output = ['output']
      maker = MiniTest::Mock.new
      maker.expect(:call, expected_output)
      subject.node_collection_builder = maker
      subject.nodes.must_equal(expected_output)
      maker.verify
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

  describe '#attributes' do
    it 'should delegate attribute creation to the attribute_collection_builder' do
      expected_output = ['output']
      builder = MiniTest::Mock.new
      builder.expect(:call, expected_output)
      subject.attribute_collection_builder = builder
      subject.attributes.must_equal(expected_output)
      builder.verify
    end
  end
end
