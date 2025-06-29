LEARN = False
# LEARN = True

DEBUG = not LEARN
RENDER = not LEARN
RENDER = False
DEBUG = False
SAVE_Q_TABLE = LEARN
LEARNING_RATE = 0.1 if LEARN else 0
INITIAL_EPSILON = 1.0 if LEARN else 0

DEBUG_UPDATE = 100


N_EPISODES = 15_000
MAX_STEPS_PER_EPISODE = 100
FINAL_EPSILON = 0.1
EPSILON_DECAY = (INITIAL_EPSILON - FINAL_EPSILON) / (N_EPISODES * 0.8)
DISCOUNT_FACTOR = 0.95

FILE_NAME = "q_table.npy"
