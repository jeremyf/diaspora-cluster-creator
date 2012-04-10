require 'dependency_injector'

module Diaspora
  module Cluster
    module Creator
      class FateDice
        extend DependencyInjector
        def_injector(:randomizer) { -> { rand(3) - 1 } }

        attr_reader :dice_count
        def initialize(dice_count = 4)
          self.dice_count = dice_count
        end

        def roll
          (1..dice_count).inject(0) {|m,v| m += randomizer.call }
        end

        def dice_count=(value)
          @dice_count = value.to_i
        end
      end
    end
  end
end