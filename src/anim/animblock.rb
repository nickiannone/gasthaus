require 'gosu'

class AnimBlock
  attr_accessor :x, :y, :z, :angle, :mode, :skin, :flip_x, :flip_y, :length, :thickness
  
  def initialize(x = 0.0, y = 0.0)
    # NOTE: These are calculated by the animation system!
    @x = x
    @y = y
    
    @z = 0.0 # depth
    @length = 1.0
    @angle = 0.0 # radians
    @mode = :normal # either this or :additive
    @skin = nil
    @color = Gosu::Color.argb(0xff_ffffff);
    @flip_x = false
    @flip_y = false
    @thickness = 1.0
  end
  
  def calculate_scene_pos
    # get the width of the block.
    width = (@skin.nil?) ? 1.0 : @skin.width
  
    # set up the original points
    upper_left = [-(width/2),0]
    upper_right = [width/2,0]
    lower_left = [-(width/2),@height]
    lower_right = [width/2,@height]
    
    # Rotate
    upper_left = rotate(upper_left, @angle)
    upper_right = rotate(upper_right, @angle)
    lower_left = rotate(lower_left, @angle)
    lower_right = rotate(lower_right, @angle)
    
    # Translate
    upper_left = translate(upper_left, [@x, @y])
    upper_right = translate(upper_right, [@x, @y])
    lower_left = translate(lower_left, [@x, @y])
    lower_right = translate(lower_right, [@x, @y])
    
    # Swap sides if needed
    if @flip_x then
      upper_left, upper_right = upper_right, upper_left
      lower_left, lower_right = lower_right, lower_left
    end
    
    if @flip_y then
      upper_left, lower_left = lower_left, upper_left
      upper_right, lower_right = lower_right, upper_right
    end
    
    # Return the points in Gosu order (clockwise from upper-left).
    [ upper_left, upper_right, lower_right, lower_left ]
    
  end
  
  def rotate(point, angle)
    s = Math.sin(angle)
    c = Math.cos(angle)
    rx = x * c - y * s
    ry = x * s - y * c
    return [rx, ry]
  end
  
  def translate(point, offset)
    [point[0] + offset[0], point[1] + offset[1]]
  end
end
