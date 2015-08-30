require 'gosu'

class Edge
  attr_accessor :parent, :child, :z, :length, :angle, :mode, :skin, :color, :flip_x, :flip_y, :thickness
  
  # Called from Frame#apply_to_mesh
  # TODO Make this non-sparse? Might end up chopping off values if animation change in the middle!
  def apply(edgemod)
    c = edgemod.changes
    @z = c[:z] if c[:z]
    @length = c[:length] if c[:length]
    @angle = c[:angle] if c[:angle]
    @mode = c[:mode] if c[:mode]
    @skin = c[:skin] if c[:skin]
    @color = c[:skin] if c[:skin]
    @flip_x = c[:flip_x] if !(c[:flip_x].nil?)
    @flip_y = c[:flip_y] if !(c[:flip_y].nil?)
    @thickness = c[:thickness] if c[:thickness]
  end
  
  # Called from Vertex#update
  def update(parent)
    @parent = parent
    root_pos = [
      parent.pos[0] + (@length * Math.cos(@angle)),
      parent.pos[1] + (@length * Math.sin(@angle))
    ]
    @child.pos = root_pos
    @child.update
  end
  
  # TODO Serialization!
end