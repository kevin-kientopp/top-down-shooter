class Window < Gosu::Window
  WIDTH = 640
  HEIGHT = 480

  def initialize
    super WIDTH, HEIGHT, false
    self.caption = 'Sexy Vampire Shooter'

    @player = Player.new(self, Gosu::Image.new(self, 'media/player.png', true))
    @player.warp(Level::WIDTH/2.0, Level::HEIGHT/2.0)

    tile_images = Array.new
    tile_images.push Gosu::Image.new(self, 'media/tile.png', true)
    tile_images.push Gosu::Image.new(self, 'media/tile2.png', true)

    @level = Level.new tile_images
  end

  def update
    @player.move_left if button_down? Gosu::KbLeft unless @player.x < 0
    @player.move_right if button_down? Gosu::KbRight unless @player.x > Level::WIDTH
    @player.move_up if button_down? Gosu::KbUp unless @player.y < 0
    @player.move_down if button_down? Gosu::KbDown unless @player.y > Level::HEIGHT
  end

  def draw
    translate(calculate_camera_translation(@player.x, WIDTH, Level::WIDTH), calculate_camera_translation(@player.y, HEIGHT, Level::HEIGHT)) do
      @player.draw
      @level.draw
    end
  end

  def button_down(id)

  end

  private
  def calculate_camera_translation(axis_position, axis_screen_size, axis_level_size)
    return 0 if axis_position < axis_screen_size/2.0
    return -axis_level_size + axis_screen_size if axis_position > axis_level_size - axis_screen_size/2.0
    return axis_screen_size/2.0 - axis_position
  end
end
