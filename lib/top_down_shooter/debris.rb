class Debris

   attr_reader :x, :y, :hp

  def initialize(image, x, y, debris_type)
    @x, @y = x, y
    @hp = 5
    @image = image
    @debris_tile = debris_type

  end

  def draw
    if @hp > 0
      @image[@debris_tile].draw(@x, @y, 1)
    end
  end

  def hit_by?(bullet)
    if Gosu::distance(@x + middle_width, @y + middle_height, bullet.x, bullet.y) < 30
        @hp =- 1
    end
  end

  def middle_width
    @image[@debris_tile].width / 4
  end


   def middle_height
     @image[@debris_tile].height / 2
   end

end