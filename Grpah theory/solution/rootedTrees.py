import sys
from drawing import draw_graph
from drawing import graph_from_degrees
from generate_trees import generate_all_trees
from removeDuplicates import remove_duplicate_trees

n = None
show = False
try:
  n = int(sys.argv[1])
except ValueError:
  n = 5
try:
  show = sys.argv[2] == "-v"
except IndexError:
  show = False

trees = remove_duplicate_trees(generate_all_trees(n))
graphs = []
for degrees in trees:
  print(degrees)
  if show:
    draw_graph(graph_from_degrees(degrees))


