from v1 import sort as v1
from v2 import sort as v2
from metrics import Metrics
from utilities import  generateShuffled

arr = [-4, -5, 36, 0, 858, -9, -3, 31, 2]

def sort(S):
  v2(S)

sort(arr)

Metrics.compare()
Metrics.save()