require 'gosu'

def asset_path(filename)
  File.join(File.dirname(File.dirname(__FILE__)), "assets", filename)
end

class Resources
  @@cache = Hash.new
  
  IMAGE = "IMG:"
  TILES = "TIL:"
  SOUND = "SND:"
  SONG  = "SNG:"
  VIDEO = "VID:"
  
  def self.load_image(filename, options = {})
    if !@@cache.include?(IMAGE + filename) then
      @@cache[IMAGE + filename] = Gosu::Image.new(asset_path(filename))
    end
    @@cache[IMAGE + filename]
  end
  
#  def self.load_tiles(filename, tile_width, tile_height, options = {})
#    if !@@cache.include?(TILES + filename) then
#      @@cache[TILES + filename] = Gosu::Image.load_tiles(asset_path(filename), tile_width, tile_height, options)
#    end
#    @@cache[TILES + filename]
#  end
end
