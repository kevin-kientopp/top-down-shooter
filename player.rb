class Player
	def initialize(window, image)
		@image = image
		@x = @y = 0.0
	end
	
	def draw
		@image.draw_rot(@x, @y, 1, 0)
	end	

	def warp(x, y)
		@x, @y = x, y
	end
end