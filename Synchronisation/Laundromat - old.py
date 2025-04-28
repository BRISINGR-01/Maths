from Environment import *
from Environment import _blk
import random

n = 4
washing_machine_count = n
dryer_count = n-1
keys = MySemaphore(n)
mutex = MyMutex()

washing_machine = MySemaphore(washing_machine_count)
dryer = MySemaphore(dryer_count)

class RestingPeopleHolder:
    def __init__(self):
        self.val = 0
        self.mutex = MyMutex()
        
    def read(self):
        self.mutex.wait()
        val = self.val
        self.mutex.signal()
        return val
    
    def increment(self):
        self.mutex.wait()
        self.val += 1
        self.mutex.signal()

    def decrement(self):
        self.mutex.wait()
        self.val -= 1
        self.mutex.signal()


def acquire():
    washing_machine.wait()
    dryer.wait()
    print("Acquired washing machine and dryer")


def release():
    washing_machine.signal()
    dryer.signal()
    print("Released washing machine and dryer")


def decide_to_exit(probability=0.5):
    return random.random() < probability

def exit():
    keys.signal()
    print("Exiting laundromat")
    keys.wait()

# def repairMan():
#    while True:

people_resting_while_drying = RestingPeopleHolder()
people_resting_while_washing = RestingPeopleHolder()

def student():
    while True:
        keys.wait()
        washing_machine.wait()
        if decide_to_exit(0.7):  # 70% chance to proceed
            if people_resting_while_washing < n - 1:
                people_resting_while_washing
                exit()
                people_resting_while_washing

        washing_machine.signal()
        dryer.wait()

        if decide_to_exit(0.7):  # 70% chance to proceed
            if people_resting_while_drying < n - 1:
                people_resting_while_drying
                exit()
                people_resting_while_drying

        dryer.signal()
        keys.signal()


def createThreads(numberOfThreads, threadFunction):
    for _ in range(numberOfThreads):
        subscribe_thread(threadFunction)


def setup():
    createThreads(10, student)
