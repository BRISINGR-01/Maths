import networkx as nx
import matplotlib.pyplot as plt
import string
import random

def draw(G):
  nx.draw_networkx(G)
  plt.show()

def create_random_graph(n = None) -> nx.Graph:
  if n == None: return nx.random_tree(15)
  
  vertices = string.ascii_uppercase[0:n]

  starting_point = vertices[0]

  G = nx.Graph()
  randomized = []
  for i in range(0, 2*len(vertices)):
    randomized.append(random.choice(vertices))


  for i, v in enumerate(randomized):
    if i != 0 and v != randomized[i-1]: G.add_edge(v, randomized[i-1])

  return G

IS_DFS = True

G = create_random_graph(8)
vertices = list(G.nodes)

current_vertex = vertices[0]

stack = [current_vertex]
chosen_verticies = []

while len(chosen_verticies) != len(vertices):
  current_vertex = stack.pop(-1 if IS_DFS else 0)
  chosen_verticies.append(current_vertex)
  stack += [key for key in G.adj[current_vertex] if key not in stack and not key in chosen_verticies]

d = G.degree[current_vertex]

print(list(stack))

draw(G)