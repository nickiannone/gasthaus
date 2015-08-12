require 'gosu'
require 'gamewindow'

module Levels
	class Level
		def initialize
		end
		
		# Game callbacks
		def set_up(gamewindow)
		end
		
		def tear_down(gamewindow)
		end
		
		# Gosu callbacks
		def draw(gamewindow)
		end
		
		def update(gamewindow)
		end
		
		def button_down(gamewindow, id)
		end
		
		def button_up(gamewindow, id)
		end
		
		def needs_cursor?
		end
		
		def needs_redraw?
		end
	end
end
