def check_tree(tree, n):
  if tree[0] == 0: return False # first vertex must have branches
  if len(tree) == n:
    if sum(tree) + 1 != n: return False # degrees must add up
    if tree[-1] != 0: return False # last vertex must be a leaf
    
    sum_of_degrees = 0
    for i, degree in enumerate(tree[:-1]):
      if i == 0: sum_of_degrees = degree
      else:
        if degree == 0: sum_of_degrees -= 1
        else: sum_of_degrees += degree - 1

        if sum_of_degrees <= 0: 
          return False

  for i, degree in enumerate(tree):
    if degree == 0: continue
    if degree < tree[i+1:i+2+degree].count(0): 
      return False
    
  return True

def generate(nr_of_vertices, tree):
  if nr_of_vertices == len(tree): return tree
  
  new_trees = []
  for v in range(0, nr_of_vertices - sum(tree) + 1):
    new_trees.append(tree + [v])

  return [generate(nr_of_vertices, tree) for tree in new_trees if check_tree(tree, nr_of_vertices)]

def flatten(parent_list):
  if type(parent_list) is list:
    return [child for child_list in parent_list for child in flatten(child_list)] 
  else: 
    return [parent_list]
 
def generate_all_trees(n):
  all_trees = []
  raw_trees = flatten(generate(n, []))
  for begin_index in range(0, len(raw_trees), n):
    all_trees.append(raw_trees[begin_index:begin_index+n])
  
  return all_trees