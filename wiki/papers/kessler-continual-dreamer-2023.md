---
title: "The Effectiveness of World Models for Continual Reinforcement Learning"
type: paper
tags: [continual-learning, world-models, experience-replay, reinforcement-learning, catastrophic-forgetting]
created: 2026-06-24
updated: 2026-06-24
sources: [continual-reinforcement-learning]
related: [wiki/concepts/continual-learning.md, wiki/concepts/world-models.md, wiki/concepts/replay.md]
---

# The Effectiveness of World Models for Continual Reinforcement Learning

Kessler, Ostaszewski, Bortkiewicz, Zarski, Wołczyk, Parker-Holder, Roberts, Miłos. _Proceedings of the 2nd Conference on Lifelong Learning Agents (CoLLAs), 2023._

---

- **World model isolation prevents task interference:** DreamerV2's RSSM trains the policy in imagination using frozen world model weights; only the experience replay buffer persists across tasks, not gradient flows — eliminating direct parameter interference between sequential task objectives.
- **Reservoir sampling dominates replay strategies:** Maintains a uniform distribution over all past task experience by accepting episode $t$ with probability $\min(n/t, 1)$ where $n$ is buffer capacity. Outperforms coverage maximization (convolutional-LSTM distance-based) and 50:50 (recent-biased) strategies across 4- and 8-task Minihack sequences.
- **Buffer size quantifies the stability-plasticity tradeoff:** Larger replay buffers reduce forgetting but prevent learning of hard exploration tasks (HideNSeek-v0 unsolvable with large buffer). First empirical quantification of the buffer-size axis of this tradeoff in model-based CRL.
- **Plan2Explore enables task-agnostic exploration:** Intrinsic reward $r_i$ from latent-state disagreement across an ensemble of predictors provides exploration without task-specific hyperparameters; combined as $r = \alpha_i r_i + \alpha_e r_e$.
- **Interference failure mode isolates the reward-change case:** When reward functions change across tasks within the same environment (FourRooms-v0), past replay data actively degrades learning — the buffer cannot distinguish same-observation/different-reward tuples. Workaround requires task-specific output heads, breaking task-agnosticity.

**Limitations:** tested only on procedurally generated gridworld environments (Minigrid, Minihack) with disjoint state spaces between tasks; interference failure mode unresolved; task data imbalance (unequal interaction budgets) degrades selective replay methods.

**Links:** [[wiki/concepts/continual-learning.md]] · [[wiki/concepts/world-models.md]] · [[wiki/concepts/replay.md]]
