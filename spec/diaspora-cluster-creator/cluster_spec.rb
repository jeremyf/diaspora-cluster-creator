require_relative '../spec_helper_lite'
require 'cluster'

describe Cluster do
  subject { Cluster.new(settings, names) }
  let(:settings) { Object.new }
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
end
