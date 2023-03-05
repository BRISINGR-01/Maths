def sorter(branch):
  if type(branch) == int:
    return 0  
  elif all(map(lambda el: type(el) == int, branch)):
    return len(branch)
  else:
    return len(branch) * 2

def get_branches(checked_tree):
  tree = checked_tree.copy()
  branches = []

  depth = 0
  for branch_index, amount_of_branches in enumerate(tree):
    if amount_of_branches < 2: 
      branches.append(amount_of_branches)
      if amount_of_branches == 0:
        return branches
    else:
      last_leaf_index = branch_index
      for branch in range(amount_of_branches):
        depth = 1
        beginning = last_leaf_index + 1
        for i, deg in enumerate(tree[beginning:]):
          if deg == 0: 
            depth -= 1
            if depth == 0:
              last_leaf_index = i + beginning
              break
          else: depth += deg - 1

        branches.append(get_branches(tree[beginning: last_leaf_index + 1]))
      
      return sorted(branches, key=sorter)

def remove_duplicate_trees(trees):
  unique_branches = []

  def check_for_duplicate(checked_tree):
    tree_branches = get_branches(checked_tree)

    if tree_branches not in unique_branches:
      unique_branches.append(tree_branches)
      return True
    return False

  return list(filter(check_for_duplicate, trees))
