class Debris

  attr_reader :x, :y

  def initialize(image, x, y, debris_type)
    @x, @y = x, y
    @image = image
    @debris_tile = debris_type
  end

  def draw
    @image[@debris_tile].draw_rot(@x, @y, 1, 0)
  end

  def hit_by?(bullet)
    Gosu::distance(@x, @y, bullet.x, bullet.y) < 30
  end

  def middle_width
    @image[@debris_tile].width / 2
  end


  def middle_height
    @image[@debris_tile].height / 2
  end

end
