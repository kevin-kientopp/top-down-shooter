require 'gosu'

class Enemy
  attr_accessor :angle
  attr_reader :x, :y

  def initialize(x, y, image)
    @x, @y, @image = x, y, image
    @player_tile = 0
    @angle = 0
  end

  def draw
    @image[@player_tile].draw_rot(@x, @y, 1, @angle)
  end

  def is_aware_of?(player)
    return true if Gosu.distance(@x, @y, player.x, player.y) < 250
    return false
  end

  def turn_towards(player)
    @angle = Gosu.angle(@x, @y, player.x, player.y)
  end
end
