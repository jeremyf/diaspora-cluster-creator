module Diaspora
  module Cluster
    module Creator
      class Guarantor
        attr_reader :attribute_name, :minimum_value
        def initialize(attribute_name = :technology, minimum_value = 2)
          @attribute_name, @minimum_value = attribute_name, minimum_value
        end
        def guarantee!(nodes)
          return nodes if nodes.detect {|ss| ss.send(attribute_name) >= minimum_value }
          working = nodes.sort
          working.first.send("#{attribute_name}=", minimum_value)
          working.last.send("#{attribute_name}=", minimum_value)
          nodes
        end
      end
    end
  end
end
