# frozen_string_literal: true

require_relative 'exploding_die'

# A kind of exploding die that explodes on more than one face
class BroadlyExplodingDie < ExplodingDie
  attr :exploding_faces

  def initialize(exploding_faces:, order: 6)
    super(order:)

    @exploding_faces = exploding_faces

    validate_exploding_faces!
  end

  private

  def explode?(face)
    exploding_faces.include?(face)
  end

  def validate_exploding_faces!
    unless exploding_faces.is_a?(Array)
      raise ArgumentError, 'exploding_faces must be an Array'
    end

    # expensive for large dice
    non_exploding_faces = (1..order).to_a - exploding_faces

    raise ArgumentError, <<~MSG if non_exploding_faces.empty?
      Too many exploding faces. This die would always explode!
    MSG
  end
end
