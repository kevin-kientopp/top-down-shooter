class DyingPlayerDrawer
  attr_accessor :dying_timer

  def initialize(image)
    @image = image
    @dying_timer = 0
  end

  def draw(x, y, angle)
    @image.draw_rot(x, y, 1, angle) unless @dying_timer % 20 > 10
  end
end
