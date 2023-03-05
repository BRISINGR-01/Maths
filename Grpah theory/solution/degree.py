import sys
from drawing import draw_grph
from drawing import graph_from_degrees
from generate_trees import generate_all_trees
from removeDuplicates import remove_duplicate_trees

n = None
try:
  n = int(sys.argv[1])
except:
  n = 5

for degrees in remove_duplicate_trees(generate_all_trees(n)):
  print(degrees)
  # uncomment to see a display of each graph
  # draw_grph(graph_from_degrees(degrees))
