from enum import Enum

PADDING = 2

class FloorColor(Enum):
  RED = 0
  BLUE = 1
  PURPLE = 2

class Side(Enum):
  TOP = 0
  RIGHT = 1
  BOTTOM = 2
  LEFT = 3
  
class FloorPosition(Enum):
  TOP_LEFT = 0
  TOP_CENTER = 1
  TOP_RIGHT = 2
  MIDDLE_LEFT = 3
  MIDDLE_CENTER = 4
  MIDDLE_RIGHT = 5
  BOTTOM_LEFT = 6
  BOTTOM_CENTER = 7
  BOTTOM_RIGHT = 8
  
class FloorType(Enum):
  TILE = 0
  RED = 1
  BLUE = 2
  PURPLE = 3

class Items(Enum):
    WINDOW = 0
    RADIO = 1
    BOOKSHELF_EMPTY = 2
    BOOKSHELF_FULL = 3
    TABLE = 4
    TABLE_SMALL = 5
    CHAIR = 6
    CHAIR_RED = 7
    CHAIR_BLUE = 8
    CHAIR_PURPLE = 9 
    OVEN = 10
    TOILET = 11
    POT = 12
    CHEST = 13
    STOOL = 14
    BED = 15
    NIGHTSTAND = 16
    DOOR = 17
    TRAPDOOR = 18
    TRAPDOOR_OPEN = 19
    BIN = 20
    MODERN_BIN = 21
    PICTURE = 22

class Pots(Enum):
    EMPTY = 0
    GREEN = 1
    PINK = 2
    RED = 3

class Chairs(Enum):
    EMPTY = 0
    RED = 1
    BLUE = 2
    PURPLE = 3
 