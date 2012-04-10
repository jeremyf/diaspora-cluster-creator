module Diaspora
  module Cluster
    module Creator
      class StarSystem
        attr_reader :technology
        attr_reader :resources
        attr_reader :environment
        attr_reader :cluster

        def initialize(cluster)
          @cluster = cluster
          @technology = roller.roll
          @resources = roller.roll
          @environment = roller.roll
        end
        alias_method :resource, :resources
        protected
        def roller
          @roller ||= FateDice.new
        end
      end
    end
  end
end
