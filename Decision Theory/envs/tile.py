class Tile:
  image = None
  is_on_fire = False
  fire_state = 1
  
  def __init__(self, is_traversable, can_burn):
    self.is_traversable = is_traversable
    self.can_burn = can_burn
  
  def set_image(self, image):
    self.image = image
  
  def increase_fire(self):
    self.fire_state += 1
    
    if self.fire_state == 5:
      self.fire_state= 1