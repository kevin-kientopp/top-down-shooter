require 'gosu'
require_relative 'gun_wielder'

class Enemy < GunWielder
  attr_accessor :angle, :shot_cooldown, :dying_timer
  attr_reader :x, :y

  def initialize(x, y, angle, image = nil, bullet_image = nil, dying_image = nil)
    super bullet_image
    @x, @y, @angle, @image, @dying_image = x, y, angle, image, dying_image
    @player_tile = 0
    @shot_cooldown = 0
    @dying_timer = 0
  end

  def draw
    if dying?
      @dying_image.draw_rot(@x, @y, 1, @angle) unless @dying_timer % 20 > 10
    else
      @image[@player_tile].draw_rot(@x, @y, 1, @angle)
    end
  end

  def is_aware_of?(player)
    return true if Gosu.distance(@x, @y, player.x, player.y) < 250
    return false
  end

  def dying?
    @dying_timer > 0
  end

  def turn_towards(player)
    diff = Gosu.angle_diff(@angle, Gosu.angle(@x, @y, player.x, player.y))

    if diff < 0
      @angle += [diff, -2].max
    else
      @angle += [diff, 2].min
    end
  end
end
