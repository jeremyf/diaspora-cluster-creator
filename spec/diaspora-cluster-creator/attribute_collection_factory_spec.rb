require_relative '../spec_helper_lite'
require 'attribute_collection_factory'

describe AttributeCollectionFactory do
  subject { AttributeCollectionFactory.new(cluster)}
  let(:cluster) { Object.new }
  it 'should extract attributes from name' do
    subject.attribute_builder = lambda {|string|
      "attr-#{string}"
    }
    subject.build_from(['Magic','Trees','Cows']).must_equal(["attr-Magic", "attr-Trees", "attr-Cows"])
  end

  it 'should build from default when empty array is sent' do
    attribute_builder = lambda {|string|
      "attr-#{string}"
    }
    subject.attribute_builder = attribute_builder
    expected = AttributeCollectionFactory::DEFAULT_ATTRIBUTE_NAMES.collect {|name| attribute_builder.call(name)}
    subject.build_from([]).must_equal(expected)
  end

  it 'should build from default when nil is sent' do
    attribute_builder = lambda {|string|
      "attr-#{string}"
    }
    subject.attribute_builder = attribute_builder
    expected = AttributeCollectionFactory::DEFAULT_ATTRIBUTE_NAMES.collect {|name| attribute_builder.call(name)}
    subject.build_from(nil).must_equal(expected)
  end
end
