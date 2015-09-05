require 'minitest/autorun'
require 'top_down_shooter/player'

class TestPlayer < Minitest::Test
  def test_move_up
    player = Player.new nil
    player.move_up(Array.new)

    assert_equal(-Player::VELOCITY, player.y)
    assert_equal(0, player.angle)
  end

  def test_move_down
    player = Player.new nil
    player.move_down(Array.new)

    assert_equal(Player::VELOCITY, player.y)
    assert_equal(180, player.angle)
  end

  def test_move_right
    player = Player.new nil
    player.move_right(Array.new)

    assert_equal(Player::VELOCITY, player.x)
    assert_equal(90, player.angle)
  end

  def test_move_left
    player = Player.new nil
    player.move_left(Array.new)

    assert_equal(-Player::VELOCITY, player.x)
    assert_equal(270, player.angle)
  end
end
