---
title: "LeWorldModel: Stable End-to-End Joint-Embedding Predictive Architecture from Pixels — Maes, Le Lidec, Scieur, LeCun & Balestriero 2026"
type: paper
tags: [jepa, world-models, representation-learning, self-supervised-learning, anti-collapse, planning, embodied-ai]
created: 2026-06-23
updated: 2026-06-23
sources: [LeWorldModel Stable End-to-End Joint-Embedding Predictive Architecture from Pixels]
related: [wiki/entities/jepa-model.md, wiki/concepts/world-models.md, wiki/concepts/energy-based-models.md, wiki/papers/lejepa-balestriero-lecun-2025.md, wiki/papers/v-jepa-2-assran-2026.md]
---

# LeWorldModel (LeWM) — Maes et al. 2026

Maes, Le Lidec, Scieur, LeCun & Balestriero. arXiv 2603.19312. Code: github.com/lucas-maes/le-wm

---

## Key Computational Insights

- **Two-term loss suffices for stable JEPA world model training.** `ℒ = ℒ_pred + λ·SIGReg(Z)` — MSE between predicted and actual next embedding, plus the Sketched Isotropic Gaussian Regularizer. No stop-gradient, no EMA, no pretrained encoders. Reduces tunable loss hyperparameters from 6 (PLDM/VICReg) to 1 (λ), enabling O(log n) bisection search vs. O(n⁶) grid search.
- **SIGReg applied step-wise prevents collapse provably.** Projects embeddings Z onto M=1024 random unit-norm directions; applies univariate Epps-Pulley characteristic-function test along each 1D projection; by Cramér-Wold theorem, matching all 1D marginals → matching full joint distribution → P_Z → N(0,I). Monotone convergence in practice; performance insensitive to M (leaves λ as only effective hyperparameter).
- **Latent space encodes physical structure, not visual appearance.** Linear probes recover agent/block position and velocity with r>0.97 (Push-T); t-SNE shows spatial structure preserved. Violation-of-expectation (VoE) tests: teleportation (physical violation) produces significant surprise spike (p<0.01); color change (visual perturbation) does not. The encoder abstracts away appearance in favor of dynamics.
- **Temporal straightening emerges spontaneously from SIGReg + prediction.** Cosine similarity between consecutive latent velocity vectors increases monotonically during training on Push-T — trajectories become approximately linear without any explicit temporal regularization. LeWM achieves higher temporal straightness than PLDM despite PLDM having an explicit temporal smoothness loss (ℒ_time-sim). Linked to the neuroscience temporal straightening hypothesis (Hénaff et al. 2019).
- **48× faster planning than foundation-model-based world models.** ViT-Tiny encoder (5M) + transformer predictor (10M) = 15M parameters total. Encoding observations with ~200× fewer tokens than DINO-WM (DINOv2 frozen ViT-L) enables planning in under 1 second while remaining competitive on Push-T (96% SR vs. DINO-WM 92%).

## Architecture

| Component | Config | Role |
|---|---|---|
| Encoder | ViT-Tiny, patch 14, 12L, 3 heads, d=192; [CLS]+BatchNorm MLP projector | Maps frame o_t → z_t |
| Predictor | ViT-S, 6L, 16 heads, 10% dropout; AdaLN action conditioning | Predicts ẑ_{t+1} from (z_t, a_t) |
| Anti-collapse | SIGReg on batch of z; M=1024 projections | Enforces z ~ N(0,I) |
| Planning | CEM: 300 candidates, 30 iters, horizon H=5, receding MPC | Goal-matching in latent space |

AdaLN initialization to zero ensures action conditioning activates progressively rather than destabilizing early training.

## Limitations

- Short planning horizons only (H=5 steps); long-horizon reasoning requires hierarchical world models.
- Image goals required; no language goal specification.
- SIGReg struggles in very low-dimensionality environments (TwoRoom): forcing high-dimensional N(0,I) prior when intrinsic dimensionality is low may prevent structured representation.
- Relies on offline datasets with sufficient behavioral coverage; low diversity weakens SIGReg.

## Connections

- **[[wiki/entities/jepa-model.md]]** — LeWM is the end-to-end world model instantiation of the JEPA principle, applying LeJEPA's SIGReg to pixel-input continuous control; directly extends the JEPA/LeJEPA line with a concrete empirical world model.
- **[[wiki/concepts/world-models.md]]** — adds to the JEPA instantiation family with VoE evaluation and temporal straightening as new evaluation/analysis dimensions.
- **[[wiki/papers/lejepa-balestriero-lecun-2025.md]]** — LeJEPA proved SIGReg's theoretical optimality; LeWM applies it to action-conditioned world model training, confirming the 1-hyperparameter simplification scales to sequential control.
- **[[wiki/papers/v-jepa-2-assran-2026.md]]** — V-JEPA 2-AC uses a frozen 1B-parameter encoder; LeWM trains end-to-end at 15M parameters — complementary points on the capacity/efficiency tradeoff for Mode-2 planning.
- **[[wiki/concepts/energy-based-models.md]]** — SIGReg is a principled non-contrastive alternative to VICReg's heuristic variance/covariance terms; LeWM shows it is sufficient for world model training as well as SSL pretraining.
