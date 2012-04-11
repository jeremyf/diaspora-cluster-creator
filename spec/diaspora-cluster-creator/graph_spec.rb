require_relative '../spec_helper_lite'
require 'graph'

describe Graph do
  subject { Graph.new(collection) }
  let(:collection) {[1,2,3]}

  describe '#nodes' do
    it 'should be the collection of the input' do
      subject.nodes.must_equal collection
    end
  end

  describe '#edges' do
    it 'connection for all -1 rolls' do
      expected = Set.new
      expected << [1,2]
      expected << [2,3]
      with_loaded_dice(-1, subject) do
        subject.edges.must_equal expected
      end
    end

    it 'connection for all -2 rolls' do
      expected = Set.new
      expected << [1,2]
      expected << [1,3]
      expected << [2,3]
      with_loaded_dice(0, subject) do
        subject.edges.must_equal expected
      end
    end
  end
end
