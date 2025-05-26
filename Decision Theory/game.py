
import gymnasium as gym
from envs.grid_world import GridWorldEnv
import gymnasium.envs.registration


gymnasium.envs.registration.register(
    id="GridWorld-v0",
    entry_point="envs:GridWorldEnv",
)


env = gym.make('GridWorld-v0', size=5, render_mode="human")

env.reset(seed=42)



for _ in range(1000):
    # this is where you would insert your policy
    action = env.action_space.sample()

    # step (transition) through the environment with the action
    # receiving the next observation, reward and if the episode has terminated or truncated
    observation, reward, terminated, truncated, info = env.step(action)

    # If the episode has ended then we can reset to start a new episode
    if terminated or truncated:
        observation, info = env.reset()

env.close()
