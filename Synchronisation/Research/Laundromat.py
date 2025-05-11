from Environment import *
from Environment import _blk
import random, Environment as env, importlib, time

# ---------- Constants ----------

N = 4
STUDENTS = 10
CHANCE_OF_RESTING = 0.7

# ---------- Counters ----------

washing_machine_count = N
dryer_count = N
people_resting = 0

# ---------- Semaphores & Mutexes ----------

class Barrier:
    def __init__(self):
        self.mutex = MySemaphore(1, "barrier mutex")
        self.count = 0
        self.turnstile = MySemaphore(0, "turnstile")
        
    def wait(self):
        self.mutex.wait()
        self.count += 1
        if self.count == STUDENTS:
            self.turnstile.signal(STUDENTS)
            self.count = 0
        self.mutex.signal()

        self.turnstile.wait()

barrier = Barrier()
mutex = MySemaphore(1, "mutex")
keys = MySemaphore(N, "keys")
washing_machine = MySemaphore(washing_machine_count, "washing_machines")
dryer = MySemaphore(dryer_count, "dryers")

# ---------- Utils ----------

def exit():
    keys.signal()
    print("Exiting laundromat")
    keys.wait()

def get_name():
    global student_n

    mutex.wait()
    student_n += 1
    mutex.release()

    return "Student " + str(student_n)

def wash():
    time.sleep(0.1)

def dry():
    time.sleep(0.1)

def decide_to_exit(probability=0.5):
    return random.random() < probability

def try_to_exit(name: str):
    global people_resting
    print(name + " wants to rest")

    mutex.wait()
    if people_resting < N - 1:
        people_resting += 1
        mutex.signal()

        print(name + " exited the laundromat")
        exit()
        print(name + " returned to the laundromat")

        mutex.wait()
        people_resting -= 1
    mutex.signal()

# ---------- Threads ----------

student_n = 0
def student_thread():
    name = get_name()
    print(name + " has started")

    while True:
        print(name + " is waiting")
        barrier.wait()
        keys.wait()
        print(name + " has entered the laundromat and is waiting for a washing machine") 
        washing_machine.wait()
        print(name + " has started a washing machine")
        
        if decide_to_exit(CHANCE_OF_RESTING):
           try_to_exit(name)
        wash()

        washing_machine.signal()
        print(name + " has finished a washing machine and is waiting for a dryer")
        dryer.wait()

        if decide_to_exit(CHANCE_OF_RESTING):
           try_to_exit(name)
        dry()

        dryer.signal()
        keys.signal()
        print(name + " has finished a dryer and left the laundromat")


# ---------- Set up ----------

def createThreads(numberOfThreads, threadFunction):
    for _ in range(numberOfThreads):
        subscribe_thread(threadFunction)

def setup():
    createThreads(STUDENTS, student_thread)

if __name__ == '__main__':
    importlib.import_module("Laundromat").setup()
    env.GuiCreate("Laundromat.py")
    env.GuiMainloop()
