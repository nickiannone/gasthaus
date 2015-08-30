class Mesh
  attr_accessor :edges, :vertices
  
  def initialize
    @edges = {}
    @vertices = {}
  end
  
  # TODO Serialization!
end