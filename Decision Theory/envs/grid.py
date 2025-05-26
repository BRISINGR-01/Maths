from envs.constants import FloorType
from envs.tile import Tile
from envs.item import Item, Items
from envs.floor import Floor, Side

class Grid:
  def __init__(self, size):
    self.size = size
    self.create_grid()
  
  def create_grid(self):
    self.tiles: list[list[Tile]] = []
    for _ in range(self.size):
      row: list[Tile] = []
      for _ in range(self.size):
        row.append(Floor(FloorType.BLUE, [Side.TOP, Side.RIGHT]))
      self.tiles.append(row)
    
    self.tiles[0][0].is_on_fire = True
    self.tiles[0][3] = Item(Items.POT, Floor(FloorType.BLUE, [Side.TOP, Side.RIGHT, Side.BOTTOM, Side.LEFT]))
    self.tiles[0][3].is_on_fire = True
  
  def update(self):
    pass

  def draw(self, canvas, square_size):
    for y, row in enumerate(self.tiles):
      for x, tile in enumerate(row):
        tile.draw(canvas, square_size, x, y)

        if tile.is_on_fire:
            tile.draw_fire(canvas, square_size, x, y)
    