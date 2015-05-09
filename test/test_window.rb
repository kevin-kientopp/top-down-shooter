require 'minitest/autorun'
require 'top_down_shooter/window'
require 'gosu'

class TestWindow < Minitest::Test
  def test_shoot_gun
    window = Window.new
    window.button_down Gosu::KbSpace

    assert_equal(1, window.bullets.size)
  end
end
