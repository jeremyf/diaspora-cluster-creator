require_relative '../spec_helper_lite'
require 'template'

describe Template do
  describe '#to_dot' do
    it 'should remder node systems and their connections' do
      @names = ["Hello", "World", "Foo", "Bar"]
      @cluster = Cluster.new(@names)
      @graph = Graph.new(@cluster)
      @template = Template.new(@graph)
      @template.to_s.tap do |dot|
        @cluster.each do |system|
          dot.must_include(%([label = #{system.label.inspect}]))
        end
        @graph.edges.each do |edge|
          dot.must_match(/"?#{edge.first}"? -- "?#{edge.last}"?/)
        end
      end
    end
  end
end
