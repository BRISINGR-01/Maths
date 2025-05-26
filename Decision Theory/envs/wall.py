from envs.tile import Tile
from sprites import sprite_map

class Wall(Tile):
  def __init__(self, is_half: bool, bottom_neighbor: Tile):
    super().__init__(False, False)
    if is_half:
      self.set_image(sprite_map["wall"]["half"])
    elif bottom_neighbor is not Wall:
      self.set_image(sprite_map["wall"]["front"])
    else:
      self.set_image(sprite_map["wall"]["top"])