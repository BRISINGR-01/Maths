from utilities import find_max, reverse
from metrics import Metrics

def sort(S):
  Metrics.iterate_element()

  for curr in range(len(S) - 1, 0, -1):
    Metrics.iterate_element()

    maxI = find_max(S, 0, curr)
    
    Metrics.make_comparisson()
    if maxI == curr: 
      continue

    reverse(S, maxI)
    reverse(S, curr)
  
  return S