require_relative '../spec_helper_lite'
require 'cluster'

describe Cluster do
  subject { Cluster.new(size) }
  let(:size) { 1 }

  describe '#each' do
    it 'should yield built star system' do
      builder = MiniTest::Mock.new
      builder.expect(:call, 'yielded', [subject])
      subject.star_system_builder = builder
      @yielded = []
      subject.each {|object| @yielded << object  }
      builder.verify
      @yielded.must_equal ['yielded'] * size
    end
  end
end
