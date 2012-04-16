require_relative '../spec_helper_lite'
require 'node'
require 'ostruct'

describe Node do
  class MockAttribute
    attr_accessor :value, :to_sym, :prefix
    def to_i; value; end
    def value
      @value.to_i
    end
  end
    
  let(:attribute_builder) { lambda {|node,attribute| attribute } }
  let(:name) { 'Name' }
  subject {
    Node.new( cluster, name) do |node|
      node.attribute_builder = attribute_builder
    end
  }
  let(:cluster) {
    Object.new.tap do |obj|
      def obj.attributes
        [
          MockAttribute.new.tap{|obj| obj.to_sym = :technology; obj.prefix = 'T'; obj.value = 1},
          MockAttribute.new.tap{|obj| obj.to_sym = :resources; obj.prefix = 'R'; obj.value = 1},
          MockAttribute.new.tap{|obj| obj.to_sym = :environment; obj.prefix = 'E'; obj.value = 1},
        ]
      end
    end
  }
  describe 'with attributes' do
    let(:cluster) {
      Object.new.tap do |obj|
        def obj.attributes
          [
            MockAttribute.new.tap{|obj| obj.to_sym = :knights; obj.prefix = 'K'; obj.value = 1},
            MockAttribute.new.tap{|obj| obj.to_sym = :dragons; obj.prefix = 'D'; obj.value = 2},
            MockAttribute.new.tap{|obj| obj.to_sym = :maidens; obj.prefix = 'M'; obj.value = 3},
          ]
        end
      end
    }
    it 'should have #knights method' do
      subject.knights.must_equal 1
    end
  
    it 'should allow #knights to be set' do
      subject.knights = 3
      subject.knights.must_equal(3)
    end
  end

  describe '#initialize with some attributes' do
    let(:name) { "Sparta{T1 E-4}" }
    it 'should have an extracted name' do
      subject.name.must_equal 'Sparta'
    end
    it 'should have an preset attribute' do
      subject.resources.must_equal 1
      subject.technology.must_equal 1
      subject.environment.must_equal -4
    end
  end
end
