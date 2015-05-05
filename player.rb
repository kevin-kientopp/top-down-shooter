class Player
	VELOCITY = 3

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

	def move_up
		@y -= 1
	end

	def move_down
		@y += 1
	end

	def move_left
		@x -= 1
	end

	def move_right
		@x += 1
	end
end