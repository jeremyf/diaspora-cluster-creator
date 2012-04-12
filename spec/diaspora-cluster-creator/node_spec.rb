require_relative '../spec_helper_lite'
require 'node'

describe Node do
  subject { Node.new( Object.new, 1 ) }

  describe '#initialize with one attribute' do
    subject { Node.new(Object.new, "Sparta [T1 E-4]") }
    it 'should have an extracted name' do
      subject.name.must_equal 'Sparta'
    end
    it 'should have an preset attribute' do
      with_loaded_dice(0, subject) do
        subject.resources.must_equal 0
        subject.technology.must_equal 1
        subject.environment.must_equal -4
      end
    end
  end

  describe '#technology=' do
    it 'should be overridable' do
      subject.technology = 3
      subject.technology.must_equal 3
    end
  end

  describe '#technology' do
    it 'should be randomly rolled' do
      with_loaded_dice(1, subject) do
        subject.technology.must_equal 1
      end
    end
  end

  describe '#resources' do
    it 'should be randomly rolled' do
      with_loaded_dice(1, subject) do
        subject.resources.must_equal 1
      end
    end
  end

  describe '#environment' do
    it 'should be randomly rolled' do
      with_loaded_dice(1, subject) do
        subject.environment.must_equal 1
      end
    end
  end

  describe '#<=>' do
    it 'should be comparable to another node node' do
      @node_a = Node.new('', 1)
      @node_b = Node.new('', 2)
      with_loaded_dice(2, @node_a) do
        with_loaded_dice(1, @node_b) do
          @node_b.must_be :<, @node_a
        end
      end
    end
  end
end
