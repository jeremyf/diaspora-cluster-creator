require_relative '../spec_helper_lite'
require 'template'

describe Template do
  subject { Template.new(cluster) }
  let(:cluster) { Cluster.new(names) }
  let(:names) {  ["Hello", "World", "Foo", "Bar"] }
  describe '#to_s' do
    it 'should remder node systems and their connections' do
      subject.to_s.tap do |dot|
        cluster.nodes.each do |node|
          dot.must_include(%([label = #{node.label.inspect}]))
        end
        cluster.edges.each do |edge|
          dot.must_match(/"?#{edge.first}"? -- "?#{edge.last}"?/)
        end
      end
    end
  end
end
