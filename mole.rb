require 'gosu'

# Class WackaMole fetching Gosu library
class WhackaMole < Gosu::Window
	def initialize
		super(800,600) # Size of game window
		self.caption = "Whack a Mole" # Game title on game window

		# Instance variable that creates an instance of mole image
		@image = Gosu::Image.new('images/mole.png')

		# x and y instance variables that decides where mole image will appear in game window
		@x = 200 # Distance from the left side of gamewindow (200px)
		@y = 200 # Distance from top side of gamewindow (200px)

		# @width and @height instance variables is for finding the center of the mole image
		@width = 100
		@height = 75

		# Instance variabels for movements of mole
		@velocity_x = 4 # speed 4
		@velocity_y = 4

		# Instance variable for making mole blink
		@visible = 0

		# Instance variable that creates instance of hammer image
		@hammer = Gosu::Image.new('images/hammer.png')

		#Instance variable for handling mouse click for hammer
		@hit = 0

		# Instance variable for keeping score and showing on screen
		@font = Gosu::Font.new(30)
		@score = 0
	end

	# Draws the mole image in gamewindow
	def draw
		# Only show mole if @visibile is greater than 0
		if @visible > 0
			@image.draw(@x - @width / 2, @y - @height / 2, 1) # image coords and if there are more images than 1, the number 1 decides position in gamewindow
		end
		# Draw hammer and be visible all the time and its movement coords based on mouse movement
		@hammer.draw(mouse_x - 25, mouse_y - 39, 1)

		# Check if mole was hit or missed with button click
		# and change background color based on hit or miss
		if @hit == 0
			c = Gosu::Color::NONE
		elsif @hit == 1
			c = Gosu::Color::GREEN
		elsif @hit == -1
			c = Gosu::Color::RED
		end

		# Make background color square shaped to fit gamewindow
		draw_quad(0, 0, c, 800, 0, c, 800, 600, c, 0, 600, c)
		@hit = 0

		# Show score on gamewindow
		@font.draw("Your Score: #{ @score.to_s }", 500, 50, 2)	
			
	end

	# Updates all animation and movements in the game
	def update
		@x += @velocity_x
		@y += @velocity_y

		# If mole hits game wall change direction instead of passing throu
		@velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0 
		@velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 1 

		# Making mole invisible for 10 frames
		@visible -= 1
		# Making mole visible for 50 frames
		@visible = 50 if @visible < -10 && rand < 0.01

		# Time limit for game session, 1 minute
		@time_left = (60 - (Gosu.milliseconds / 1000))
	end

	# Method for handling mouse click, button_down is a gosu method that handles whatever
	# if its a mouse, gamepad, keyboard or mousepad
	def button_down(id)
		# Using left mouse button, check if left mouse button was pressed
		if(id == Gosu::MsLeft)
			# Check if left mouse button was clicked with hammer distance 60 frames from mole image and if 
			# mole image was visible
			if Gosu.distance(mouse_x, mouse_y, @x, @y) < 60 && @visible >= 0
				@hit = 1
				@score += 10
			else
				@hit = -1
				@score -= 3
			end
		end
	end
end

# Save class in to variable window
window = WhackaMole.new
# Show gamewindow
window.show