class Window < Gosu::Window
  WIDTH = 640
  HEIGHT = 480

  def initialize
    super WIDTH, HEIGHT, false
    self.caption = 'Sexy Vampire Shooter'

    @player = Player.new(Gosu::Image.load_tiles(self, '../media/player.png', 16, 21, true))
    @player.warp(Level::WIDTH/2.0, Level::HEIGHT/2.0)

    tile_images = Array.new
    tile_images.push Gosu::Image.new(self, '../media/tile.png', true)
    tile_images.push Gosu::Image.new(self, '../media/tile2.png', true)

    @level = Level.new tile_images

    @bullet_image = Gosu::Image.new(self, '../media/bullet.png', true)
    @bullets = Array.new
  end

  def update
    @player.move_left if button_down? Gosu::KbLeft unless @player.x < 0
    @player.move_right if button_down? Gosu::KbRight unless @player.x > Level::WIDTH
    @player.move_up if button_down? Gosu::KbUp unless @player.y < 0
    @player.move_down if button_down? Gosu::KbDown unless @player.y > Level::HEIGHT
    @bullets.each { |b| b.move }
  end

  def draw
    translate(calculate_camera_translation(@player.x, WIDTH, Level::WIDTH), calculate_camera_translation(@player.y, HEIGHT, Level::HEIGHT)) do
      @player.draw
      @level.draw
      @bullets.each { |e| e.draw }
    end
  end

  def button_down(id)
    x, y = calculate_bullet_start_position

    @bullets.push Bullet.new(x, y, @player.angle, @bullet_image) if id == Gosu::KbSpace
  end

  private
  def calculate_camera_translation(axis_position, axis_screen_size, axis_level_size)
    return 0 if axis_position < axis_screen_size/2.0
    return -axis_level_size + axis_screen_size if axis_position > axis_level_size - axis_screen_size/2.0
    return axis_screen_size/2.0 - axis_position
  end

  def calculate_bullet_start_position
    distance_from_player = 15
    gun_offset = 5

    x, y = @player.x, @player.y

    case @player.angle
    when 0 #down
      x -= gun_offset
      y += distance_from_player
    when 90 #left
      x -= distance_from_player
      y -= gun_offset
    when 180 #up
      x += gun_offset
      y -= distance_from_player
    when 270 #right
      x += distance_from_player
      y += gun_offset
    end

    return x, y
  end
end