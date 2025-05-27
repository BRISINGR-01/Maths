from envs.constants import FloorType
from envs.tiles.tile import Tile
from envs.tiles.wall import Wall
from envs.tiles.item import Item, Items
from envs.tiles.floor import Floor, Side

def get_borders(tiles: list[list[Tile]], x, y):
  sides: list[Side] = []
  
  if y > 0 and isinstance(tiles[y - 1][x], Wall):
    sides.append(Side.TOP)
  if x < len(tiles[0]) - 1 and isinstance(tiles[y][x + 1], Wall):
    sides.append(Side.RIGHT)
  if y < len(tiles) - 1 and isinstance(tiles[y + 1][x], Wall):
    sides.append(Side.BOTTOM)
  if x > 0 and isinstance(tiles[y][x - 1], Wall):
    sides.append(Side.LEFT)
  
  return sides

class Grid:
  def __init__(self, size):
    self.size = size
    self.create_grid()
  
  def create_grid(self):
    self.tiles: list[list[Tile]] = [[None for _ in range(self.size)] for _ in range(self.size)]
    
    self.tiles[4][3] = Item(Items.TABLE, Floor(FloorType.BLUE, [Side.TOP, Side.RIGHT, Side.BOTTOM, Side.LEFT]))
    self.tiles[4][3].is_on_fire = True
    self.tiles[1][4] = Wall()
    self.tiles[2][4] = Wall()
    self.tiles[2][3] = Wall()
    self.tiles[3][4] = Wall()
    
    for y in range(self.size):
      for x in range(self.size):
        if not self.tiles[y][x]:
          self.tiles[y][x] = Floor(FloorType.BLUE, get_borders(self.tiles, x, y))
        elif isinstance(self.tiles[y][x], Wall) and y < self.size - 1:
          self.tiles[y][x].register_bottom_neighbor(self.tiles[y + 1][x])
  
    self.tiles[0][0].is_on_fire = True
  
  def update(self):
    pass

  def draw(self, canvas, square_size):
    for y, row in enumerate(self.tiles):
      for x, tile in enumerate(row):
        tile.draw(canvas, square_size, x, y)
        