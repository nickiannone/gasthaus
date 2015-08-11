require 'gosu'
require 'levels'

class GameWindow < Gosu::Window
	def initialize(width=800, height=600, fullscreen=false)
		super
		self.caption = 'Gasthaus'
		change_level(Levels::MainMenu.new)
	end
	
	# custom methods
	
	def change_level(newLevel) 
		@level.tear_down(self) if @level != nil
		@level = newLevel
		newLevel.set_up(self)
	end
	
	# Gosu callbacks - pipe into the level object.
	
	def draw
		@level.draw(self)
	end
	
	def update
		@level.update(self)
	end
	
	def button_down(id)
		@level.button_down(self, id)
	end
	
	def button_up(id)
		@level.button_up(self, id)
	end
	
	def needs_cursor?
		@level.needs_cursor?
	end
	
	def needs_redraw?
		@level.needs_redraw?
	end
end
