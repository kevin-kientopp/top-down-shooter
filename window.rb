class Window < Gosu::Window
  WIDTH = 640
  HEIGHT = 480

  def initialize
    super WIDTH, HEIGHT, false
    self.caption = 'Sexy Vampire Shooter'

    @player = Player.new(self, Gosu::Image.new(self, 'media/player.png', true))
    @player.warp(Level::WIDTH/2.0, Level::HEIGHT/2.0)

    puts Level::WIDTH/4.0

    tile_images = Array.new
    tile_images.push Gosu::Image.new(self, 'media/tile.png', true)
    tile_images.push Gosu::Image.new(self, 'media/tile2.png', true)

    @level = Level.new tile_images
  end

  def update
    @player.move_left if button_down? Gosu::KbLeft
    @player.move_right if button_down? Gosu::KbRight
    @player.move_up if button_down? Gosu::KbUp
    @player.move_down if button_down? Gosu::KbDown
  end

  def draw
    translate(WIDTH/2.0-@player.x, HEIGHT/2.0-@player.y) do
      @player.draw
      @level.draw
    end
  end

  def button_down(id)

  end
end
