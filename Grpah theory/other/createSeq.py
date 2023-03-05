n = 6
seq = []

base = list(range(2, n))
base.reverse()

for numOfConseqVertices in range(1, n - 2):
  for iter in range(1 if numOfConseqVertices == 1 else len(base) - (numOfConseqVertices - 1)):
    start = int(iter - numOfConseqVertices / 2)
    end = int(iter + numOfConseqVertices / 2)
    s = base[:start] + [base[start + 1] for _ in range(numOfConseqVertices - 1)] + base[end:]
    seq.append(s)
    

print(seq)