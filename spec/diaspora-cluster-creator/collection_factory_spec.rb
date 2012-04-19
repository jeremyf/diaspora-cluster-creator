require_relative '../spec_helper_lite'
require 'collection_factory'

describe CollectionFactory do
  subject { CollectionFactory.new(context)}
  let(:context) { Object.new }
  
  describe '#build_from' do
    it 'should raise exception' do
      lambda { subject.build_from([])}.must_raise RuntimeError
    end
  end
end