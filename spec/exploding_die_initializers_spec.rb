# frozen_string_literal: true

require 'rspec'

require_relative '../exploding_die'

# specs for the fun extra initializers, separated from core functionality.

# rubocop:disable RSpec/DescribeClass
describe 'Fun ExplodingDie Initializers' do
  describe '.common_die' do
    subject(:die) { ExplodingDie.common_die }

    # random and non-exhaustive. do we care? we do not care.
    it 'creates a single die of a common order' do
      expect(die).to be_a(ExplodingDie)
      expect(ExplodingDie::COMMON_FACES).to include(die.order)
    end
  end

  describe '.coin' do
    subject(:die) { ExplodingDie.coin }

    it 'creates a d2' do
      expect(die).to be_a(ExplodingDie)
      expect(die.order).to eq(2)
    end
  end

  describe '.dnd_set' do
    subject(:dice) { ExplodingDie.dnd_set }

    it 'creates a standard set of Dungeons and Dragons dice' do
      expect(dice).to all(be_a(ExplodingDie))
      expect(dice.map(&:order)).to contain_exactly(
        4, 6, 8, 10, 12, 20, 100
      )
    end
  end

  describe '.yahtzee_set' do
    subject(:dice) { ExplodingDie.yahtzee_set }

    it 'creates a set of yahtzee dice' do
      expect(dice).to all(be_a(ExplodingDie))
      expect(dice.map(&:order)).to all(eq(6))
      expect(dice.size).to eq(5)
    end
  end

  describe '.two_sixes' do
    subject(:dice) { ExplodingDie.two_sixes }

    it 'creates a pair of sixes' do
      expect(dice).to all(be_a(ExplodingDie))
      expect(dice.map(&:order)).to contain_exactly(6, 6)
    end
  end
end
# rubocop:enable RSpec/DescribeClass
