class AttributeInterface
  attr_accessor :name
  attr_writer :value, :prefix, :to_sym, :to_s, :to_i
  
  def to_sym
    @to_sym || name.gsub(/\W+/,'_').downcase.to_sym
  end
  def prefix
    @prefix || name.slice(0)
  end
  
  def to_s
    @to_s || name.to_s
  end
  
  def to_i
    @to_i || @value.to_i
  end
  
  def value
    (@value || 0).to_i
  end
end
FactoryGirl.define do
  sequence(:name) do |n|
    "name_#{n}"
  end
  factory(:attribute, :class => AttributeInterface) do
    name { FactoryGirl.generate(:name) }
  end
end