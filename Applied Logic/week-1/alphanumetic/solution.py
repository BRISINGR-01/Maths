import os 

def solve(lines):
  if len(lines) < 3:
    print("You need at least 3 lines (2 summed and 1 result)")
    return
  
  output = ""
  firstLetters = []
  allLetters = []

  for line in lines:
    for letter in line:
      if letter not in allLetters:
        allLetters += letter
        output += f"(declare-const {letter} Int)\n"

  for line in lines:
    if line[0] not in firstLetters:
      firstLetters.append(line[0])
      output += f"\n(assert (distinct 0 {line[0]}))"
  
  output += "\n"

  for letter in allLetters:
    output += f"\n(assert (and ({'<' if letter in firstLetters else '<='} 0 {letter}) (> 10 {letter})))"

  output += f"""

(assert (distinct {' '.join(allLetters)}))

(assert (= 
  (+ 
    {" ".join([combine_line(line) for line in lines[0:-1]])}
  )
  {combine_line(lines[-1])}
))
 
(check-sat)
(get-value ({' '.join(allLetters)}))
"""
  
  return output
  
def combine_line(line):
  if len(line) == 1: return line

  output = "(+ "
  for i, letter in enumerate(line[::-1]):
    output += letter if i == 0 else f" (* {letter} {10 ** i})"
  output += ")"

  return output
  

def save(content):
  file = open(os.path.join(os.path.dirname(os.path.realpath(__file__)), "output.z3"), 'w')
  file.write(content)
  file.close()

save(
  solve(["AS", "I", "WAS", "WITH", "MOSES"])
  #solve(["CORAL", "CYAN", "MAROON", "NAVY", "SALMON", "COLORS"])
)
