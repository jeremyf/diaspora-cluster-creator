require_relative '../spec_helper_lite'
require 'settings'

describe Settings do
  subject { Settings.new(options) }
  let(:options) { {} }
  
  describe 'default #attributes' do
    it 'should include :technology' do
      subject.attributes.must_include :technology
    end

    it 'should include :resources' do
      subject.attributes.must_include :resources
    end

    it 'should include :environment' do
      subject.attributes.must_include :environment
    end
  end

  describe 'allow #attributes to be overridden' do
    let(:new_attributes) { [:religion, :magic, :science]}
    let(:options) { {:attributes => new_attributes } }

    it 'should include overridden attributes' do
      new_attributes.each do |attribute_name|
        subject.attributes.must_include attribute_name
      end
    end

    it 'should not include defaults attributes' do
      subject.class::DEFAULT_ATTRIBUTES.each do |attribute_name|
        subject.attributes.wont_include attribute_name
      end
    end
  end
end
