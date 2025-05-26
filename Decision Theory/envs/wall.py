from envs.tile import Tile
from sprites import sprite_map

class Wall(Tile):
  def __init__(self, is_half: bool):
    super().__init__(False, False)
    if is_half:
      self.set_image(sprite_map["wall"]["half"])
    else:
      self.set_image(sprite_map["wall"]["top"])
  
  def register_bottom_neighbor(self, neighbor):
    if neighbor is Wall:
      self.set_image(sprite_map["wall"]["top"])
    else:
      self.set_image(sprite_map["wall"]["front"])
    
  def set_on_fire(self):
    pass