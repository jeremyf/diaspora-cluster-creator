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

  describe '.guarantee!' do
    it 'should adjust technology rating without altering the sort order' do
      @node_a = Node.new('', 1)
      @node_b = Node.new('', 2)
      @node_c = Node.new('', 3)
      order =
      with_loaded_dice(1, @node_a) do
        with_loaded_dice(0, @node_b) do
          with_loaded_dice(-1, @node_c) do
            input = [@node_b, @node_c, @node_a]
            Node.guarantee!(input).must_equal input
          end
        end
      end

      @node_a.technology.must_equal 2
      @node_b.technology.must_equal 0
      @node_c.technology.must_equal 2
    end

    it 'should not adjust technology rating if one is already adequate' do
      @node_a = Node.new('', 1)
      @node_b = Node.new('', 2)
      @node_c = Node.new('', 3)
      order =
      with_loaded_dice(2, @node_a) do
        with_loaded_dice(0, @node_b) do
          with_loaded_dice(-1, @node_c) do
            input = [@node_b, @node_c, @node_a]
            Node.guarantee!(input).must_equal input
          end
        end
      end

      @node_a.technology.must_equal 2
      @node_b.technology.must_equal 0
      @node_c.technology.must_equal(-1)
    end
  end
end
