from envs.tile import Tile
from envs.floor import Floor, FloorColor, Side

class Grid:
  def __init__(self, size):
    self.size = size
    self.create_grid()
  
  def create_grid(self):
    self.tiles: list[list[Tile]] = []
    for _ in range(self.size):
      row: list[Tile] = []
      for _ in range(self.size):
        row.append(Floor(FloorColor.RED, [Side.TOP, Side.RIGHT]))
      self.tiles.append(row)
    
    
    self.tiles[0][0].is_on_fire = True