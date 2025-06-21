import os
import matplotlib.pyplot as plt
import gymnasium as gym
import numpy as np
from q_learning.agent import QLearningAgent
from q_learning.constants import RENDER, MAX_STEPS_PER_EPISODE
from envs.constants import config
from envs.ui.sprites import load_srpite_map
from mdp import FireEvacuationAgentMDP


def create_env():
    gym.envs.registration.register(
        id="FireFighterWorld",
        entry_point="envs:FireFighterWorld",
    )

    env = gym.make("FireFighterWorld", render_mode="human" if RENDER else "rgb_array")
    env.reset(seed=42, options={"preset_fire_positions": [(3, 2)]})

    return env


class Metrics:

    def __init__(self, name):
        self.rewards = 0
        self.illegal_moves = 0
        self.steps = 0
        self.episodes = []
        self.name = name

    def log(self, reward, is_legal_move):
        self.steps += 1
        self.rewards += reward
        if not is_legal_move:
            self.illegal_moves += 1

    def save(self, is_successful):
        self.episodes.append(
            {
                "steps": self.steps,
                "rewards": self.rewards,
                "illegal_moves": self.illegal_moves,
                "is_successful": is_successful,
            }
        )

        self.clear()

    def clear(self):
        self.rewards = 0
        self.steps = 0
        self.illegal_moves = 0
        self.is_successful = False


config.static_fire_mode = True
# config.random_target_location = False

load_srpite_map()


unavailable = [
    (0, 2),
    (1, 2),
    (1, 3),
    (2, 3),
    (3, 3),
    (3, 0),
    (3, 1),
    (0, 3),
    (1, 0),
    (2, 0),
]

unavailable += config.fires

env = create_env()
q_metrics = Metrics("q_metrics")
mdp_metrics = Metrics("mdp_metrics")


def test_q(env, target_pos, agent_pos, q_learning_agent):
    observation, info = env.reset(
        options={
            "initial_agent_pos": agent_pos,
            "initial_target_pos": target_pos,
            "preset_fire_mode": True,
        }
    )

    for _ in range(MAX_STEPS_PER_EPISODE):
        action = q_learning_agent.get_action(env.action_space, observation)

        next_observation, reward, terminated, _, info = env.step(action)

        q_metrics.log(reward, info["is_legal_move"])

        q_learning_agent.update(
            observation, action, reward, terminated, next_observation
        )
        observation = next_observation

        if terminated:
            return info["is_agent_dead"]

    return True


def test_mdp(env, target_pos, agent_pos, mdp_agent):
    agent_current_pos = agent_pos
    target_current_pos = target_pos

    env.reset(
        options={
            "initial_agent_pos": agent_pos,
            "initial_target_pos": target_pos,
            "preset_fire_mode": True,
        }
    )

    step_count = 0
    while step_count < MAX_STEPS_PER_EPISODE:
        step_count += 1

        # Get the optimal action from the pre-computed MDP policy
        optimal_action = mdp_agent.get_optimal_action(
            agent_current_pos, target_current_pos
        )

        next_observation, reward, terminated, truncated, next_info = env.step(
            optimal_action.value
        )

        mdp_metrics.log(reward, next_info["is_legal_move"])

        agent_current_pos = next_observation[0]
        target_current_pos = next_observation[1]

        if terminated or truncated:
            return next_info["is_agent_dead"]

    return True


def show():
    ep_nr = len(q_metrics.episodes)
    fig, axs = plt.subplots(2, 2, figsize=(10, 10))

    q_rewards = [ep["rewards"] for ep in q_metrics.episodes]
    mdp_rewards = [ep["rewards"] for ep in mdp_metrics.episodes]
    episodes = list(range(ep_nr))

    axs[0, 0].plot(episodes, q_rewards, "b", label="Q-Learning")
    axs[0, 0].plot(episodes, mdp_rewards, "r", label="MDP")
    axs[0, 0].plot(episodes, q_rewards, "b", label="Q-Learning")

    axs[0, 0].set_title("Total Reward per Episode")
    axs[0, 0].set_title("Total Reward per Episode")
    axs[0, 0].set_xlabel("Episode")
    axs[0, 0].set_xlabel("Episode")
    axs[0, 0].set_ylabel("Reward")
    axs[0, 0].set_ylabel("Reward")
    axs[0, 0].legend()
    axs[0, 0].legend()

    q_steps = [ep["steps"] for ep in q_metrics.episodes]
    mdp_steps = [ep["steps"] for ep in mdp_metrics.episodes]
    axs[1, 1].plot(episodes, q_steps, "b", label="Q-Learning")
    axs[1, 1].plot(episodes, mdp_steps, "r", label="MDP")

    axs[1, 1].set_title("Steps per Episode")
    axs[1, 1].set_title("Steps per Episode")
    axs[1, 1].set_xlabel("Episode")
    axs[1, 1].set_xlabel("Episode")
    axs[1, 1].set_ylabel("Steps")
    axs[1, 1].set_ylabel("Steps")

    q_illegal_moves = [ep["illegal_moves"] for ep in q_metrics.episodes]
    mdp_illegal_moves = [ep["illegal_moves"] for ep in mdp_metrics.episodes]
    axs[0, 1].plot(episodes, q_illegal_moves, "b", label="Q-Learning")
    axs[0, 1].plot(episodes, mdp_illegal_moves, "r", label="MDP")

    axs[0, 1].set_title("Illegal Moves per Episode")
    axs[0, 1].set_title("Illegal Moves per Episode")
    axs[0, 1].set_xlabel("Episode")
    axs[0, 1].set_xlabel("Episode")
    axs[0, 1].set_ylabel("Illegal Moves")
    axs[0, 1].set_ylabel("Illegal Moves")

    plt.legend()
    plt.show()
    plt.savefig(f"metrics/comparison.png")
    plt.close()


def run(q_learning_agent, mdp_agent):
    env.reset()

    for ax in range(config.grid_size):
        for ay in range(config.grid_size):
            if any((ax, ay) == pos for pos in unavailable):
                continue

            for tx in range(config.grid_size):
                for ty in range(config.grid_size):
                    if (tx == ax and ty == ay) or any(
                        (tx, ty) == pos for pos in unavailable
                    ):
                        continue

                    q_metrics.save(test_q(env, (tx, ty), (ax, ay), q_learning_agent))
                    mdp_metrics.save(test_mdp(env, (tx, ty), (ax, ay), mdp_agent))

    env.close()
    np.save("./episodes.npy", [q_metrics.episodes, mdp_metrics.episodes])

    show()


if __name__ == "__main__":
    if False and os.path.exists("./episodes.npy"):
        data = np.load("./episodes.npy", allow_pickle=True)
        q_metrics.episodes = data[0]
        mdp_metrics.episodes = data[1]

        show()
        exit(0)
    try:
        run(QLearningAgent(seed=42), FireEvacuationAgentMDP(seed=42))
    except KeyboardInterrupt:

        pass
