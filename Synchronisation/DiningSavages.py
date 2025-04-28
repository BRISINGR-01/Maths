import threading
import queue

MEALS = [
    "Spaghetti Bolognese", "Chicken Tikka Masala", "Beef Stroganoff",
    "Pad Thai","Sushi", "Lasagna", "Tacos al Pastor",
    "Chicken Alfredo", "Bibimbap", "Margherita Pizza", "Ratatouille",
    "Fish and Chips", "Shakshuka", "Falafel Wrap", "Greek Moussaka",
    "Lamb Rogan Josh", "Pho", "Chili Con Carne", "Butter Chicken", "Teriyaki Salmon"
]

class Pot:
  def __init__(self):
    self._meals = queue.Queue()
    # self.fill()
  
  def is_empty(self):
    return self._meals.empty()
  
  def fill(self):
    for meal in MEALS:
      self._meals.put(meal)
  
  def get_serving(self):
    return self._meals.get()

class Savage:
  def __init__(self, is_chief, name):
    self.is_chief = is_chief
    self.name = name
  

pot = Pot()
potFull = threading.Semaphore(0)
potEmpty = threading.Semaphore(0)
mutex = threading.Semaphore(1)

def eat(meal, savage):
  print(savage.name + f" is eating {meal}")

def savage_thread(savage: Savage):
  global pot

  while True:
    print(savage.name + " is waiting")
    mutex.acquire()

    if pot.is_empty():
      print("Empty pot")
      mutex.release()

      if savage.is_chief:
        print("Chief requests food")
        potEmpty.release()
        print("Chief waits for the cook")
        potFull.acquire()
        potFull.release()
      else:
        potFull.acquire()
        potFull.release()
      
      
      
      print(savage.name + " gets food")
      meal = pot.get_serving()
      mutex.release()

      eat(meal, savage)
      continue

    mutex.release()




def cook_thread():
  global pot

  while True:
    print("Cook is waiting")
    potEmpty.acquire()
    pot.fill()
    print("Cook refilled the pot")
    potFull.release()

threading.Thread(target=savage_thread, args=(Savage(True, "Chief"),)).start()
for i in range(5):
  threading.Thread(target=savage_thread, args=(Savage(False, f"Savage {i}"),)).start()

threading.Thread(target=cook_thread, args=()).start()