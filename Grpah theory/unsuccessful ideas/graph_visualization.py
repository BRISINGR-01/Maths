# First networkx library is imported
# along with matplotlib
import networkx as nx
import matplotlib.pyplot as plt

# def get_connected_graph(edges, startingPoint = None):
# 	if startingPoint == None: startingPoint = edges[0]

# 	used = [e for e in edges]

# 	def connect_vertices(v):
# 		connected_edges = []
# 		for i in range(len(edges_left)):
# 			if (v in edges_left[i]):
# 				connected_edges.append(edges_left[i])
# 				edges_left.remove(i)

# 		if len(connected_edges) == 0: return v

# 		for edge in connected_edges:
# 			other_vertex = [vertex for vertex in edge if vertex != v][0]
# 			graph[v][other_vertex] = connect_vertices(other_vertex, edges, graph)

# 	graph = {
# 		startingPoint: connect_vertices(startingPoint)
# 	}


# 	return graph



def get_connected_vertices(v, edges):
	vertices = []
	for edge in edges:
		if v in edge:
			vertices.append(edge[1 - edge.index(v)])

	return [e for e in set(vertices)]
# Defining a Class
class Graph:

	def __init__(self, edges, vertices):
		self.edges = edges
		self.vertices = vertices

	def addEdge(self, a, b):
		self.edges.append([a, b])
	
	def visualize(self):
		G = nx.Graph()
		G.add_edges_from(self.edges)
		
		nx.draw_networkx(G)
		plt.show()

	def DFS(self, startingPoint = None):
		if startingPoint == None:
			startingPoint = self.vertices[0]
		if startingPoint not in self.vertices:
			print(str(startingPoint) + " is not a vertex")
			return

		# self.visualize()
		# connectedGraph = get_connected_graph(self.edges)
		# print(connectedGraph)
		used_edges = [startingPoint]
		stack = get_connected_vertices(startingPoint,self.edges)


		def alg(used_edges,stack):
			print(str(used_edges) + " | " + str(stack))
			used_edges.append(stack.pop())

			for v in stack:
				for vertex in get_connected_vertices(v,self.edges):
					if vertex not in stack:
						stack.append(vertex)

			if len(stack) != 0: alg(used_edges,stack)
		alg([startingPoint], get_connected_vertices(startingPoint,self.edges))
		print(used_edges,stack)







G = Graph([["a","b"],["a","c"],["a","d"],["b","e"],["f","b"],["g","b"],["h","c"],["i","d"],["j","d"],["k","j"],["l","j"]],["a","b","c","d","e","f","g","h","i","j","k","l"])
G.DFS()
