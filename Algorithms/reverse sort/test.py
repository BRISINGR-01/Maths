import timeit
from utilities import reverse, generateShuffled
from v1 import sort as v1
from v2 import sort as v2

arr = generateShuffled(1000)
def test():
  v1(arr)
print(timeit.timeit(test, number=10) / 10)

# for input in sys.stdin:
#   if input == "r\n":
#     arr = arr_original.copy()
#   else:
#     reverse(arr, int(input))
  
#   print(" " + ", ".join([" " * (len(str(arr[i])) -1) + "{0}".format(i) for i in range(0, len(arr))]))
#   print(arr)
    

