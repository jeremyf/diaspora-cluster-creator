module Diaspora
  module Cluster
    module Creator
      class Attribute
        attr_reader :name, :prefix
        def initialize(name, prefix = nil)
          @name = name
          @prefix = (prefix || @name).slice(0).upcase
        end
        
        def to_s
          name
        end
        
        def to_sym
          name.to_s.gsub(/\W+/,'_').downcase.to_sym
        end
      end
    end
  end
end