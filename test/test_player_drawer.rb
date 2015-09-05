require 'minitest/autorun'
require 'minitest/mock'
require 'top_down_shooter/player_drawer.rb'

class TestPlayerDrawer < Minitest::Test
  def test_draw
    mock_image = MiniTest::Mock.new
    mock_image.expect(:draw_rot, nil, [0, 0, 1, 0])

    player_drawer = PlayerDrawer.new([mock_image])
    player_drawer.draw(0, 0, 0)

    mock_image.verify
  end
end
