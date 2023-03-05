#      a,b,c,d,e    a,b,c,d,e    a,b,c,d,e    a,b,c,d,e    a,b,c,d,e    a,b,c,d,e    a,b,c,d,e    a,b,c,d,e    a,b,c,d,e       
   
# e   [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  
# d   [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,1]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,1]  
# c   [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,0,0]  [0,0,0,1,0]  [0,0,0,1,0]  [0,0,0,1,1]  [0,0,0,1,0]  
# b   [0,0,0,0,0]  [0,0,1,0,0]  [0,0,1,0,0]  [0,0,1,1,0]  [0,0,1,1,1]  [0,0,1,0,0]  [0,0,1,0,1]  [0,0,1,0,0]  [0,0,1,0,0]  
# a   [0,1,1,1,1]  [0,1,0,1,1]  [0,1,0,1,0]  [0,1,0,0,1]  [0,1,0,0,0]  [0,1,0,0,1]  [0,1,0,0,0]  [0,1,0,0,0]  [0,1,0,0,0]

matrices = []
def check_matrix(matrix):
  global matrices
  def compare_matrices(m1, m2):
    if len(m1) != len(m2): return False

    for rowIndex, row1 in enumerate(m1):
      row2 = m2[rowIndex]
      if len(row1) != len(row2): return False
      for columnIndex, cell1 in enumerate(row1):
        if cell1 != row2[columnIndex]: return False

    return True

  for i, m in enumerate(matrices):
    if compare_matrices(m, matrix):
      print(f"Matrices {i} and {len(matrices)} are the same")

  matrices.append(matrix)
