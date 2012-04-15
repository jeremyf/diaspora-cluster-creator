require_relative '../spec_helper_lite'
require 'node_collection_factory'

describe NodeCollectionFactory do
  subject { NodeCollectionFactory.new(context) }
  let(:context) { Object.new }
  
  describe '#build_from(names)' do
    it 'should build the nodes then verify them' do
      list_of_names = ['a']
      expected_output = ['node-a']

      node_builder = MiniTest::Mock.new
      node_builder.expect(:call, 'node-a', [context,'a'])

      guarantor = MiniTest::Mock.new
      guarantor.expect(:call, 'guaranteed!', [expected_output])
      
      subject.node_guarantor = guarantor
      subject.node_builder = node_builder

      subject.build_from(list_of_names).must_equal(expected_output)
      node_builder.verify
      guarantor.verify
    end
  end
end
