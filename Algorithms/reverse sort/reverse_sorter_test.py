import unittest, random, sys, time, psutil, tracemalloc

from reverse_sorter import sort, max
from utilities import generateShuffled
from metrics import Metrics

lists = [
  [],
  [5],
  [7, 2],
  [x for x in range(0, 100)],
  [x for x in range(100, 0 -1)],
]

for l in [10, 100, 1000, 10000]:
  lists.append(generateShuffled(l))



for i in range(0, len(lists)):
  arr = lists[i]
  sort(arr)
  Metrics.test(arr)
