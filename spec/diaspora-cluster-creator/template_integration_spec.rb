require_relative '../spec_helper_lite'
require 'template'

describe Template do
  describe '#to_dot' do
    it 'should remder star systems and their connections' do
      @names = ["Hello", "World", "Foo", "Bar"]
      @cluster = Cluster.new(@names)
      @graph = Graph.new(@cluster)
      @template = Template.new(@graph)
      @template.to_dot.tap do |dot|
        @names.each do |name|
          dot.must_match(/"?#{name}"? \[label = "#{name}"\]/)
        end
        @graph.edges.each do |edge|
          dot.must_match(/"?#{edge.first}"? -- "?#{edge.last}"?/)
        end
      end
    end
  end
end
