import sys

sys.path.append('.') 
from utilities import find_max, reverse, max
from metrics import Metrics


def sort(S):
  nextMaxRight = -1
  nextMax = -1

  curr = len(S)
  while(curr >= 0):
    curr -= 1
    Metrics.iterate_element()

    Metrics.make_comparisson()
    if nextMax != -1:
      maxI = nextMax
      nextMax = -1
    else:
      maxI = find_max(S, 0, curr)
    
    Metrics.make_comparisson()
    if maxI == curr: 
      continue

    shouldSkip = False

    Metrics.make_comparisson()
    if maxI != 0:
      Metrics.make_comparisson()
      if nextMaxRight != -1:
        maxIR = nextMaxRight
        nextMaxRight = -1
      else:
        Metrics.make_math_operation()
        maxIR = find_max(S, maxI + 1, curr)

      Metrics.make_math_operation(2)
      maxIL = find_max(S, 0, maxI - 1)
      nextMax = curr - maxIR
      
      Metrics.make_comparisson()
      if max(S, maxIL, maxIR) == maxIL:
        Metrics.make_math_operation()
        Metrics.make_comparisson()
        if maxI - 1 != maxIL: # if they are together anyway skip
          reverse(S, maxIL)
          Metrics.make_math_operation()
          reverse(S, maxI - 1)
        shouldSkip = True
      else:
        nextMaxRight = curr - maxIL

      Metrics.make_comparisson()
    if maxI != 0: reverse(S, maxI)
    reverse(S, curr)

    if shouldSkip: 
      curr -= 1
  
  return S
