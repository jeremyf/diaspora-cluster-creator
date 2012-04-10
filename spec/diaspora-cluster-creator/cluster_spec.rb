require_relative '../spec_helper_lite'
require 'cluster'

describe Cluster do
  subject { Cluster.new(size) }
  let(:size) { 1 }

  describe '#each' do
    it 'should yield built star system' do
      built_object = Object.new
      transformed_object = Object.new
      guarantor = MiniTest::Mock.new
      builder = MiniTest::Mock.new
      builder.expect(:call, built_object, [subject])
      guarantor.expect(:call, [transformed_object] * size , [[built_object] * size])
      
      subject.star_system_builder = builder
      subject.star_system_guarantor = guarantor
      @yielded = []
      subject.each {|object| @yielded << object  }
      builder.verify
      guarantor.verify
      @yielded.must_equal [transformed_object] * size
    end
  end
end
