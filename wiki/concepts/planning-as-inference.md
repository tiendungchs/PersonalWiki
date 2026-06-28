---
title: "Planning as Inference"
type: concept
tags: [planning, inference, attractor, prefrontal-cortex, world-models, abstract-reasoning]
created: 2026-06-28
updated: 2026-06-28
sources: [A mechanistic theory of planning in prefrontal cortex]
related: [wiki/entities/spacetime-attractor.md, wiki/entities/prefrontal-cortex.md, wiki/concepts/world-models.md, wiki/concepts/ring-attractor.md, wiki/concepts/successor-representation.md, wiki/concepts/working-memory.md, wiki/concepts/meta-learning.md, wiki/concepts/prospective-coding.md, wiki/concepts/latent-graph-discovery.md, wiki/papers/mechanistic-planning-pfc-jensen-2026.md]
---

# Planning as Inference

**Planning by recognition: the optimal action sequence is directly inferred from goal and current-state inputs via attractor dynamics, without simulating future states one at a time.**

Contrast: sequential search algorithms (MCTS, A\*, model-predictive rollout) apply a world model iteratively, evaluating one candidate trajectory at a time. Planning as inference applies the world model *structurally* — embedding it in connectivity — and evaluates all trajectories in parallel through relaxation dynamics.

---

## Formal Structure

Given:
- Current state s_0
- Goal/reward structure R_{δ,i} (reward at location i in δ steps)
- World model A_{ij} (can agent reach j from i in one step?)

**Sequential planning:** enumerate trajectories → evaluate → select best. Complexity O(|A|^T).

**Planning as inference:**
```
Embed A_{ij} in inter-subspace connections W_{δ,δ+1}
Set input R_{δi} per subspace
Relax: τ dz/dt = f(z, W, R)
Fixed point z* encodes the optimal trajectory
Read out: take action leading to argmax r_{1,i} reachable from s_0
```
Complexity: O(T · |S|) per relaxation step, independent of branching factor.

---

## Why Attractor Dynamics Implement Inference

Ring and grid attractors infer the *current* state from noisy inputs (heading, position). The same principle extends to inferring the *optimal future*:

| Circuit | Fixed points encode | Inputs select among fixed points |
|---|---|---|
| Ring attractor | Single heading angle | Visual + proprioceptive inputs |
| Grid attractor | Single 2D location | Velocity + landmark inputs |
| Spacetime attractor (STA) | Full future trajectory | Current location + reward structure |

The structural prior (world model) is embedded in connectivity in all three cases. Inference is the dynamics settling to the fixed point most consistent with inputs — not search.

---

## Relationship to the Planning Horizon Dilemma

Mode-2 planning (H-JEPA, DreamerV2) applies a learned world model iteratively, accumulating error at each rollout step. Planning as inference avoids this: the world model is embedded once in weights; relaxation dynamics simultaneously evaluate all future timesteps without autoregressive rollout error accumulation.

**Key tradeoff:**

| Approach | Error accumulation | Novel environments | Speed |
|---|---|---|---|
| Sequential rollout (MCTS/MPC) | Grows with T | Generalizes immediately | Slow (O(b^T) search) |
| Planning as inference (STA) | None at decision time | Requires prior W-learning | Fast (parallel relaxation) |
| Value function (TD/SR) | None | Requires retraining for dynamic rewards | Instant (dot product) |

Planning as inference is best for *familiar environments with dynamic rewards* — where structure is known but goals change rapidly.

---

## Coexistence with Sequential Search

Brain evidence suggests both mechanisms operate:
- **STA (PFC):** fast inference in familiar environments with embedded world model; biases which candidate trajectories are evaluated
- **Sequential search (HC preplay):** slow deliberation in novel or ambiguous environments; PFC may bias which HC sequences are replayed (Jensen et al. 2024)
- **Value functions (striatum/HC SR):** cached solutions for stable environments; zero compute at decision time

For reasoning models, the implication is a hybrid: use planning as inference (fast, low-cost) as the primary mechanism in domains with learned structure; fall back to sequential search when structure is uncertain.

---

## Connection to Latent Graph Discovery

Planning as inference presupposes that the latent graph (environment structure A) has been inferred and embedded in W. The inference and embedding step is itself a form of latent graph discovery — the STA assumes A is known, but learning A from experience is the upstream problem. HC replay provides the proposed biological solution; structurally, this maps to Block 3A (transformation inferrer) feeding Block 3C (hierarchical planner) in the reasoning model architecture.

---

## Open Problems

- **Abstract state spaces**: STA is validated on 4×4 spatial grids. Does planning as inference scale to abstract latent graphs (e.g., ARC-AGI rule spaces)? The key question is whether A_{ij} can encode symbolic transitions as well as spatial ones.
- **W-learning speed**: How many replay episodes are needed to accurately embed A in PFC connections? Is this sample-efficient enough for few-shot abstract rule learning?
- **Hierarchy**: Hierarchical STAs extend planning depth exponentially, but require learning abstractions that define the abstract state space. The abstraction-learning problem is unsolved.
- **Noise robustness**: The STA uses white noise to escape local minima; in abstract domains with many sub-optimal local minima, this may be insufficient.

---

## Connections

- **[[wiki/entities/spacetime-attractor.md]]** — the canonical neural-circuit instantiation of planning as inference; provides the full architecture and empirical validation.
- **[[wiki/entities/prefrontal-cortex.md]]** — PFC is the proposed biological substrate; conveyor belt dynamics in sequence WM recordings are consistent with STA fixed-point relaxation.
- **[[wiki/concepts/world-models.md]]** — planning as inference is a distinct world-model usage mode: the world model is embedded in recurrent weights at learning time and used implicitly at inference time, avoiding sequential rollout error accumulation.
- **[[wiki/concepts/ring-attractor.md]]** — ring/grid attractors are the 1D/2D precursors; planning as inference generalizes "consistent states excite, inconsistent inhibit" to spatiotemporal trajectories.
- **[[wiki/concepts/successor-representation.md]]** — SR is a special case of planning as inference where the future is collapsed into time-averaged occupancy; STA generalizes this to per-timestep representations.
- **[[wiki/concepts/working-memory.md]]** — the STA's simultaneous multi-step representation is the mechanistic bridge between sequence WM (hold a trajectory) and planning (infer an optimal trajectory); conveyor belt dynamics execute the plan without replanning.
- **[[wiki/concepts/meta-learning.md]]** — meta-trained RNNs discover planning as inference when trained on dynamic tasks; this establishes that the STA algorithm is the efficient solution the meta-learning objective converges to under task pressure.
- **[[wiki/concepts/prospective-coding.md]]** — prospective coding (HC one-step look-ahead) is the minimal version; planning as inference extends it to the full T-step trajectory via simultaneous multi-subspace representation.
- **[[wiki/concepts/latent-graph-discovery.md]]** — planning as inference presupposes that the latent graph has been discovered and embedded in W; the two-stage process (discover A, then plan via STA) directly addresses the core problem framing.
- **[[wiki/papers/mechanistic-planning-pfc-jensen-2026.md]]** — primary source.
