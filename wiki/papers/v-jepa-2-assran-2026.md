---
title: "V-JEPA 2: Self-Supervised Video Models Enable Understanding, Prediction and Planning"
type: paper
tags: [jepa, world-models, self-supervised-learning, video-understanding, robot-planning, model-predictive-control]
created: 2026-06-23
updated: 2026-06-23
sources: [V-JEPA 2 Self-Supervised Video Models Enable Understanding, Prediction and Planning]
related: [wiki/entities/jepa-model.md, wiki/entities/vl-jepa-model.md, wiki/concepts/world-models.md, wiki/concepts/energy-based-models.md, wiki/concepts/hierarchical-representations.md]
---

# V-JEPA 2: Self-Supervised Video Models Enable Understanding, Prediction and Planning

**Assran et al. (Meta FAIR + Mila), 2026. [Code](https://github.com/facebookresearch/vjepa2)**

---

## Key Computational Insights

- **Two-stage decoupling (observation → action):** Stage 1 pre-trains V-JEPA 2 on 1M+ hours of unlabeled internet video — no actions, no reward — using mask-denoising in representation space. Stage 2 freezes the encoder and trains a 300M-parameter action-conditioned predictor (V-JEPA 2-AC) on only 62 hours of unlabeled robot data. V-JEPA 2-AC then zero-shot generalizes to new labs, new objects, and new arrangements. The decoupling shows that physical world dynamics can be learned from pure observation and that action grounding requires only a small amount of additional data.

- **Representation-space MPC:** V-JEPA 2-AC plans by minimizing `||P(â_{1:T}; s_k, z_k) − z_goal||₁` via the Cross-Entropy Method (CEM): sample action candidates, keep top-k, refine Gaussian parameters, repeat. Energy landscape is empirically smooth and locally convex. Planning time: 16 sec/action with 800 samples vs. 4 min/action for pixel-space Cosmos (latent diffusion-7B) with 80 samples — V-JEPA 2-AC achieves 65–80% pick-and-place success vs. 0% for Cosmos, demonstrating that planning in abstract representation space is dramatically more tractable than planning in pixel space.

- **Block-causal autoregressive predictor with 3D-RoPE:** V-JEPA 2-AC uses block-causal attention so each spatial patch at time t attends to all patches, action, and end-effector state at t and prior steps. 3D-RoPE (separate rotary embeddings for temporal/height/width axes) provides stable relative positional encoding at scale. Training loss = teacher-forcing loss + 2-step rollout loss; the rollout loss specifically reduces error accumulation during inference.

- **Language-supervised encoders are unnecessary for temporal understanding:** In a controlled comparison (same LLM, same data, frozen encoder), V-JEPA 2 outperforms SigLIP2, PE_core G, and DINOv2 on temporal understanding tasks (MVP, TemporalBench, TVBench) without any language supervision during pre-training. Validates the "world model first, language alignment second" paradigm — contradicts the conventional assumption that language supervision is required for competitive video encoders.

- **Progressive resolution training enables 8.4× speedup:** Train at 16 frames / 256² resolution during the warmup and constant phases; increase to 64 frames / 384² only during the short cooldown phase. This yields the same performance as training at full resolution throughout while requiring 8.4× less GPU time for the ViT-g model. Combined model+data+schedule scaling (ViT-L baseline → VM22M → ViT-g → 252K steps → 384 resolution) yields cumulative +4.0 pts across 6 tasks.

---

## Limitations

- Long-horizon planning fails: autoregressive error accumulation degrades prediction quality with rollout length; exponential action-space growth with planning horizon T makes multi-step planning computationally intractable for non-greedy tasks without sub-goal specification.
- Camera sensitivity: inferred action coordinate axis is a near-linear function of camera angle relative to robot base; requires manual camera positioning and has no explicit camera calibration.
- Image goals only: V-JEPA 2-AC requires a goal image; language goal specification is an open extension.
- Tested only on tabletop manipulation with Franka Panda arms; generalization to dexterous manipulation or mobile robotics is untested.

---

## Links

- **[[wiki/entities/jepa-model.md]]** — V-JEPA 2 is the direct scaling of I-JEPA to video (1M hours, 1B params); V-JEPA 2-AC is the first operational version of H-JEPA's Mode-2 planning loop.
- **[[wiki/entities/vl-jepa-model.md]]** — VL-JEPA (Chen et al. 2025) uses V-JEPA 2 ViT-L as its frozen visual encoder; the two papers form a stack (V-JEPA 2 world model → VL-JEPA language alignment).
- **[[wiki/concepts/world-models.md]]** — V-JEPA 2-AC is the most complete existing instantiation of Mode-2 planning: learned latent world model + CEM action search + receding-horizon control.
- **[[wiki/concepts/energy-based-models.md]]** — planning is energy minimization `E(a_{1:T}) = ||P(a_{1:T}; z_k) − z_goal||₁` over the learned EBM landscape.
- **[[wiki/concepts/hierarchical-representations.md]]** — future work explicitly proposes hierarchical multi-scale predictors operating at different levels of abstraction, connecting to H-JEPA and the multi-level meta-graph Gap 2.
