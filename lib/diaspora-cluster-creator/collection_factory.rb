module Diaspora
  module Cluster
    module Creator
      class CollectionFactory
        attr_reader :cluster
        def initialize(cluster)
          @cluster = cluster
        end

        def build_from(names = [])
          raise RuntimeError, "Implement #{self.class}#build_from"
        end
      end
    end
  end
end

