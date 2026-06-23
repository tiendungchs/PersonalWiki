---
title: "World Models"
type: concept
tags: [world-models, predictive-models, model-based-rl, planning, simulation, abstract-reasoning, self-supervised-learning]
created: 2026-06-23
updated: 2026-06-23
sources: [A Path Towards Autonomous Machine Intelligence, Vision-Language-Action Models for Robotics A Review Towards Real-World Applications, V-JEPA 2 Self-Supervised Video Models Enable Understanding, Prediction and Planning, LeWorldModel Stable End-to-End Joint-Embedding Predictive Architecture from Pixels, "Critical review of LeCun's Introductory JEPA paper"]
related: [wiki/entities/jepa-model.md, wiki/concepts/energy-based-models.md, wiki/concepts/predictive-coding.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/abstract-reasoning.md, wiki/entities/tem-model.md, wiki/entities/ltc-model.md, wiki/entities/dnc-model.md, wiki/papers/lecun-path-towards-autonomous-intelligence-2022.md, wiki/papers/vla-survey-kawaharazuka-2025.md, wiki/papers/v-jepa-2-assran-2026.md, wiki/papers/leworldmodel-maes-2026.md, wiki/papers/lecun-jepa-critical-review-lett-2025.md]
---

# World Models

**A world model is a learned internal representation of how the world works — capable of predicting future states from current state and action, representing uncertainty over possible futures, and enabling planning and counterfactual reasoning without costly real-world interaction.**

Craik (1943) first proposed that the brain builds small-scale models of reality; the ML formalization is in model-predictive control (MPC), and recent work places world model learning as the core of grounded intelligence.

---

## Why World Models Matter for Abstract Reasoning

| Without world model | With world model |
|---|---|
| Must trial-and-error in the real world | Can simulate in imagination |
| Sample-inefficient (thousands of trials) | Few-shot (simulate and plan) |
| Cannot reason counterfactually | Can answer "what if" queries |
| Cannot transfer goals | Same model, new objective |
| Common sense = none | Common sense = collection of world models |

**LeCun's argument:** most knowledge about the world is learnable from observation (SSL), not from rewards. Reward is too sparse and expensive; the world model carries most of the agent's knowledge.

---

## Required Properties

| Property | Why needed | Architectural solution |
|---|---|---|
| **Multi-modal uncertainty** | World is partially observable and stochastic | Latent variable z in LVEBM; stochastic RSSM in DreamerV2 |
| **Hierarchical / multi-timescale** | Short and long-horizon planning require different abstraction levels | H-JEPA; temporal pooling between levels |
| **Configurable** | Task-relevant aspects differ by task | Configurator module modulating world model parameters |
| **Representation-space prediction** | Cannot predict every unpredictable pixel | JEPA: predict s_y, not y; encoder discards irrelevant details |
| **Differentiable** | Gradient-based action optimization (Mode-2) | All modules differentiable; discrete cases handled by MCTS/DP |

---

## Generative vs. Representation-Space Prediction

A central architectural choice:

| Approach | Predicts | Problem | Example |
|---|---|---|---|
| **Generative** | Raw y (pixel, token, voxel) | Blurry (mode averaging) or implausible (mode collapse) for high-dim continuous signals | VAE decoder, video prediction nets |
| **Representation-space (JEPA)** | Abstract encoding s_y | Must prevent collapse; cannot reconstruct y | JEPA, CPC, token prediction in LLMs |

LeCun's claim: generative world models are fundamentally limited for continuous high-dimensional inputs because representing uncertainty over all of y is intractable. Predicting in representation space allows the encoder to discard unpredictable details while preserving task-relevant structure.

---

## Instantiations

| System | World model | Prediction space | Uncertainty | Generalization |
|---|---|---|---|---|
| **H-JEPA (LeCun 2022)** | Hierarchical non-generative | Representation s_y | Latent z + regularizer | Abstract encoder |
| **I-JEPA (Assran et al. 2023)** | Non-hierarchical, image SSL | Representation s_y | EMA target encoder | ImageNet (no augmentations) |
| **VL-JEPA (Chen et al. 2025)** | Non-generative, vision-language | Text embedding SY | InfoNCE + bidirectional | Multi-task (gen/retrieval/class) |
| **TEM (Whittington 2020)** | Factorized W-transitions | Structural code g | Hebbian M per-environment | Slow-W cross-environment |
| **DreamerV2/V3** | RSSM | Categorical latent | Recurrent belief state | None |
| **MPC (classical control)** | Physics simulator | State space | MC rollouts | Domain-specific |
| **Active inference (FEP)** | Generative model p(o,z) | Observation space | Posterior q(z|o) | Hierarchical priors |
| **LLMs** | Next-token prediction | Discrete token space | Softmax over vocabulary | Language statistics only |
| **VLA world models (UniPi, GR-1)** | Video diffusion / joint video+action prediction | Pixel / representation space | Diffusion / VAE | Embodiment-specific; no structural W |
| **LAPA** | World model on (frame_t, frame_{t+H}) pairs | Representation-space difference | VQ-VAE discrete codebook | Embodiment-agnostic via latent action tokens |
| **V-JEPA 2-AC (Assran et al. 2026)** | Action-conditioned next-frame repr. prediction | Representation s_y | Block-causal transformer | Zero-shot new environments from 62h data |
| **LeWM (Maes et al. 2026)** | End-to-end JEPA world model from pixels | Representation z_t | SIGReg N(0,I) prior | 2D/3D manipulation tasks; 15M params single GPU |

**LLMs as shallow world models:** LLMs extract statistical patterns from text but have no grounded world model — the "world" they model is human language about the world, not the world itself. This is why common sense based on physical interaction is absent (LeCun 2022 §8.2.2). VL-JEPA-SFT (1.6B) outperforms GPT-4o (52%), Claude-3.5 (53.3%), and Gemini-2.0 (55.6%) on WorldPrediction-WM (65.7%) by matching state-change embeddings to action embeddings without generating a single token — direct empirical support for the representation-space claim.

---

## Mode-2 Planning via World Model

```
Repeat until convergence:
  1. Actor proposes action sequence (a_0, ..., a_T)
  2. World model simulates: s_{t+1} = Pred(s_t, a_t)
  3. Cost evaluates: F = Σ_t C(s_t)
  4. Actor updates action sequence to minimize F
     (gradient-based if differentiable; MCTS/DP if discrete)
Output: first action a_0 → execute; repeat from new state
```

This is classical Model-Predictive Control (MPC) with a learned world model and cost. Differentiability of world model + cost enables end-to-end gradient-based planning.

**Mode-2 is not System II thinking (Lett 2025):** The MPC loop above has a *learned* world model and cost, but a *hard-wired* search algorithm (CEM, gradient descent, beam search, MCTS). The same algorithm given the same world model always produces the same plan — the process is "stochastically deterministic." True System II thought, in Kahneman's framing, requires that the reasoning/search/planning algorithm itself be *learned*. This is a deeper open problem than the configurator subgoal gap (Gap 3C): it demands a meta-level control architecture that can adapt how it reasons, not just what it knows. Any such architecture needs a stabilization mechanism (analogous to meta-management or consciousness) to remain coherent when all three components — world model, cost function, and control algorithm — are simultaneously plastic.

**V-JEPA 2-AC as concrete Mode-2 instantiation (2026):** the first validated real-robot implementation. Energy function: `E(â_{1:T}) = ||P(â_{1:T}; s_k, z_k) − z_goal||₁`. Optimization: Cross-Entropy Method (non-gradient, sample-based). The energy landscape is empirically smooth and locally convex around the optimal action, making CEM tractable. Planning speed: 16 sec/action (800 samples) vs. 4 min/action for pixel-space Cosmos (80 samples). Pick-and-place success: 65–80% (V-JEPA 2-AC) vs. 0% (Cosmos) — direct empirical comparison showing that latent-space world models dramatically outperform generative pixel-space models for planning.

---

## Connection to Neuroscience

LeCun maps the architecture modules to brain regions:
- World model module → prefrontal cortex (prediction, reward estimation)
- Short-term memory → hippocampus (state storage and retrieval)
- Cost / intrinsic energy → amygdala / basal ganglia (reward, pain)
- Configurator → PFC executive control (task-specific modulation)

The hypothesis of a **single configurable world model engine** in PFC explains:
1. Humans can only focus on one complex reasoning task at a time
2. Knowledge transfers across tasks via the shared world model
3. Reasoning by analogy = applying the same model in a new context

---

## Evaluating World Model Quality: VoE Framework

The violation-of-expectation (VoE) paradigm (from developmental psychology) tests a world model by measuring prediction surprise on physically plausible vs. implausible events. LeWM (Maes et al. 2026) applies this: model surprise = MSE between predicted and actual next embedding.

| Perturbation type | LeWM response | Interpretation |
|---|---|---|
| Object teleportation (physics violation) | Significant surprise spike (p<0.01) | Latent space encodes physical continuity |
| Object color change (visual perturbation) | No significant increase | Encoder discards appearance details |

This asymmetry confirms that representation-space world models naturally encode physical/relational structure over visual appearance — a desirable property for abstract reasoning where structure matters and surface form does not.

**Temporal Straightening (LeWM emergent property):** Over training, consecutive latent velocity vectors become increasingly collinear — trajectories approach straight lines in embedding space. Metric: mean cosine similarity of consecutive `(z_{t+1}−z_t)` vectors. This emerges without explicit regularization and benefits planning (straight trajectories enable efficient linear interpolation for CEM). Connected to neuroscience temporal straightening hypothesis (Hénaff et al. 2019: biological visual systems straighten natural video trajectories in representation space).

---

## Open Problems

- **Long-horizon planning:** autoregressive error accumulation degrades prediction quality with rollout length; exponential search space growth (k^T action trajectories) makes multi-step CEM intractable. V-JEPA 2-AC requires sub-goal images to decompose pick-and-place — compositional sub-goal inference remains open.
- **Abstract goal specification:** V-JEPA 2-AC requires an image goal; language goal specification requires grounding the world model into natural language (open extension).
- **Hierarchical world models:** operating at different abstraction/timescale levels would address both long-horizon planning and the vocabulary co-discovery problem; explicitly proposed as future work by Assran et al. 2026. Directly maps to H-JEPA and Gap 2 (multi-level meta-graph).
- **Temporal straightening in abstract spaces:** LeWM shows latent trajectories become straight in physical pixel domains. Does this property emerge for abstract reasoning tasks (ARC-AGI grid transformations)? Straight trajectories would dramatically simplify planning in abstract rule spaces.
- **VoE as abstract reasoning evaluator:** if a world model trained on abstract transformations assigns higher surprise to logically impossible rule applications, VoE becomes a zero-shot test of whether the world model has internalized the rules.
- Whether a single configurable world model can generalize across all task types or requires task-specific modules
- Task decomposition into subgoals by the configurator — explicitly left open by LeCun 2022

---

## Connections

- **[[wiki/entities/jepa-model.md]]** — JEPA/H-JEPA is the proposed architecture for representation-space world models; avoids generative blurriness by predicting in abstract encoding space.
- **[[wiki/entities/vl-jepa-model.md]]** — VL-JEPA is the first multimodal JEPA that achieves SoTA world modeling (WorldPrediction-WM 65.7%) by treating world-state transitions as embedding-matching problems rather than token-generation problems; provides the strongest empirical evidence to date that representation-space prediction is superior to token generation for world modeling.
- **[[wiki/concepts/energy-based-models.md]]** — world model planning is EBM inference: the differentiable cost + differentiable world model form a joint EBM over action sequences; planning = energy minimization.
- **[[wiki/concepts/predictive-coding.md]]** — FEP's generative model p(o,z) is a probabilistic world model; active inference (action as F-minimization) is the FEP analog of Mode-2 planning; the JEPA approach is aligned in spirit but non-generative.
- **[[wiki/concepts/hierarchical-representations.md]]** — H-JEPA instantiates hierarchical world models at multiple timescales; each level operates at a different resolution/abstraction in service of multi-horizon planning.
- **[[wiki/concepts/abstract-reasoning.md]]** — world models are the substrate for model-based reasoning (counterfactual, causal, goal-flexible); LLMs' lack of grounded world models is the mechanistic explanation for their shallow common sense; autonomous goal inference (ARC-AGI-3) additionally requires inferring the objective itself from the world model.
- **[[wiki/entities/tem-model.md]]** — TEM's W-parameterized g-transitions are a factorized world model for structured environments; structural generalization = cross-environment transfer of the world model's structural component W.
- **[[wiki/entities/ltc-model.md]]** — LTC's continuous-time ODE dynamics implement a continuous causal world model structurally equivalent to Friston's bilinear DCMs; both are differentiable temporal world models suitable for gradient-based control.
- **[[wiki/entities/dnc-model.md]]** — DNC's external memory + world model emulation (Mini-SHRDLU graph traversal) shows that explicit read-write memory is required when the world model must track entities across long horizons.
- **[[wiki/papers/lecun-path-towards-autonomous-intelligence-2022.md]]** — primary source for this page; LeCun's position paper is the most systematic recent treatment of world models as the core of intelligent behavior.
- **[[wiki/papers/assran-ijepa-2023.md]]** — empirical proof of concept: I-JEPA learns semantic image representations purely from representation-space prediction, validating the core architectural claim of the world models page.
- **[[wiki/papers/vla-survey-kawaharazuka-2025.md]]** — VLA survey documents embodied instantiations of world model–guided planning: UniPi (video→IDM), GR-1 (joint action+video), LAPA (latent action codebook via VQ-VAE on frame differences); LAPA in particular shows that a discrete action vocabulary can be co-discovered with world model training — a partial solution to the vocabulary co-discovery problem.
- **[[wiki/papers/v-jepa-2-assran-2026.md]]** — V-JEPA 2-AC is the most complete existing instantiation of Mode-2 planning: frozen representation-space encoder pre-trained on 1M+ hours of internet video + 62h action-conditioned fine-tuning + CEM planning + receding-horizon control; achieves zero-shot pick-and-place on real robots.
- **[[wiki/papers/leworldmodel-maes-2026.md]]** — demonstrates that a 2-term loss (MSE + SIGReg) is sufficient for stable end-to-end JEPA world model training from raw pixels; introduces temporal straightening as an emergent evaluation axis and VoE (violation-of-expectation) as a criterion for physical understanding in latent space.
- **[[wiki/papers/lecun-jepa-critical-review-lett-2025.md]]** — argues that Mode-2 (MPC with learned world model + hard-wired search) is System I, not System II; identifies learning the search/planning algorithm itself as the genuine System II gap; notes that simultaneous plasticity of world model + cost + control algorithm requires a stabilizing meta-management architecture.
