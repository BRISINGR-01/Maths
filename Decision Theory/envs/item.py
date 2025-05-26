from envs.tile import Tile
from envs.constants import Items, FloorType
from sprites import sprite_map

class Item(Tile):
  def __init__(self, type: Items, floor: FloorType):
    super().__init__(False, True)
    match type:
      case Items.WINDOW:
        self.image = sprite_map["window"]
      case Items.RADIO:
        self.image = sprite_map["radio"]
      case Items.BOOKSHELF_EMPTY:
        self.image = sprite_map["bookshelf"]["empty"]
      case Items.BOOKSHELF_FULL:
        self.image = sprite_map["bookshelf"]["full"]
      case Items.TABLE:
        self.image = sprite_map["table"]
      case Items.CHAIR:
        self.image = sprite_map["chair"]["empty"]
      case Items.CHAIR_BLUE:
        self.image = sprite_map["chair"]["blue"]
      case Items.CHAIR_PURPLE:
        self.image = sprite_map["chair"]["purple"]
      case Items.CHAIR_RED:
        self.image = sprite_map["chair"]["red"]
      case Items.OVEN:
        self.image = sprite_map["oven"]
      case Items.TOILET:
        self.image = sprite_map["toilet"]
      case Items.POT:
        self.image = sprite_map["pot"]
      case Items.CHEST:
        self.image = sprite_map["chest"]
      case Items.STOOL:
        self.image = sprite_map["stool"]
      case Items.BED:
        self.image = sprite_map["bed"]
      case Items.NIGHTSTAND:
        self.image = sprite_map["nightstand"]
      case Items.DOOR:
        self.image = sprite_map["door"]
      case Items.TRAPDOOR:
        self.image = sprite_map["trapdoor"]["closed"]
      case Items.TRAPDOOR_OPEN:
        self.image = sprite_map["trapdoor"]["open"]
      case Items.BIN:
        self.image = sprite_map["bin"]
      case Items.MODERN_BIN:
        self.image = sprite_map["modern-bin"]
      case Items.PICTURE:
        self.image = sprite_map["picture"]