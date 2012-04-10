module Diaspora
  module Cluster
    module Creator
      class FateRoll
        attr_reader :dice_count
        def initialize(dice_count = 4)
          self.dice_count = dice_count
        end

        def roll
          (1..dice_count).inject(0) {|m,v| m += (rand(3) - 1) }
        end

        def dice_count=(value)
          @dice_count = value.to_i
        end
      end
    end
  end
end
