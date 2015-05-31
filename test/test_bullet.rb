require 'minitest/autorun'
require 'top_down_shooter/bullet.rb'

class TestBullet < Minitest::Test
  def test_move_down
    bullet = Bullet.new(0, 5, 180, nil, nil)
    bullet.move

    assert_equal(7, bullet.y)
  end

  def test_move_up
    bullet = Bullet.new(0, 5, 0, nil, nil)
    bullet.move

    assert_equal(3, bullet.y)
  end

  def test_move_left
    bullet = Bullet.new(5, 0, 270, nil, nil)
    bullet.move

    assert_equal(3, bullet.x)
  end

  def test_move_right
    bullet = Bullet.new(5, 0, 90, nil, nil)
    bullet.move

    assert_equal(7, bullet.x)
  end
end
