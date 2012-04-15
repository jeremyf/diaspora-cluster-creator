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

end
