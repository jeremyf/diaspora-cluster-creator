require_relative '../spec_helper_lite'
require 'node'
require 'ostruct'

describe Node do
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
          FactoryGirl.build(:attribute, :to_sym => :technology, :value => 1, :prefix => 'T'),
          FactoryGirl.build(:attribute, :to_sym => :resources, :value => 1, :prefix => 'R'),
          FactoryGirl.build(:attribute, :to_sym => :environment, :value => 1, :prefix => 'E'),
        ]
      end
    end
  }
  describe 'with attributes' do
    let(:cluster) {
      Object.new.tap do |obj|
        def obj.attributes
          [
            FactoryGirl.build(:attribute, :to_sym => :knights, :prefix => 'K', :value => 1),
            FactoryGirl.build(:attribute, :to_sym => :dragons, :prefix => 'D', :value => 2),
            FactoryGirl.build(:attribute, :to_sym => :maidens, :prefix => 'M', :value => 3),
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
    
    it 'should have #to_i' do
      subject.to_i.must_equal cluster.attributes.inject(0) {|m,a| m += a.value}
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
