require_relative '../spec_helper_lite'
require 'template'
require 'ostruct'

describe Template do
  subject { Template.new(graph) }
  let(:graph) {
    object = Object.new
    def object.attributes
      [
        FactoryGirl.build(:attribute, :name => 'Name')
      ]
    end
    def object.each_node
      yield('a')
      yield('b')
      yield('c')
    end
    def object.each_edge
      yield(['a','b'])
      yield(['a','c'])
    end
    def object.to_s; "Custom Name"; end
    object
  }

  describe '#to_s' do
    it 'should render pretty' do
      subject.to_s.must_equal(
      [
        %(graph #{graph.to_s.inspect} {),
        %(  "Cluster Legend" [label = "N - Name", shape = "box"];),
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
