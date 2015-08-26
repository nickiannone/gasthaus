require './gameobject'
require '../resources'

class Customer < GameObject
  BASE_SPEED = 1.0
  
	def initialize(spriteset)
	  @nerve = 0
	  @fear = 0
	  @spriteset = Resources.load_tiles(spriteset)
	  @frame = @spriteset[0]
	  @waypoints = []
	end
	
	def move_to(point)
	  # scrap the existing waypoints.
	  @waypoints = []
	  
	  # TODO pathfind through to the given point.
	  # TODO Integrate this into a subsystem that knows the grid system!
	  
	  # TEMP For right now, though, just go straight there.
	  @waypoints = [ [self.x, self.y], [point[0], point[1]] ]
	end
	
	def calc_move_speed
	  # TODO Tune this 
	  BASE_SPEED - (@nerve / 100) + (@fear / 50)
	end
	
	def direction
	  
	end
	
	def update_ai(gamewindow)
	  dt = gamewindow.delta_time
	  
	end
end
