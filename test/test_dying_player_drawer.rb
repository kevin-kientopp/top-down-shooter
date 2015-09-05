require 'minitest/autorun'
require 'minitest/mock'
require 'top_down_shooter/dying_player_drawer.rb'

class TestDyingPlayerDrawer < Minitest::Test
  def test_draw
    mock_image = MiniTest::Mock.new
    mock_image.expect(:draw_rot, nil, [0, 0, 1, 0])

    dying_player_drawer = DyingPlayerDrawer.new(mock_image)
    dying_player_drawer.draw(0, 0, 0)

    mock_image.verify
  end

  def test_draw_flashing_blank
    mock_image = MiniTest::Mock.new

    dying_player_drawer = DyingPlayerDrawer.new(mock_image)
    dying_player_drawer.dying_timer = 11
    dying_player_drawer.draw(0, 0, 0)

    mock_image.verify
  end
end
