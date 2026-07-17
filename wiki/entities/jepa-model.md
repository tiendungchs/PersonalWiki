---
title: "JEPA / H-JEPA (Joint Embedding Predictive Architecture)"
type: entity
tags: [world-models, self-supervised-learning, energy-based-models, non-contrastive, hierarchical-planning, representation-learning]
created: 2026-06-23
updated: 2026-07-16
sources: [A Path Towards Autonomous Machine Intelligence, barlow_twins, jepa, V-JEPA 2 Self-Supervised Video Models Enable Understanding, Prediction and Planning, vicreg, LeJEPA, LeWorldModel Stable End-to-End Joint-Embedding Predictive Architecture from Pixels, HiT-JEPA A Hierarchical Self-supervised Trajectory Embedding Framework for Similarity Computation, "Critical review of LeCun's Introductory JEPA paper"]
related: [wiki/concepts/energy-based-models.md, wiki/concepts/world-models.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/predictive-coding.md, wiki/entities/tem-model.md, wiki/entities/vl-jepa-model.md, wiki/entities/dinov2-model.md, wiki/entities/dinov3-model.md, wiki/papers/lecun-path-towards-autonomous-intelligence-2022.md, wiki/papers/barlow-twins-zbontar-2021.md, wiki/papers/assran-ijepa-2023.md, wiki/papers/v-jepa-2-assran-2026.md, wiki/papers/vicreg-bardes-2022.md, wiki/papers/lejepa-balestriero-lecun-2025.md, wiki/papers/leworldmodel-maes-2026.md, wiki/papers/hit-jepa-li-2025.md, wiki/papers/dinov2-oquab-2023.md, wiki/papers/dinov3-simeoni-2025.md, wiki/papers/lecun-jepa-critical-review-lett-2025.md, wiki/queries/operator-collapse-in-fused-structural-codes.md]
---

# JEPA / H-JEPA

**Non-generative architecture for learning predictive world models by predicting representations of future states rather than future states themselves. Proposed by LeCun (2022) as the core of a cognitive architecture for autonomous intelligence.**

---

## Architecture

| Component | Role |
|---|---|
| x-encoder Enc_x(·) | Maps observed context x → representation s_x |
| y-encoder Enc_y(·) | Maps target y → representation s_y |
| Predictor Pred(s_x, z) | Predicts ŝ_y from s_x and optional latent z |
| Latent z | Parameterizes the *relationship* between x and y (not just the latent state of x); regularized to minimize information content |
| Energy | D(s_y, ŝ_y) — prediction error in representation space |

**Overall energy:** F_w(x, y) = min_z E_w(x, y, z) = min_z ||s_y − Pred(s_x, z)||²

**Multi-modality** — two sources of multi-modal uncertainty:
1. Encoder invariance: s_y = Enc_y(y) maps a set of y's to the same code → same energy for all of them
2. Latent variable: when z varies over set Z, Pred(s_x, Z) traces a set of plausible predictions in representation space

---

## JEPA as Contrastive Model (Lett 2025 critique)

JEPA is fundamentally a **siamese/contrastive architecture**: z represents the *relationship between x and y*, not the latent state of x alone. This has a critical operational consequence: in single-input settings (no y available), z is undefined and cannot be inferred from x alone.

Three deployment options for single-input settings:

| Option | Mechanism | Example |
|---|---|---|
| **Drop z** | Remove z term entirely; run as feedforward | Downstream linear probe |
| **Hand-craft z** | Give z an externally interpretable meaning | I-JEPA: z = spatial position of masked patch relative to context |
| **Marginalize over z** | Sample multiple z values; weight or select best | Uncertainty estimation; possible for generation |

**Contrast with Predictive Coding:** PC (Predictive Coding) operates on a *single* moment-to-moment observation and performs iterative recurrent inference — no second input required. JEPA requires (x, y) pairs to define z and perform its error computation; it cannot do the same online single-observation inference. JEPA is aligned with PC's goal (minimize prediction error in abstract space) but is architecturally a contrastive learner, not a recurrent inferencer.

**H-JEPA stacking does not map cleanly to PC (Predictive Coding) hierarchy:** In PC, each higher level provides top-down predictions (and receives bottom-up errors) from the level below. In H-JEPA, it is unclear how a higher-level JEPA provides z for the level below — the inter-level communication mechanism is not specified in the original design (see HiT-JEPA for one concrete implementation: top-down attention spotlight).

---

## I-JEPA Implementation (Assran et al. 2023)

The first concrete empirical instantiation, for images. Key engineering choices:

| Component | I-JEPA Choice | Why |
|---|---|---|
| Context encoder | ViT; processes only visible context patches | Efficiency — no wasted compute on masked patches |
| Target encoder | EMA (Exponential Moving Average) of context encoder (m=0.996→1.0) | Prevents collapse without contrastive samples or stop-gradient |
| Predictor | Narrow ViT (width 384, depth 6–16) | Bottleneck forces efficient context→target mapping; wider predictors hurt |
| Target masking | Mask OUTPUT of target-encoder, not input | Output masking produces richer semantic targets (67.3% vs. 56.1%) |
| Masking strategy | 4 target blocks (scale 0.15–0.2) + 1 large context (0.85–1.0) | Larger semantic targets → semantic features; small patches → texture only |

**Masking scale as abstraction dial:** 54.2% (multi-block) vs. 17.6% (random) vs. 20.2% (single block) vs. 15.5% (rasterized) on 1% ImageNet linear probe (ViT-B/16). The masking strategy is the primary lever controlling which level of abstraction the model learns — directly generalizable to H-JEPA multi-level design.

---

## Non-Contrastive Training (VICReg)

Four criteria to prevent collapse while pushing down prediction error (Bardes et al. 2022):

| Criterion | Effect |
|---|---|
| Maximize information in s_x | Prevents informational collapse of x-encoder |
| Maximize information in s_y | Prevents informational collapse of y-encoder |
| Minimize D(s_y, ŝ_y) | Forces world to be predictable in representation space |
| Minimize information in z | Prevents latent from "cheating" by carrying full information about y |

**Exact loss:** `ℓ(Z, Z') = λ·s(Z,Z') + µ[v(Z)+v(Z')] + ν[c(Z)+c(Z')]`
- `s` = MSE between embedding pairs (invariance; λ=µ=25, ν=1 in practice)
- `v(Z)` = mean hinge on per-dimension **std dev** above γ=1: `mean(max(0, γ − std(z^j)))`; using std dev not variance is critical — the gradient of the variance term → 0 at collapse, providing no corrective signal; std dev gradient remains nonzero
- `c(Z)` = off-diagonal Frobenius of the per-branch covariance matrix (NOT cross-branch): `(1/d) Σ_{i≠j} [Cov(Z)]²_{ij}`

Applied to each branch **independently** — enabling branches with different architectures, weights, and input modalities (image+text, audio+spectrogram). This is what distinguishes VICReg from Barlow Twins: BT computes cross-branch correlation and cannot independently regularize branches with different output statistics.

**Barlow Twins as VICReg precursor (Zbontar et al. 2021):** VICReg's covariance term IS BT's off-diagonal redundancy-reduction term; VICReg separates invariance (`s`) from decorrelation (`c`) and adds the variance hinge (`v`), dropping the need for batch normalization and enabling normalization-free, branch-independent training.

---

## Hierarchical JEPA (H-JEPA)

```
JEPA-2  (high-level, abstract representation, long-term prediction)
   ↑ takes representations from JEPA-1 as inputs
JEPA-1  (low-level, detailed representation, short-term prediction)
   ↑ raw observations x, y
```

Each level learns to discard details that are unpredictable at its timescale. Higher levels make longer-term predictions at coarser resolution. Enables hierarchical Mode-2 planning:
- Top-level actor infers abstract action sequence minimizing high-level cost
- Abstract "actions" become state conditions (subgoals) for the level below
- Each level infers concrete action sequence minimizing its subgoal cost
- Process iterates top-down; joint optimization preferred but computationally expensive

### HiT-JEPA — First Concrete Three-Level H-JEPA Implementation (Li et al. 2025)

Domain: urban/maritime trajectory similarity. Architecture directly instantiates the H-JEPA design sketch with three explicit levels:

| Level | Representation | Mechanism |
|---|---|---|
| L1 (point) | T^(1) ∈ ℝ^{n×d} | Conv1D; fine-grained local features |
| L2 (segment) | T^(2) ∈ ℝ^{n/2×2d} | Conv1D + MaxPool1D; mesoscopic patterns |
| L3 (route) | T^(3) ∈ ℝ^{n/4×4d} | Conv1D + MaxPool1D; global trajectory summary |

Each level has its own context encoder / target encoder (EMA) / predictor; target sampling uses variable masking ratios r={10%,15%,20%,25%,30%} with 50% successive vs. scattered probability.

**Top-down attention spotlight (key mechanism):** High-level attention coefficient A^(l) ∈ [0,1]^{n^(l)×n^(l)} is upsampled to A^(l-1) scale via ConvTranspose1D (learnable weights), then weighted-summed: A^(l-1) ← A^(l-1) + σ·Ã^(l) where σ is a learned scalar. This guides lower-level feature extraction toward globally salient trajectory segments.

**Loss weighting confirms abstraction primacy:** L = 0.05·L^(1) + 0.15·L^(2) + 0.80·L^(3). The high-level loss must dominate for zero-shot generalization; point-level loss is a regularizer only.

**Critical ablation — attention vs. embedding cross-level communication:**
- HiT_emb (concatenate upsampled embeddings instead of attention) → representation collapse (mean rank ~500 vs. 1)
- HiT_no_attn (independent levels, no injection) → moderate degradation
- **Conclusion:** attention space (not embedding space) is the correct channel for cross-level communication in hierarchical JEPA; embedding-space feature injection bypasses the abstraction bottleneck and causes collapse.

**Zero-shot results:** trained on dense Porto GPS → generalizes zero-shot to sparse Tokyo/NYC check-in sequences and Australian maritime vessels; highest zero-shot mean rank across all datasets.

**Vocabulary co-discovery gap:** levels are pre-specified (point/segment/route), not discovered — directly illustrates Gap 3 from open-problems.md.

---

## V-JEPA 2 (Assran et al. 2026) — Scaling to Video

The full realization of the JEPA principle at internet scale. 1B-parameter ViT-g encoder pre-trained on 1M+ hours of video (VM22M dataset: SSv2, Kinetics, HowTo100M, YT1B, ImageNet) using mask-denoising in representation space.

| Scaling axis | Change | Gain (avg 6 tasks) |
|---|---|---|
| Data: 2M → 22M videos | VM22M dataset | +1.0 pts |
| Model: 300M → 1B params | ViT-L → ViT-g | +1.5 pts |
| Training: 90K → 252K iters | Warmup-constant-cooldown | +0.8 pts |
| Resolution: 256² → 384², 16→64 frames | Progressive resolution | +1.7 pts |
| **Total** | | **+4.0 pts** |

**Architecture changes from I-JEPA:** 3D-RoPE (separate rotary embeddings for temporal/height/width axes) replaces absolute sincos embeddings — required for stable training at 1B+ parameters. Tubelet size 2×16×16 (T×H×W).

**Progressive resolution trick:** Train at 16 frames / 256² during warmup+constant phases; increase to 64 frames / 384² only during 12K-step cooldown. Achieves 8.4× GPU speedup vs. training at full resolution throughout.

**Key results (frozen encoder + attentive probe):**
- SSv2 (motion understanding): 77.3% — outperforms InternVideo2-1B (67.3%)
- EK100 action anticipation: 39.7% recall@5 — +44% relative over PlausiVL (8B)
- VidQA (aligned with Llama-3.1 8B): SoTA at 8B class on PerceptionTest (84.0), MVP (44.5), TempCompass (76.9), TemporalBench (36.7), TOMATO (40.3)

---

## V-JEPA 2-AC — Action-Conditioned World Model

Built on frozen V-JEPA 2 encoder. A 300M-parameter transformer that autoregressively predicts next-frame representations conditioned on actions.

**Training objective:**
$$\mathcal{L} = \mathcal{L}_\text{teacher-forcing} + \mathcal{L}_\text{rollout}$$
- Teacher-forcing loss: `(1/T) Σ_k ||P(a_t, s_t, E(x_t))_{t≤k} − E(x_{k+1})||₁`
- Rollout loss: `||P(a_{1:T}; s_1, z_1) − z_{T+1}||₁` with T=2 (reduces error accumulation)

**Planning (Mode-2 MPC):** minimize `||P(â_{1:T}; s_k, z_k) − z_goal||₁` over action sequences via Cross-Entropy Method. Execute first action, observe new state, re-plan. Energy landscape is smooth and locally convex.

**Zero-shot robot results (Franka Panda, 2 labs, never in training data):**
- Reach: 100% (all models)
- Grasp (cup): 65% avg vs. 15% (Octo fine-tuned), 0–20% (Cosmos)
- Pick-and-place: 65–80% vs. 10% (Octo), 0% (Cosmos)
- Planning speed: 16 sec/action (800 samples) vs. 4 min/action for pixel-space Cosmos (80 samples)

**Limitations of V-JEPA 2-AC:**
- Error accumulation in long-horizon autoregressive rollouts
- Camera position sensitivity (rotation error nearly linear in camera angle)
- Image goals only — no language goal specification

---

## Key Results

LeCun 2022 was a position paper (no empirical results). Assran et al. 2023 (I-JEPA) provides the first large-scale empirical validation:

| Claim | Ablation | Result |
|---|---|---|
| Representation-space > pixel prediction | Target encoder output vs. pixels | 66.9% vs. 40.7% top-1, 1% ImageNet, ViT-L |
| Multi-block masking → semantic representations | Multi-block vs. random/block/rasterized | 54.2% vs. 17.6% / 20.2% / 15.5% |
| Output masking > input masking | Mask target-encoder output vs. input | 67.3% vs. 56.1%, ViT-H/16 |
| Compute efficiency | vs. MAE, iBOT | 5× fewer epochs than MAE; ViT-H/14 < ViT-S/16 iBOT in GPU hours |
| No-augmentation semantic transfer | Linear probe, ImageNet pretrain | CIFAR100 87.5%, iNat18 47.6%, outperforms MAE and data2vec |

Conceptual arguments from LeCun 2022 (still valid):
- Generative models forced to predict every pixel → blurry (mode averaging) or implausible (mode collapse)
- JEPA sidesteps this by predicting in abstract space; encoder discards irrelevant detail
- Non-contrastive VICReg training is dimensionality-independent (contrastive methods scale as O(exp(dim_sy)))

---

## LeJEPA (Balestriero & LeCun 2025) — Provably Optimal Training

The theoretically grounded instantiation of JEPA. Proves that **isotropic Gaussian embeddings N(0,I) uniquely minimize worst-case downstream risk** across both linear and nonlinear probes (Theorem 1). Replaces VICReg's heuristic variance/covariance regularization with **SIGReg** — Sketched Isotropic Gaussian Regularization — a hypothesis test H₀: P_θ = N(0,I) solved via 1D random projections + Epps-Pulley characteristic function test (linear O(N·M·K) complexity).

| Property | I-JEPA / VICReg | LeJEPA |
|---|---|---|
| Collapse prevention | EMA (Exponential Moving Average) teacher-student + VICReg | SIGReg (provably eliminates collapse) |
| Hyperparameters | Multiple (EMA rate, λ/µ/ν, schedulers) | Single λ |
| Architecture scope | ViT-only (practical) | ResNets, ViTs, ConvNets, MaxViTs |
| Training signal | Low correlation with downstream perf | 85–99% Spearman correlation |
| VICReg relationship | Baseline | VICReg is degenerate SIGReg (explains VICReg shortcut solutions) |
| Scale validated | ViT-H/14 79% ImageNet top-1 | ViT-g 1.8B (stable), ViT-H/14 79% |

**In-domain pretraining:** LeJEPA on Galaxy10 (11k images) outperforms DINOv2/DINOv3 pretrained on hundreds of millions of natural images — domain-specific SSL beats generic transfer learning when the training recipe is principled.

---

## LeWorldModel (Maes et al. 2026) — End-to-End World Model from Pixels

The first JEPA trained stably end-to-end from raw pixels for continuous control, applying LeJEPA's SIGReg to world model learning.

| Component | Config |
|---|---|
| Encoder | ViT-Tiny (5M params); [CLS] + BatchNorm MLP projector → z_t ∈ ℝ^{192} |
| Predictor | ViT-S (10M params), AdaLN action conditioning, causal masking, 10% dropout |
| Loss | `ℒ = ||ẑ_{t+1} − z_{t+1}||² + λ·SIGReg(Z)` — two terms only |
| Planning | CEM in latent space: minimize `||ẑ_H − z_goal||²`; receding-horizon MPC, H=5 |

**Key empirical findings:**
- 96% Push-T success rate (vs. DINO-WM 92%, PLDM 78%) with 15M params on single GPU; 48× faster planning than DINO-WM
- Latent space encodes physics not appearance: teleportation (physical violation) produces significant surprise spike in VoE test; color change (visual) does not
- **Temporal straightening emerges spontaneously:** cosine similarity between consecutive latent velocity vectors increases monotonically during training without any temporal regularization — latent trajectories become approximately linear; LeWM achieves higher straightness than PLDM which has an explicit temporal smoothness loss
- SIGReg step-wise applied: λ=0.1 default; performance robust across λ∈[0.01, 0.2]; M=1024 random projections (insensitive parameter)

**Limitations:** short horizon (H=5), image goals only, struggles in low-intrinsic-dimensionality environments (N(0,I) prior is too high-dimensional for simple dynamics).

---

## Limitations

- I-JEPA validated at ImageNet scale for images; V-JEPA extends to video; VL-JEPA extends to multimodal vision-language (see [[wiki/entities/vl-jepa-model.md]])
- The information-minimization criterion for z is necessary to prevent collapse but the right strategy (discrete, sparse, noisy, low-dimensional) is an open design choice
- H-JEPA's intermediate abstract action vocabulary is pre-specified, not learned — directly related to Gap 3 (vocabulary co-discovery) in open-problems.md
- Configurator mechanism for configuring the H-JEPA for a task at hand is the most underspecified component
- LeJEPA's isotropic Gaussian optimality proof assumes continuous data manifolds; whether N(0,I) is optimal for abstract/discrete/graph-structured representation spaces is unproven
- **Mode-2 is not System II (Lett 2025):** MPC planning with a hard-wired search algorithm (CEM, gradient descent, beam search) is "stochastically deterministic" — the same world model + same algorithm = same plan. Both Mode-1 and Mode-2 are System I in Kahneman's sense. True System II would require *learning* the planning/search/reasoning algorithm alongside the world model and cost function — a more radical open problem than the configurator subgoal gap alone.

---

## Comparison to Related Approaches

| Model | Prediction target | Training | Uncertainty | Generalization |
|---|---|---|---|---|
| **JEPA** | Representation s_y | Non-contrastive (VICReg) | Latent z + regularizer | Via abstract encoder |
| VAE | Raw y (decoded) | ELBO (contrastive z prior) | q(z|x) distribution | Via decoder |
| DreamerV2/3 | Categorical latent | RSSM + ELBO | Recurrent belief state | Via learned dynamics |
| TEM | Structural code g transitions | Cross-entropy (factorized) | Hebbian M per-environment | Slow-W cross-environment |
| PC/FEP | Hidden causes z | F = −ELBO | Posterior q(z|o) | Hierarchical priors |
| [[wiki/entities/dinov2-model.md\|DINOv2]] | iBOT: masked patch embedding; DINO: CLS (Complementary Learning Systems) softmax prototype | EMA (Exponential Moving Average) teacher-student + cross-entropy (no contrastive negatives) | None (no latent z) | Frozen patch features transfer to segmentation, depth, retrieval; direct architectural ancestor of I-JEPA |
| [[wiki/entities/dinov3-model.md\|DINOv3]] | Same as DINOv2 + Gram anchoring on patch similarity structure | EMA (Exponential Moving Average) teacher-student + Gram loss (no contrastive negatives) | None (no latent z) | 7B params; SoTA dense features with frozen backbone; Gram decouples local/global learning; LeJEPA beats it in-domain |

---

## Connections

- **[[wiki/queries/sota-review-brain-inspired-abstract-reasoning.md]]** — §4.5 positions the JEPA program as the field's leading non-brain-inspired "world model" alternative: it corroborates representation-space prediction and SSL-from-observation, but as a monolithic, forward-only, single-timescale model it lacks structure/content factorization and latent transformation inference; the review's synthesis uses a JEPA-style encoder as sensory front-end feeding a factorized TEM-lineage core, not JEPA as the whole architecture.
- **[[wiki/entities/vl-jepa-model.md]]** — VL-JEPA extends JEPA to multimodal vision-language by adding a text Y-Encoder as the prediction target; uses V-JEPA 2 ViT-L as its frozen visual backbone; controlled experiments confirm 2× better sample efficiency over token-generative VLMs and SoTA on WorldPrediction-WM.
- **[[wiki/papers/v-jepa-2-assran-2026.md]]** — scaling V-JEPA to 1B parameters and 1M hours of video; introduces V-JEPA 2-AC as the first operational Mode-2 planning loop: frozen encoder + action-conditioned predictor + CEM planning; zero-shot pick-and-place on real robots.
- **[[wiki/concepts/energy-based-models.md]]** — JEPA is an EBM (Energy-Based Model) whose energy is the prediction error in representation space; training via non-contrastive regularization rather than contrastive samples; collapse prevention via information maximization on encoders.
- **[[wiki/concepts/world-models.md]]** — H-JEPA is LeCun's proposed architecture for learning predictive world models that avoid the blurriness problem of generative approaches while preserving multi-modal uncertainty via z.
- **[[wiki/concepts/hierarchical-representations.md]]** — H-JEPA provides a concrete multi-level architecture where each level learns to predict at a longer timescale with a more abstract representation; the timescale/abstraction tradeoff is made explicit.
- **[[wiki/concepts/predictive-coding.md]]** — JEPA's prediction-in-representation-space objective is aligned with PC's goal of minimizing prediction error at each cortical level; unlike PC, JEPA does not decompose into explicit error neuron populations and uses non-contrastive SSL rather than hierarchical free-energy minimization.
- **[[wiki/papers/lejepa-balestriero-lecun-2025.md]]** — theoretical foundation of LeJEPA: proves N(0,I) optimality, introduces SIGReg as the principled collapse-prevention objective, demonstrates architecture-agnostic training stability and 85–99% training-loss/downstream-accuracy correlation.
- **[[wiki/entities/tem-model.md]]** — TEM's W-parameterized g-transitions are a factorized version of a JEPA-like world model (predicting structural code g rather than raw observations); TEM uses explicit factorization while JEPA learns emergent abstraction.
- **[[wiki/papers/lecun-path-towards-autonomous-intelligence-2022.md]]** — primary source; position paper proposing the full cognitive architecture of which JEPA/H-JEPA is the world-model component.
- **[[wiki/papers/barlow-twins-zbontar-2021.md]]** — BT is the direct precursor to VICReg's covariance loss; the redundancy-reduction cross-correlation objective and its IB interpretation under Gaussian approximation explain why JEPA's non-contrastive training benefits from high-dimensional projector outputs.
- **[[wiki/papers/vicreg-bardes-2022.md]]** — primary empirical source for VICReg; provides exact loss formulas, std-dev vs. variance analysis, multi-modal experiments (audio+spectrogram, image+text), and ablations showing variance regularization makes the predictor/stop-gradient redundant.
- **[[wiki/papers/assran-ijepa-2023.md]]** — empirical instantiation of the JEPA architecture for images; provides ablations that validate representation-space prediction, multi-block masking as abstraction lever, and EMA (Exponential Moving Average) target encoder as collapse prevention.
- **[[wiki/papers/leworldmodel-maes-2026.md]]** — applies LeJEPA's SIGReg to end-to-end world model training from raw pixels; demonstrates that a 2-term loss (prediction + SIGReg) is sufficient for stable JEPA world model learning; introduces temporal straightening as an emergent property and VoE as an evaluation criterion.
- **[[wiki/papers/hit-jepa-li-2025.md]]** — first three-level empirical H-JEPA implementation; top-down attention spotlight (ConvTranspose1D upsampling + weighted sum) is the inter-level communication mechanism; ablation shows embedding-space injection causes collapse while attention-space injection preserves hierarchy.
- **[[wiki/papers/dinov2-oquab-2023.md]]** — DINOv2 is the direct architectural ancestor of I-JEPA: the EMA (Exponential Moving Average) teacher-student design, momentum schedule (0.994→1.0), and masked patch prediction (iBOT) are all inherited by I-JEPA; DINOv2's KoLeo regularizer (nearest-neighbor entropy spread) is the conceptual predecessor of LeJEPA's SIGReg (formal N(0,I) test).
- **[[wiki/entities/dinov2-model.md]]** — DINOv2 is the architectural ancestor of the JEPA family: EMA (Exponential Moving Average) teacher-student, masked patch prediction, and KoLeo regularizer all flow into I-JEPA/V-JEPA 2; the comparison table row traces this heritage.
- **[[wiki/entities/dinov3-model.md]]** — DINOv3 extends DINOv2 with Gram anchoring; LeJEPA's finding that SIGReg beats DINOv3 in-domain (11K vs. hundreds of millions of images) establishes the scale-vs.-principled-SSL boundary relevant to abstract reasoning data regimes.
- **[[wiki/papers/lecun-jepa-critical-review-lett-2025.md]]** — identifies z as a relational encoding (x–y relationship, not latent state of x alone), reframes JEPA as a siamese/contrastive model requiring pair inputs, critiques Mode-2 as System I (hard-wired search algorithm on learned model ≠ learned planning algorithm), and distinguishes JEPA's operational single-input limitations from PC's online recurrent inference.
- **[[wiki/queries/operator-collapse-in-fused-structural-codes.md]]** — the VICReg criteria applied outside SSL, to a neuroscience-lineage world model whose codes collapsed to eff-dim 4.80/128; the std-dev-not-variance detail above is the operative recommendation. Records the convergence: TEM's prior loss (`lx_gt`) and JEPA's variance term are the same anti-collapse mechanism reached from neuroscience and from SSL independently.
