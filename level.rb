class Level
  def initialize(image)
    @tiles = Array.new(20) { |e| e = Array.new(20) { |i| i = Tile.new(i*50, e*50, image) } }
  end

  def draw
    @tiles.flatten.each { |e| e.draw }
  end

end
