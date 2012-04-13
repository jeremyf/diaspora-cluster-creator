
module Diaspora
  module Cluster
    module Creator
      class Settings
        DEFAULT_ATTRIBUTES = [:technology, :resources, :environment].freeze
        attr_reader :attributes
        def initialize(options = {})
          @attributes = options[:attributes] || DEFAULT_ATTRIBUTES
          @attributes.freeze
        end
      end
    end
  end
end