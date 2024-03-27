import math, sys, random

sys.path.append('.') 
from metrics import Metrics

def max(S, i, j):
  return i if S[i] > S[j] else j

# finds largest element in `S` from `i` to `j` (both including)
def find_max(S, i, j):
  Metrics.call_max()
  Metrics.make_math_operation(2)

  maxIndex = i

  for curr in range(i + 1, j + 1):
    Metrics.iterate_element()
    Metrics.make_comparisson()

    if max(S, curr, maxIndex) == curr:
      maxIndex = curr
  
  return maxIndex

def reverse_print(S, i):
  print(S, i)
  reverse(S, i)

# reverses the elements in `S` from the beggining to `i` (including)
def reverse(S, i):
  Metrics.call_reverse()
  Metrics.make_math_operation()

  middle = math.ceil(i / 2)
  end = i
  for curr in range(0, middle):
    Metrics.iterate_element()
    Metrics.reverse_elements()

    S[curr], S[end] = S[end], S[curr]
    end -= 1

def generateShuffled(n = 10):
  arr = []
  for _ in range(0, n):
    arr.append(random.randint(-n, n))

  return arr

