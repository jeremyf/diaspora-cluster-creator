require_relative '../spec_helper_lite'
require 'template'

describe Template do
  describe '#to_dot' do
    it 'should remder node systems and their connections' do
      @names = ["Hello", "World", "Foo", "Bar"]
      @cluster = Cluster.new(Settings.new, @names)
      @template = Template.new(@cluster)
      @template.to_s.tap do |dot|
        @cluster.nodes.each do |system|
          dot.must_include(%([label = #{system.label.inspect}]))
        end
        @cluster.edges.each do |edge|
          dot.must_match(/"?#{edge.first}"? -- "?#{edge.last}"?/)
        end
      end
    end
  end
end
