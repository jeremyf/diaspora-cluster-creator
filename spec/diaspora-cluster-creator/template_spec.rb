require_relative '../spec_helper_lite'
require 'template'

describe Template do
  subject { Template.new(graph) }
  let(:graph) {
    object = Object.new
    def object.edges; [['a','b'],['a','c']]; end
    def object.nodes; ['a','b','c']; end
    def object.to_s; "Custom Name"; end
    object
  }

  describe '#to_dot' do
    it 'should render pretty' do
      subject.to_dot.must_equal(
      [
        %(graph #{graph.to_s.inspect} {),
        %(  a [label = "a"];),
        %(  b [label = "b"];),
        %(  c [label = "c"];),
        %(  a -- b),
        %(  a -- c),
        %(})
      ].join("\n")
      )
    end
  end
end
