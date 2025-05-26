from envs.floor import Floor
from envs.tile import Tile
from envs.constants import Items, FIRE_LAST_STEP, DURABILITY_POWER
from sprites import sprite_map

class Item(Tile):
  durability = 10
  is_destructable = True
  is_destroyed = False
    
  def __init__(self, type: Items, floor: Floor):
    super().__init__(False, True)
    self.floor = floor
    match type:
      case Items.WINDOW:
        self.is_destructable = False
        self.image = sprite_map["window"]
      case Items.RADIO:
        self.durability = 9
        self.image = sprite_map["radio"]
      case Items.BOOKSHELF_EMPTY:
        self.durability = 12
        self.image = sprite_map["bookshelf"]["empty"]
      case Items.BOOKSHELF_FULL:
        self.durability = 14  # heavier and more solid
        self.image = sprite_map["bookshelf"]["full"]
      case Items.TABLE:
        self.durability = 10
        self.image = sprite_map["table"]
      case Items.CHAIR:
        self.durability = 6
        self.image = sprite_map["chair"]["empty"]
      case Items.CHAIR_BLUE:
        self.durability = 6
        self.image = sprite_map["chair"]["blue"]
      case Items.CHAIR_PURPLE:
        self.durability = 6
        self.image = sprite_map["chair"]["purple"]
      case Items.CHAIR_RED:
        self.durability = 6
        self.image = sprite_map["chair"]["red"]
      case Items.OVEN:
        self.durability = 18  # heavy and metallic
        self.image = sprite_map["oven"]
      case Items.TOILET:
        self.durability = 15  # porcelain, sturdy but breakable
        self.image = sprite_map["toilet"]
      case Items.POT:
        self.durability = 5
        self.image = sprite_map["pot"]["empty"]
      case Items.POT_GREEN:
        self.durability = 5
        self.image = sprite_map["pot"]["green"]
      case Items.POT_PINK:
        self.durability = 5
        self.image = sprite_map["pot"]["pink"]
      case Items.POT_RED:
        self.durability = 5
        self.image = sprite_map["pot"]["red"]
      case Items.CHEST:
        self.durability = 16
        self.image = sprite_map["chest"]
      case Items.STOOL:
        self.durability = 4
        self.image = sprite_map["stool"]
      case Items.BED:
        self.durability = 13
        self.image = sprite_map["bed"]
      case Items.NIGHTSTAND:
        self.durability = 8
        self.image = sprite_map["nightstand"]
      case Items.DOOR:
        self.durability = 20  # very durable
        self.image = sprite_map["door"]
      case Items.TRAPDOOR:
        self.durability = 12
        self.image = sprite_map["trapdoor"]["closed"]
      case Items.TRAPDOOR_OPEN:
        self.durability = 12  # same as closed state
        self.image = sprite_map["trapdoor"]["open"]
      case Items.BIN:
        self.durability = 7
        self.image = sprite_map["bin"]
      case Items.MODERN_BIN:
        self.durability = 9
        self.image = sprite_map["modern-bin"]
      case Items.PICTURE:
        self.image = sprite_map["picture"]
        self.is_destructable = False

    self.durability *= DURABILITY_POWER
    
  def damage(self):
    self.durability -= 1

    if self.durability == 0:
      self.is_destroyed = True

  def increase_fire(self):
    if self.is_destructable and self._fire_state == FIRE_LAST_STEP:
      self.damage()
      
      if self.is_destroyed:
        self.floor.set_on_fire()
    
    return super().increase_fire()
  
  def set_on_fire(self):
    if self.is_destructable:
      super().set_on_fire()

  def draw(self, canvas, square_size, x, y):
    self.floor.draw(canvas, square_size, x, y)
    
    if not self.is_destroyed:
      super().draw(canvas, square_size, x, y)
