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
  
  describe 'Conversions' do
    describe 'GraphNode' do
      it 'should append to_node_args' do
        object = Object.new
        self.extend(Conversions)
        GraphNode(object).to_node_args.must_equal([object.to_s, :label => object.to_s])
      end
      it 'should use label as part of args' do
        object = Object.new
        def object.label; 'My Label'; end
        self.extend(Conversions)
        GraphNode(object).to_node_args.must_equal([object.to_s, :label => 'My Label'])
      end
      it 'should not append to_node_args if method already exists' do
        object = Object.new
        def object.to_node_args; 'Hello?'; end
        self.extend(Conversions)
        GraphNode(object).to_node_args.must_equal("Hello?")
      end
    end
    describe 'Legendary' do
      it 'should append to_legend method' do
        object = FactoryGirl.build(:attribute, :to_s => 'Shoe', :prefix => 'S')
        self.extend(Conversions)
        Legendary(object).to_legend.must_equal('S - Shoe')
      end

      it 'should append to_legend method' do
        object1 = FactoryGirl.build(:attribute, :to_s => 'Shoe', :prefix => 'S')
        object2 = FactoryGirl.build(:attribute, :to_s => 'Hair', :prefix => 'H')
        self.extend(Conversions)
        Legendary([object1,object2]).to_legend.must_equal("S - Shoe\nH - Hair")
      end
    end
  end
end
