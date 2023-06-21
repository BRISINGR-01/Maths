import os 

def solve(n, equations):
  content = ""
  return content
  

def save(content):
  file = open(os.path.join(os.path.dirname(os.path.realpath(__file__)), "output.z3"), 'w')
  file.write(content)
  file.close()
