require_relative '../spec_helper_lite'
require 'fate_dice'

describe FateDice do
  subject { FateDice.new }

  describe '#roll' do
    it 'should be the sum of 4 Fudge dice' do
      loaded_dice = MiniTest::Mock.new
      loaded_dice.expect(:call, 1)
      subject.randomizer = loaded_dice
      subject.roll.must_equal 4
      loaded_dice.verify
    end
  end
end
