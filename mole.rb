require 'gosu'

# Class WackaMole
class WhackaMole < Gosu::Window
	def initialize
		super(800,600)
		self.caption = "Whack a Mole"

	end
end

window = WhackaMole.new

window.show