require_relative '../spec_helper_lite'
require 'cluster'

describe Cluster do
  subject { Cluster.new(names) }
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
end
