---
title: "Spacetime Attractor (STA)"
type: entity
tags: [planning, prefrontal-cortex, attractor, world-models, RNN, working-memory, meta-learning]
created: 2026-06-28
updated: 2026-06-28
sources: [A mechanistic theory of planning in prefrontal cortex]
related: [wiki/concepts/planning-as-inference.md, wiki/entities/prefrontal-cortex.md, wiki/concepts/ring-attractor.md, wiki/concepts/world-models.md, wiki/concepts/successor-representation.md, wiki/concepts/working-memory.md, wiki/concepts/meta-learning.md, wiki/concepts/replay.md, wiki/concepts/prospective-coding.md, wiki/papers/mechanistic-planning-pfc-jensen-2026.md]
---

# Spacetime Attractor (STA)

A biologically inspired planning model for prefrontal cortex. Extends ring/grid attractor principles from encoding a single instantaneous state to encoding an entire future trajectory simultaneously.

Jensen et al. 2026 [[wiki/papers/mechanistic-planning-pfc-jensen-2026.md]].

---

## Architecture

| Component | Description |
|---|---|
| **Subspaces** | T neural populations, each encoding expected location δ = 0, 1, …, T−1 steps into the future |
| **Intra-subspace connectivity** | Winner-take-all: cells at same δ with different preferred locations inhibit each other |
| **Inter-subspace connectivity** | Cells at δ and δ+1 are excitatory if their preferred locations are adjacent in the environment; W_{δ,δ+1} ≈ adjacency matrix A_{ij} |
| **Current-location input** | Strong reward input to δ=0 anchors the current position |
| **Reward input** | Trial-specific R_{δ,i} biases each subspace toward high-value locations at that future time |
| **Nonlinearity** | Exponential activation + within-subspace L1 normalization; firing rate r_{δi} interpretable as distribution over future locations |

**Dynamics** (continuous-time):
```
τ dz_{δi}/dt = -z_{δi} + Σ_j A_{ij} r_{δ+1,j} + Σ_j A_{ji} r_{δ-1,j} - inhibition + R_{δi} + noise
r_{δi} = exp(z_{δi}) / Σ_j exp(z_{δj})
```
Fixed points represent entire reward-maximizing trajectories. The network relaxes to these from diffuse initial activity.

---

## Key Results

| Task | TD | SR | STA |
|---|---|---|---|
| Static goal (fixed) | ✓ | ✓ | ✓ |
| Static goal (trial-varying) | ✗ | ✓ | ✓ |
| Moving goal (within-trial) | ✗ | ✗ | ✓ |
| Reward landscape (fully dynamic) | ✗ | ✗ | ✓ |

STA is the only algorithm that handles within-trial dynamic reward because it maintains a separate representation for each future timestep.

**RNN validation:** RNNs (N=800 hidden units, ReLU, regularized) meta-trained on the dynamic reward-landscape task learn:
- Explicit future representations with cross-trajectory generalization (conveyor belt decoding)
- Recurrent weights matching environment adjacency matrix (r = 0.91 ± 0.07)
- Attractor dynamics: small perturbations quenched; large perturbations trigger discrete path switches

**Efficiency tradeoff:** STA-like solution is general but expensive (many neurons/synapses). Simpler tasks allow cheaper alternatives; STA is selected under sufficient task complexity + regularization pressure.

---

## Conveyor Belt Dynamics

After computing a plan, behavior execution does not require replanning. As the agent takes each action:
1. δ=1 population reads out the next location → action selected
2. Activity shifts: former δ=k becomes δ=k−1 for all k
3. The trailing subspace (δ=T) absorbs new reward information

This "conveyor belt" was confirmed in El-Gaby et al. 2023 PFC recordings during sequence working memory: the same population code shifts systematically over time.

---

## Structural Generalization

In changing-structure environments, networks represent future **transitions** τ_{δ,i→j} rather than future locations. Wall inputs inhibit representations of unavailable transitions, effectively gating the learned adjacency scaffold to match the current environment. Three verified predictions:
1. Future transitions are explicitly represented
2. Consistent consecutive transitions are excitatory
3. Wall inputs specifically inhibit the corresponding future-transition representation

---

## Comparison to Related Models

| Feature | STA | SR (Stachenfeld 2017) | TEM (Whittington 2020) | H-JEPA (LeCun 2022) |
|---|---|---|---|---|
| World model location | Recurrent weights (W) | (I−γT)⁻¹ | Slow W | Predictor network params |
| Future representation | Explicit multi-step simultaneous | Collapsed over time | Single-step structural code g | Latent rollout |
| Dynamic rewards | Yes | No (time-averages) | No | Yes (if re-rolled) |
| Planning mechanism | Attractor inference | Dot product v=Sr | Predictive coding | CEM/gradient |
| Biological evidence | PFC subspace recording, conveyor belt | HC place/grid cells | MEC/HC recording | None |

---

## Limitations

- World model must be pre-learned (via HC replay or gradient descent offline); cannot plan in structurally novel environments
- Scales linearly in neurons with planning depth T (vs. exponential growth in sequential search, but still costly)
- Hierarchical extension (stacked STAs) handles this but requires learning appropriate abstractions — open problem
- All experiments on 4×4 grid mazes; abstract state spaces untested

---

## Connections

- **[[wiki/concepts/planning-as-inference.md]]** — STA is the canonical instantiation of planning as inference: attractor dynamics recognize the optimal trajectory rather than searching for it sequentially.
- **[[wiki/concepts/ring-attractor.md]]** — STA is the 3D generalization of ring/grid attractors: same "consistent states excite, inconsistent inhibit" principle extended to space × time; fixed points become full trajectories rather than single states.
- **[[wiki/entities/prefrontal-cortex.md]]** — STA provides the mechanistic circuit theory for PFC planning; the conveyor belt dynamics match El-Gaby et al. 2023 PFC sequence WM recordings; PFC is needed for dynamic-reward tasks exactly where STA outperforms TD and SR.
- **[[wiki/concepts/world-models.md]]** — STA embeds the world model directly in recurrent synaptic weights (A_{ij} between subspaces) rather than applying it sequentially; a fundamentally different instantiation of the world model concept that achieves parallel multi-trajectory evaluation.
- **[[wiki/concepts/successor-representation.md]]** — SR is the hippocampal algorithm that collapses the future into time-averaged occupancy; STA extends this by maintaining separate per-timestep representations; the three-algorithm taxonomy (TD/SR/STA) organizes when each is appropriate.
- **[[wiki/concepts/working-memory.md]]** — STA unifies sequence WM and planning: the same subspace representation that supports sequence WM is the scaffold on which planning operates; conveyor belt dynamics are the execution phase of the same representation.
- **[[wiki/concepts/meta-learning.md]]** — STA is the algorithm meta-trained RNNs discover when trained on dynamic planning tasks; extends Wang et al. 2018 meta-RL by specifying the mechanistic algorithm that emerges from PFC-like meta-training.
- **[[wiki/concepts/replay.md]]** — hippocampal replay is the proposed biological mechanism for learning the STA's world model: replay trajectories provide the (state, next-state) pairs needed to embed A_{ij} into inter-subspace connections.
- **[[wiki/concepts/prospective-coding.md]]** — STA provides the multi-step generalization of prospective coding: while HC CA1 represents one step ahead, PFC STA subspaces simultaneously represent the full planned trajectory T steps ahead.
- **[[wiki/papers/mechanistic-planning-pfc-jensen-2026.md]]** — primary source.
