from envs.constants import FloorColor, Side
from envs.tile import Tile
import sprites

def get_color(color: FloorColor):
  if color == FloorColor.RED:
    return "red"
  elif color == FloorColor.BLUE:
    return "blue"
  elif color == FloorColor.PURPLE:
    return "purple"

def get_sprite_from_borders(sprite_map: dict, borders: list[Side]):
  if len(borders) == 0:
    return sprite_map["middle_center"]

  category = []
  
  if Side.TOP in borders:
    category.append("top")
  
  if Side.RIGHT in borders:
    category.append("right")
  
  if Side.BOTTOM in borders:
    category.append("bottom")
  
  if Side.LEFT in borders:
    category.append("left")
    
  if len(category) == 1:
    if category[0] == "top" or category[0] == "bottom": 
      category.append("center")
    else:
      category.insert(0, "middle")
      
  category_name = "_".join(category)
  
  if category_name not in sprite_map:
    raise Exception(f"Floor with category {category_name} not found")
  
  return sprite_map[category_name]["without_middle"]
 

class Floor(Tile):
  def __init__(self, color: FloorColor, borders: list[Side] = []):
    super().__init__(True, True)
    self.color = color
    self.borders = borders
    self.set_image()
    
  def set_image(self):
    sprites.sprites
    
    colored_sprites = sprites.sprite_map[get_color(self.color) + "_carpet"]
    
    return super().set_image(get_sprite_from_borders(colored_sprites, self.borders))