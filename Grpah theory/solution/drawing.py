import networkx as nx
import matplotlib.pyplot as plt

def draw_graph(graph):
  colours = ["lightblue" for _ in graph.nodes]
  colours[0] = "green" # root

  nx.draw_networkx(graph, node_color=colours)
  plt.show()

def graph_from_degrees(degrees):
  # a graph is created using an array of the degrees of the vertices (the degrees are -1, ex: [3,2,1,2,1] -> [2,1,0,1,0])
  if sum(degrees) >= len(degrees): raise Exception("Sum of degrees is too much")

  current_vertex = 0
  next_vertex = 0
  branch_points_stack = []
  i = 0
  tree = nx.Graph()

  while sum(degrees) != 0:
    if degrees[i] == 0: # leaf
      if degrees[i - 1] == 0:
        # [...,0,0...]
        #   i-1^ ^i
        i -= 1
        continue
      degrees[i - 1] -= 1
      degrees.pop(i)
      if i >= len(degrees):
        i = len(degrees) - 1
      if len(branch_points_stack) != 0:
        current_vertex = branch_points_stack.pop()
    else:
      other_vertex = next_vertex

      for deg in range(degrees[i]):
        other_vertex += 1
        tree.add_edge(current_vertex, other_vertex)
        if deg != degrees[i] - 1:
          branch_points_stack.append(other_vertex)

      current_vertex = next_vertex = other_vertex 
      i += 1
    
  return tree
