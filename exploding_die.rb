# frozen_string_literal: true

# A die that explodes under certain circumstances
class ExplodingDie
  COMMON_FACES = [2, 4, 6, 8, 10, 12, 20, 100].freeze

  attr :order

  def initialize(order: 6)
    raise "That's not gonna make a die!" unless valid_order?(order)

    @order = order
  end

  # some fun initializers for real-world examples
  class << self
    def common_die
      new(order: COMMON_FACES.sample)
    end

    def coin
      new(order: 2)
    end

    def dnd_set
      [4, 6, 8, 10, 12, 20, 100].map { |ord| new(order: ord) }
    end

    def yahtzee_set
      [new(order: 6)] * 5
    end

    def two_sixes
      [new(order: 6)] * 2
    end
  end

  # simulate a roll of the dice
  # recursive version is extremely simple but is subject to
  #   recursion depth limit.
  # here's what it looked like:
  #   result = Random.rand(1..order)
  #   result == order ? result + roll : result
  def roll
    faces = (1..order)

    face = Random.rand(faces)
    total = face

    # codewars shit hehe
    total += face = Random.rand(faces) while explode?(face)

    total
  end

  private

  # the condition under which the die "explodes", meaning roll and add
  def explode?(face)
    face == order
  end

  # returns false if the order would make an infinite loop or be otherwise bad
  def valid_order?(order)
    order.is_a?(Integer) && (order > 1)
  end
end
