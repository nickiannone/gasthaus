class Vertex
  attr_accessor :edges, :name, :pos;
  
  def initialize
    @edges = []
    @name = nil
    @pos = [0.0, 0.0]
  end
  
  # Called from Frame#apply_to_mesh and Edge#update
  def update
    edges.each do |edge| 
      edge.update(self)
    end
  end
  
  # TODO Serialization!
end