require 'minitest/autorun'
require 'top_down_shooter/player'

class TestPlayer < Minitest::Test
  def test_move_up
    player = Player.new nil
    player.move_up

    assert_equal(-Player::VELOCITY, player.y)
  end

  def test_move_down
    player = Player.new nil
    player.move_down

    assert_equal(Player::VELOCITY, player.y)
  end

  def test_move_right
    player = Player.new nil
    player.move_right

    assert_equal(Player::VELOCITY, player.x)
  end

  def test_move_left
    player = Player.new nil
    player.move_left

    assert_equal(-Player::VELOCITY, player.x)
  end

  def test_move_up_angle
    player = Player.new nil
    player.move_up

    assert_equal(0, player.angle)
  end

  def test_move_down_angle
    player = Player.new nil
    player.move_down

    assert_equal(180, player.angle)
  end

  def test_move_right_angle
    player = Player.new nil
    player.move_right

    assert_equal(90, player.angle)
  end

  def test_move_left_angle
    player = Player.new nil
    player.move_left

    assert_equal(270, player.angle)
  end
end
