require 'gosu'

class EdgeModification

  attr_accessor :z, :length, :angle, :mode, :skin, :color, :flip_x, :flip_y, :thickness

  def initialize
    @z = nil
    @length = nil
    @angle = nil
    @mode = nil
    @skin = nil
    @color = nil
    @flip_x = nil
    @flip_y = nil
    @thickness = nil
  end
  
  def clone(other)
    mod = EdgeModification.new
    mod.changes = other.changes
    mod
  end
  
  def changes
    c = {}
    c[:z] = @z if @z
    c[:length] = @length if @length
    c[:angle] = @angle if @angle
    c[:mode] = @mode if @mode
    c[:skin] = @skin if @skin
    c[:color] = @color if @color
    c[:flip_x] = @flip_x if @flip_x != nil # since boolean
    c[:flip_y] = @flip_y if @flip_y != nil # since boolean
    c[:thickness] = @thickness if @thickness
    c
  end
  def changes=(c)
    if c.is_a?(Hash) then
      @z = c[:z] if c.key?(:z)
      @length = c[:length] if c.key?[:length]
      @angle = c[:angle] if c.key?[:angle]
      @mode = c[:mode] if c.key?[:mode]
      @skin = c[:skin] if c.key?[:skin]
      @color = c[:color] if c.key?[:color]
      @flip_x = c[:flip_x] if c.key?[:flip_x]
      @flip_y = c[:flip_y] if c.key?[:flip_y]
      @thickness = c[:thickness] if c.key?[:thickness]
    end
  end
  
  def self.create_dummy
    dummy = EdgeModification.new
    dummy.z = 0.0
    dummy.length = 1.0
    dummy.angle = 0.0
    dummy.mode = :normal
    dummy.skin = nil
    dummy.color = Gosu::Color.argb(0xff_ffffff)
    dummy.flip_x = false
    dummy.flip_y = false
    dummy.thickness = 1.0
    dummy
  end
  
  # TODO Create lerped!
  def self.create_lerped(first, second, delta_pct)
    # Merge the first set of changes from a dummy object!
    safe_first = EdgeModification.create_dummy
    safe_first.changes = first.changes
  
    lerped = EdgeModification.new
    
    # Inherit these from the first one.
    lerped.mode = safe_first.mode
    lerped.skin = safe_first.skin
    lerped.flip_x = safe_first.flip_x
    lerped.flip_y = safe_first.flip_y
    lerped.color = safe_first.color # TODO Convert this to a smooth color gradation?
    
    # interpolate these - z, length, angle, thickness
    lerped.z = (second.z.nil?) ? safe_first.z : lerp(safe_first.z, second.z, delta_pct)
    lerped.length = (second.length.nil?) ? safe_first.length : lerp(safe_first.length, second.length, delta_pct)
    lerped.angle = (second.angle.nil?) ? safe_first.angle : lerp(safe_first.angle, second.angle, delta_pct)
    lerped.thickness = (second.thickness.nil?) ? safe_first.thickness : lerp(safe_first.thickness, second.thickness, delta_pct)
    
    # return.
    lerped
  end
  
  def self.lerp(a, b, percent)
    (a * percent) + (b * (1.0 - percent))
  end
  
  # TODO Serialization!
end