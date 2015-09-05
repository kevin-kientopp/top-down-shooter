class PlayerDrawer
  def initialize(images)
    @images = images
    @frame = 0
  end

  def draw(x, y, angle)
    @images[@frame].draw_rot(x, y, 1, angle)
  end
end
