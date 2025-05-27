import pygame
from envs.tiles.tile import Tile
from envs.sprites import sprite_map

class Wall(Tile):
  def __init__(self):
    super().__init__(False, False)
    self.set_image(sprite_map["wall"]["top"])
  
  def register_bottom_neighbor(self, neighbor):
    if isinstance(neighbor, Wall):
      self.set_image(sprite_map["wall"]["top"])
    else:
      self.set_image(sprite_map["wall"]["front"])
  
  def draw(self, canvas, square_size, x, y):
    scaled_sprite = pygame.transform.scale(self.image, (square_size + 1, square_size + 1))
    canvas.blit(scaled_sprite, (x * square_size, y * square_size))
    
    if self.is_on_fire:
      self.draw_fire(canvas, square_size, x, y)

  
  def set_on_fire(self):
    pass