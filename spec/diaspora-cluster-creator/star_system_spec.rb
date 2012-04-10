require_relative '../spec_helper_lite'
require 'star_system'

describe StarSystem do
  subject { StarSystem.new( Object.new ) }
  
  describe '#technology' do
    it 'should be randomly rolled' do
      loaded_dice = MiniTest::Mock.new
      loaded_dice.expect(:roll, 1)
      subject.dice = loaded_dice
      subject.technology.must_equal 1
      loaded_dice.verify
    end
  end

  describe '#resource' do
    it 'should be randomly rolled' do
      loaded_dice = MiniTest::Mock.new
      loaded_dice.expect(:roll, 1)
      subject.dice = loaded_dice
      subject.resource.must_equal 1
      loaded_dice.verify
    end
  end

  describe '#environment' do
    it 'should be randomly rolled' do
      loaded_dice = MiniTest::Mock.new
      loaded_dice.expect(:roll, 1)
      subject.dice = loaded_dice
      subject.environment.must_equal 1
      loaded_dice.verify
    end
  end
end
