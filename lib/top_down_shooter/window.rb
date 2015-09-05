require 'gosu'
require_relative 'player'
require_relative 'dying_player'
require_relative 'level'
require_relative 'bullet'
require_relative 'enemy'
require_relative 'player_drawer'

class Window < Gosu::Window
  WIDTH = 640
  HEIGHT = 480

  attr_reader :bullets, :player, :enemies
  attr_writer :sounds_enabled

  def initialize
    super WIDTH, HEIGHT, false
    self.caption = 'Sexy Vampire Shooter'

    @sounds_enabled = true

    bullet_image = Gosu::Image.new(self, 'media/bullet.png', true)
    @bullets = Array.new

    @dying_image = Gosu::Image.new(self, 'media/dead_player.png', true)
    player_images = Gosu::Image.load_tiles(self, 'media/player.png', 16, 21, true)
    @player = Player.new(player_images, bullet_image)
    @player.warp(Level::WIDTH/2.0, Level::HEIGHT/2.0)

    tile_images = Array.new
    tile_images.push Gosu::Image.new(self, 'media/tile.png', true)
    tile_images.push Gosu::Image.new(self, 'media/tile2.png', true)

    debris_images = Gosu::Image.load_tiles(self, 'media/debris_rocks.png', 58, 60, true)

    @level = Level.new tile_images, debris_images

    @gun_sample = Gosu::Sample.new(self, 'media/Colt1911_1.ogg')

    enemy_image = Gosu::Image.load_tiles(self, 'media/enemy.png', 16, 21, true)
    dying_enemy_image = Gosu::Image.new(self, 'media/dead_enemy.png', true)
    @enemies = Array.new
    @enemies.push Enemy.new(@player.x, @player.y - 200, 180, enemy_image, bullet_image, dying_enemy_image)

    @font = Gosu::Font.new(20)
    @sounds_status_timer = 0

    @dying_sample = Gosu::Sample.new(self, 'media/dying.ogg')
  end

  def update
    @sounds_status_timer -= 1 if @sounds_status_timer > 0

    @player.move_left(@level.debris) if button_down? Gosu::KbLeft unless @player.x < 0 or @player.dying?
    @player.move_right(@level.debris) if button_down? Gosu::KbRight unless @player.x > Level::WIDTH or @player.dying?
    @player.move_up(@level.debris) if button_down? Gosu::KbUp unless @player.y < 0 or @player.dying?
    @player.move_down(@level.debris) if button_down? Gosu::KbDown unless @player.y > Level::HEIGHT or @player.dying?

    @bullets.each { |b| b.move }

    @enemies.each do |e|
      bullets_hitting_enemy = @bullets.select { |b| Gosu::distance(e.x, e.y, b.x, b.y) < 8 }
      if !e.dying? and !bullets_hitting_enemy.empty?
        e.dying_timer = 300
      end
      @bullets -= bullets_hitting_enemy
      e.dying_timer -= 1

      if !e.dying? and e.is_aware_of? player
        e.turn_towards player
        if (e.shot_cooldown <= 0)
          e.shot_cooldown = 60
          @bullets << e.shoot
        else
          e.shot_cooldown -= 1
        end
      end
    end

    bullets_hitting_player = @bullets.select { |b| Gosu::distance(b.x, b.y, @player.x, @player.y) < 8 }
    if !@player.dying? and !bullets_hitting_player.empty?
      @dying_sample.play if sounds_enabled?
      x, y = @player.x, @player.y
      @player = DyingPlayer.new(@dying_image)
      @player.warp(x, y)
      @player.dying_timer = 300
    end
    @bullets -= bullets_hitting_player

    @player.dying_timer -= 1
  end

  def draw
    @font.draw("Sound " + (sounds_enabled? ? "enabled" : "disabled"), 10, 10, 3, 1.0, 1.0, 0xff_ffff00) if @sounds_status_timer > 0

    translate(calculate_camera_translation(@player.x, WIDTH, Level::WIDTH), calculate_camera_translation(@player.y, HEIGHT, Level::HEIGHT)) do
      @player.draw
      @level.draw(@bullets)
      @bullets.each { |e| e.draw }
      @enemies.each { |e| e.draw }
    end
  end

  def button_down(id)
    case id
    when Gosu::KbSpace
      @gun_sample.play if sounds_enabled?

      @bullets << @player.shoot
    when Gosu::KbS
      @sounds_enabled, @sounds_status_timer = !@sounds_enabled, 120 if button_down? Gosu::KbLeftControl or button_down? Gosu::KbRightControl
    end
  end

  private
  def calculate_camera_translation(axis_position, axis_screen_size, axis_level_size)
    return 0 if axis_position < axis_screen_size/2.0
    return -axis_level_size + axis_screen_size if axis_position > axis_level_size - axis_screen_size/2.0
    return axis_screen_size/2.0 - axis_position
  end

  def sounds_enabled?
    return @sounds_enabled
  end
end
