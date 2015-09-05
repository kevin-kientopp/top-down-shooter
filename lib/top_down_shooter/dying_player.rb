class DyingPlayer < Player
  def initialize(image)
    super(image)
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle) unless @dying_timer % 20 > 10
  end

  def move_left(debris)
    # do nothing
  end

  def move_right(debris)
    # do nothing
  end

  def move_up(debris)
    # do nothing
  end

  def move_down(debris)
    # do nothing
  end
end
