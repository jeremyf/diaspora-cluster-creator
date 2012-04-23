module Diaspora
  module Cluster
    module Creator
      class Attribute
        attr_reader :name, :prefix
        def initialize(name)
          if /\((?<extracted_prefix>\w)\)/ =~ name
            @prefix = extracted_prefix.upcase
          else
            @prefix = name.slice(0).upcase
          end
          @name = name.gsub(/[\(\)]/,'')
        end

        def to_s
          name
        end

        def to_sym
          name.to_s.gsub(/\W+/,'_').downcase.to_sym
        end

        def label
          prefix
        end
      end
    end
  end
end