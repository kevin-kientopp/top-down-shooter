require 'gosu'

class Bullet
  VELOCITY = 2

  attr_reader :x, :y, :fired_by

  def initialize(x, y, angle, image, fired_by)
    @x, @y, @angle, @image, @fired_by = x, y, angle, image, fired_by
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  def move
    @x += Gosu.offset_x(@angle, VELOCITY)
    @y += Gosu.offset_y(@angle, VELOCITY)
  end
end
