---
title: "A Path Towards Autonomous Machine Intelligence (LeCun 2022)"
type: paper
tags: [world-models, JEPA, energy-based-models, self-supervised-learning, hierarchical-planning, cognitive-architecture]
created: 2026-06-23
updated: 2026-06-23
sources: [A Path Towards Autonomous Machine Intelligence]
related: [wiki/entities/jepa-model.md, wiki/concepts/energy-based-models.md, wiki/concepts/world-models.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/predictive-coding.md, wiki/concepts/working-memory.md, wiki/concepts/cognitive-control.md, wiki/concepts/abstract-reasoning.md, wiki/entities/prefrontal-cortex.md]
---

# A Path Towards Autonomous Machine Intelligence (LeCun 2022)

**Yann LeCun. Position paper, v0.9.2, 2022-06-27. Meta / NYU.**

---

## Five Key Computational Insights

- **JEPA: predict representations, not pixels.** A Joint Embedding Predictive Architecture maps both x and y through separate encoders (producing s_x, s_y), then predicts ŝ_y = Pred(s_x, z). Energy = D(s_y, ŝ_y). The encoder discards unpredictable details; the latent variable z captures residual uncertainty. Avoids blurriness that plagues generative world models.

- **Non-contrastive SSL for JEPAs.** VICReg / Barlow Twins prevent representation collapse without contrastive samples by jointly maximizing information content of s_x and s_y, minimizing prediction error, and minimizing information content of z. Avoids the curse of dimensionality that requires exponentially many contrastive samples in high-dimensional spaces.

- **H-JEPA enables hierarchical planning.** Stacking JEPAs (JEPA-1: low-level short-term; JEPA-2: higher-level longer-term) produces a multi-scale world model. Top-level abstract goals become subgoal constraints for lower levels; the lower level infers actions satisfying each subgoal. Intermediate "actions" are conditions on lower-level states, not primitive motor commands.

- **Mode-2 = reasoning as energy minimization.** The actor proposes an action sequence; the world model simulates state trajectories; the cost sums energies. Gradient-based search (or MCTS for discrete spaces) finds the optimal sequence. Mode-2 results can be amortized into Mode-1 reactive policy modules (training policy to reproduce Mode-2 output), analogous to System 2 → System 1 skill compilation.

- **Configurator = single configurable world model engine.** One world model, dynamically primed for each task by the configurator module, enables knowledge sharing across tasks and reasoning by analogy. Hypothesized to map to the PFC-mediated executive control system. The configurator's mechanism for decomposing complex tasks into subgoal sequences is explicitly identified as an open problem.

---

## Limitations

- Position paper with no empirical results; all architectural proposals are conceptual.
- Configurator subgoal decomposition mechanism is unspecified — the hardest and most architecturally important gap.
- How to discover the intermediate action vocabulary at each H-JEPA level is pre-specified, not learned.
- Fully differentiable architecture assumes smooth well-behaved cost landscapes; discrete action spaces require gradient-free search (MCTS, DP), whose computational cost grows exponentially with horizon.
- The claim that "reward is not enough" and "scaling is not enough" is argued via analogy; no direct counter-experiments provided.

---

## Links

- [[wiki/entities/jepa-model.md]] — JEPA/H-JEPA architecture
- [[wiki/concepts/energy-based-models.md]] — EBM framework; training strategies
- [[wiki/concepts/world-models.md]] — world models as the substrate for planning
- [[wiki/concepts/hierarchical-representations.md]] — H-JEPA as multi-level world model
- [[wiki/concepts/predictive-coding.md]] — JEPA is aligned with PC's prediction objective but non-generative
- [[wiki/concepts/working-memory.md]] — short-term memory module ≈ hippocampus
- [[wiki/concepts/cognitive-control.md]] — configurator ≈ PFC executive control
- [[wiki/concepts/abstract-reasoning.md]] — Mode-2 as energy-minimization reasoning; intrinsic motivation for goal inference
- [[wiki/entities/prefrontal-cortex.md]] — world model + configurator map to PFC subregions
