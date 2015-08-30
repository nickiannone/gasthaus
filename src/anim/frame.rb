require 'gosu'
require './edgemodification'

class Frame
  attr_accessor :time, :name, :edgemods
  
  def initialize()
    @time = 0.0
    @name = nil
    @edgemods = {} # hash of numeric edge ID => EdgeModification object
  end
  
  def self.interpolate(frames, time)
    # Build a frame.
    prev_frame = Frame.new
    
    # Go through all except the last keyframe, aggregating all values.
	  # NOTE: This design inherently can't handle long animations well!
    for i in 0..frames.size-2 do
      prev_frame.time = frames[i].time
      for edge_id in frames[i].edgemods.keys do # merge all edge modifications.
        new_edge_mod = frames[i].edgemods[edge_id]
        if prev_frame.edgemods.key?(edge_id) then
          # Overwrite any updated fields.
          prev_frame.edgemods[edge_id].changes = new_edge_mod.changes
        else 
          # Clone it and add it.
          prev_frame.edgemods[edge_id] = new_edge_mod.clone
        end
      end
    end
    
    # Create the in-between frame.
    tween = Frame.new
    tween.edgemods = prev_frame.edgemods
    
    next_frame = frames[frames.size-1]
    delta_pct = (time - prev_frame.time) / (next_frame.time - prev_frame.time)
    
    for edge_id in next_frame.edgemods.keys do
        prev_mod = prev_frame.edgemods[edge_id]
        next_mod = next_frame.edgemods[edge_id]
        tween.edgemods[edge_id] = EdgeModification.create_lerped(prev_mod, next_mod, delta_pct)
    end
    
    tween.time = time
    
    # Return
    tween
  end
  
  def apply_to_mesh(mesh)
    # Take each edge mod, look up the edge in the current mesh, and apply length and angle.
    edgemods.keys.each do |edge_id| 
      edgemod = edgemods[edge_id]
      mesh.edges[edge_id].apply(edgemod)
    end
    
    # Walk through each vertex in the tree and update its position (depth or breadth first?)
    mesh.vertices["root"].update
  end
  
  # TODO Serialization!
end
