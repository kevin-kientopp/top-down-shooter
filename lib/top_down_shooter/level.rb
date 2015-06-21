require_relative 'tile'
require_relative 'debris'

class Level
  WIDTH = 20*Tile::WIDTH
  HEIGHT = 20*Tile::HEIGHT

  attr_reader :debris

  def initialize(images, debris_images)
    random = Random.new

    @tiles = Array.new(20) { |e| e = Array.new(20) { |i| i = Tile.new(Tile::WIDTH/2.0+i*Tile::WIDTH, Tile::HEIGHT/2.0+e*Tile::HEIGHT, images.sample) } }
    @debris = Array.new(15) { |e| e = Array.new(15) { |i| i = Debris.new debris_images, random.rand(0...Level::WIDTH), random.rand(0...Level::HEIGHT), random.rand(0...2) } }
  end

  def draw(bullets)
    @tiles.flatten.each { |tile| tile.draw }

    @debris.each do |arrayOfDebris|
      arrayOfDebris.delete_if do |singleDebris, single_debris_hit_by|
        bullets.delete_if do |bullet|
          single_debris_hit_by = singleDebris.hit_by?(bullet)
          single_debris_hit_by
        end
        singleDebris.draw
        single_debris_hit_by
      end
    end
  end
end
