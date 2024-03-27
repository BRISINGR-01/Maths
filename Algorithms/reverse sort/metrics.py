import json, random

data = {
  "max_calls": 0,
  "reverse_calls": 0,
  "elements_iterated": 0,
  "comparisons": 0,
  "math_operations": 0,
  "elements_reversed": 0
}


class Metrics:
  def call_max():
    data["max_calls"] += 1
  def call_reverse():
    data["reverse_calls"] += 1
  def iterate_element():
    data["elements_iterated"] += 1
  def make_comparisson():
    data["comparisons"] += 1
  def make_math_operation(n = 1):
    data["math_operations"] += n
  def reverse_elements():
    data["elements_reversed"] += 1
  
  def save():
    with open('data.json', 'w') as json_file:
      json.dump(data, json_file)

  def compare():
    with open('data.json', 'r') as json_file:
      prev = json.load(json_file)
      print("new", data)
      print("prev", prev)
      print("difference in elements_iterated: ", data["elements_iterated"] - prev["elements_iterated"] )
      print("difference in max_calls: ", data["max_calls"] - prev["max_calls"] )
      print("difference in reverse_calls: ", data["reverse_calls"] - prev["reverse_calls"] )
      print("difference in elements_reversed: ", data["elements_reversed"] - prev["elements_reversed"] )
      print("difference in comparisons: ", data["comparisons"] - prev["comparisons"] )
      print("difference in math_operations: ", data["math_operations"] - prev["math_operations"] )

  def test(arr):
    for i in range(1, len(arr)):
      if arr[i] < arr[i - 1]: 
        raise Exception("Not sorted!")

  