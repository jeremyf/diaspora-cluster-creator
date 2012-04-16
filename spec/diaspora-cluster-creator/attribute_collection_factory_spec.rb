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
end
