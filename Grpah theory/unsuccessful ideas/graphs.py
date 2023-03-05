# Draw every possible rooted tree

import sys
import re
import networkx as nx
import matplotlib.pyplot as plt

DEFAULT_VERTICES = 6
with_labels = False

def format_vertex(v, n): return(f"{v}->{n}")
def get_from_vertex(v,n): return int(re.findall(r'\d+',v)[n])

def get_total_vertices():
  number_of_total_vertices = None

  if len(sys.argv) == 1: return DEFAULT_VERTICES

  try:
    number_of_total_vertices = int(sys.argv[1])
  except:
    print("Please enter a valid number")
    return None

  if (number_of_total_vertices < 3 or number_of_total_vertices > 26):
    print("Number has to be above 2 or below 27")
    return None
  else:
    return number_of_total_vertices

class Graph:
  def __init__(self, n):
    self.n = n
    self.edges = []
    self.vertices = [v for v in range(n)]
    self.base_edges = []
    self.extra_edges = []
    self.base_vertices = []
    self.extra_vertices = []
    self.total_trees = 0

  def add_tree(self):
    new_edges = self.base_edges + self.extra_edges
    renamed_edges = [[format_vertex(v, self.total_trees) for v in edge] for edge in new_edges] # seperate tree from graph (make it unique)
    self.extra_edges = []
    self.edges += renamed_edges
    self.total_trees += 1
  
  def expand_tree(self, edges_map):
    for vertex_map in edges_map:
      v = format_vertex(vertex_map["vertex"], vertex_map["depth"] + 1)
      self.add_edge(self.base_vertices[vertex_map["depth"]], v)

  def add_edge(self, v1, v2):
    self.extra_edges.append([v1,v2])

  def set_base(self, depth_level):
    self.base_vertices = [format_vertex(self.vertices[0], 0)]
    self.base_edges = []
    for n in range(1, depth_level + 1):
      self.base_edges.append([format_vertex(self.vertices[n - 1], n-1), format_vertex(self.vertices[n], n)])
      self.base_vertices.append(format_vertex(self.vertices[n], n))
  
    self.extra_vertices = self.vertices[len(self.base_vertices):]
  
  def visualize(self):
    G = nx.Graph()
    G.add_edges_from(self.edges)
    node_color = []
    positions = {}
		
    current_tree = [] # the tree, part of which is the current vertex in the loop 
    # color the root
    vertices = list(G.nodes())
    for i in range(len(vertices)):
      v = vertices[i]
      if v.startswith("0"): 
        # to distinguish the root
        node_color.append("blue")
        current_tree = vertices[i:i + self.n]
      else: node_color.append("green")

      vertex_index = get_from_vertex(v, 0)
      depth_level = get_from_vertex(v, 1)
      tree_number = get_from_vertex(v, 2)
      # ex: {vertex_index}->{depth_level}->{tree_number}
      same_depth_level_vertices = len(list(filter(lambda vertex: get_from_vertex(vertex, 1) == depth_level, current_tree))) - 1
      # amount of vertices with the same depth

      tree_offset = tree_number * self.n
      # so that trees are not overlapping
      vertex_offset = (self.n + depth_level - 1)/2 - vertex_index if same_depth_level_vertices > 0 else 0 
      # so that vertices are not overlapping

      positions[v] = [tree_offset + vertex_offset, depth_level]
      #     offset:               x               ,   y                                                                                        y

    nx.draw_networkx(G, positions, node_color=node_color, with_labels=with_labels)
      
    try:
      plt.show()
    except KeyboardInterrupt:
      print("\n")


def get_graphs():
  # get the number of vertices (run script with the number as an argument, ex: python {file}.py 4)
  n = get_total_vertices()
  if n == None: return

  graph = Graph(n)
  a = 1

  # to ensure all possible trees are displayed they are divided accroding to their depth
  # first are build all the trees with level of depth 1, then 2 , 3..., (n - 1).
  for depth_level in range(1, n):
    print(f"depth_level: {depth_level}")

    graph.set_base(depth_level)
    # 1) start from a *base 
    # * consequently connected vertices as follows: 1) v1 - indeg(0), outdeg(1)
    #                                                  v(2...d-2) - indeg(1), outdeg(1) or deg(1)
    #                                                  v(d-1) - indeg(1), outdeg(0)
    # where d is the depth level
    # the base tree has a depth of d - 1
    # all other vertices determine the different trees

    extra_vertices_count = len(graph.extra_vertices)

    if extra_vertices_count == 0:
      graph.add_tree()
      continue
      # this is the full base tree and has no extra edges (depth of base tree = depth of tree)

    extra_vertices_map = [{"vertex": v, "depth": depth_level - 1} for v in graph.extra_vertices]
    graph.expand_tree(extra_vertices_map)
    graph.add_tree()


    for base_vertex_depth, base_vertex in enumerate(graph.base_vertices):

      max_extra_vertices_depth = min(depth_level - base_vertex_depth, extra_vertices_count)
      for branch_max_depth in range(1, max_extra_vertices_depth + 1):
        # at leeast one branch must have this depth and no branches can have a bigger depth
        print(f"  {base_vertex}, {branch_max_depth}, {extra_vertices_count}")
        
        total_branches_count = int(extra_vertices_count / branch_max_depth) + extra_vertices_count % branch_max_depth

        for branch_count in range(0, min(base_vertex_depth + 1, extra_vertices_count) ):
          print(f"    {branch_count}")
          a += 1


    continue

    # 2) go through every possible branch depth - a branch is a tree with one of the base vertices as a root (base tree excluded)
    # a branch can not have a depth too big or that will change the overal depth
    # therefore a tree of depth d cannot have a branch with depth d + 1 with root a, a branch of depth d + 2 with root b...

    max_branch_depth = min(extra_vertices_count, depth_level)
    print(f"max_branch_depth: {max_branch_depth}, extra_vertices_count: {extra_vertices_count}")
    for branches_max_depth in range(1, max_branch_depth + 1):
      print(f"  branches_max_depth: {branches_max_depth}")
      # 3) the amount of branches is determined using the left vertices and branch depth
      total_branches_count = int(extra_vertices_count / branches_max_depth) + extra_vertices_count % branches_max_depth
      print(f"  total_branches_count: {total_branches_count}")

      for branch_i in range(1, total_branches_count + 1):
        print(f"    branch_i: {branch_i}")
        for base_vertex in graph.base_vertices[0:-1]:
          print(f"      base_vertex: {base_vertex}")
          for extra_vertex in graph.extra_vertices:
            print
            # print(f"        extra_vertex: {extra_vertex}")
  
    # graph.add_tree()

  print(f"total trees: {graph.total_trees}, {a}")
  graph.visualize()

get_graphs()