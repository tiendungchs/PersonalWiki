---
title: "Energy-Based Models (EBM)"
type: concept
tags: [energy-based-models, self-supervised-learning, contrastive-learning, world-models, reasoning, optimization]
created: 2026-06-23
updated: 2026-07-16
sources: [A Path Towards Autonomous Machine Intelligence, barlow_twins, vicreg]
related: [wiki/entities/jepa-model.md, wiki/concepts/world-models.md, wiki/concepts/predictive-coding.md, wiki/entities/boltzmann-machine.md, wiki/concepts/associative-memory.md, wiki/concepts/abstract-reasoning.md, wiki/entities/fcann.md, wiki/papers/lecun-path-towards-autonomous-intelligence-2022.md, wiki/papers/barlow-twins-zbontar-2021.md, wiki/papers/vicreg-bardes-2022.md, wiki/papers/lejepa-balestriero-lecun-2025.md, wiki/papers/weak-sigreg-akbar-2026.md, wiki/papers/fcann-attractor-dynamics-englert-2026.md, wiki/queries/operator-collapse-in-fused-structural-codes.md]
---

# Energy-Based Models (EBM)

**An EBM (Energy-Based Model) is a scalar-valued function F(x, y; w) that measures compatibility between two variables — producing low energy when x and y are consistent and high energy when they are not — without requiring a normalized probability distribution.**

---

## Core Formalism

```
F_w(x, y) → scalar energy
  F_w(x, y) low   ⟺   x and y are compatible
  F_w(x, y) high  ⟺   x and y are incompatible
```

**Latent-variable EBM (Energy-Based Model) (LVEBM):** add unobserved z to capture residual uncertainty:
```
E_w(x, y, z)  →  F_w(x, y) = min_z E_w(x, y, z)
```
z parameterizes the set of plausible y's compatible with x. The "zero-temperature free energy" F_w(x,y) marginalizes over z by minimizing.

**Probabilistic interpretation (optional):** convert to distribution via Gibbs formula:
```
P(y | x) = exp(−F_w(x,y)) / Z(x)
where Z(x) = ∫ exp(−F_w(x,y)) dy
```
EBM does not *require* this — the energy surface is the primary object.

---

## Collapse: The Core Training Problem

Training must ensure the energy is low at data points and high elsewhere. The failure mode is **collapse**: a flat energy surface assigning low energy everywhere.

| Architecture | Collapse condition |
|---|---|
| Deterministic predictive | Cannot collapse — produces exactly one ŷ per x |
| Generative latent-variable | Collapses if z has same or higher dimensionality as y |
| Auto-encoder | Collapses if s_y has same or higher dimensionality as y (learns identity) |
| Joint Embedding Architecture (JEA) | Collapses if encoders ignore input and produce constant codes |

---

## Two Training Strategies

### Contrastive Methods
Push down E(x, y) for data; pull up E(x, ŷ) for "contrastive" samples ŷ:
```
L = H(F_w(x,y), F_w(x,ŷ))  — increasing in F(x,y), decreasing in F(x,ŷ)
```
Examples: max-likelihood, pairwise hinge, InfoNCE, GAN (generator produces ŷ), denoising auto-encoder.

**Problem:** in d-dimensional representation spaces, number of contrastive samples needed may grow O(exp(d)) — curse of dimensionality.

### Regularized / Non-Contrastive Methods
Minimize volume of low-energy region while pushing energy down on data points; energy "shrink-wraps" the data manifold.

Examples: sparse auto-encoders (L1 on s_y limits volume), VICReg (maximizes s_x, s_y information content → minimizes low-energy volume), Barlow Twins, Weak-SIGReg (full Frobenius distance to identity: `||Cov − I||_F`; also applies in single-network supervised training), LeJEPA/SIGReg (all-moment CF matching; theoretically optimal — see below), VAE (noisy z limits z information capacity).

**Isotropic Gaussian optimality (Balestriero & LeCun 2025, Theorem 1):** The isotropic Gaussian N(0,I) is the *unique* minimizer of the integrated squared bias across both linear probes and nonlinear probes (k-NN, kernel), subject to a fixed total variance constraint. This is a proof, not a heuristic. Corollaries: (a) anisotropy always amplifies bias (Lemma 1) and variance (Lemma 2); (b) VICReg, which targets only the 2nd moment (variance + covariance), is a degenerate special case of LeJEPA's SIGReg (which targets all moments via characteristic function matching) — this also explains VICReg's known shortcut solutions where 2nd-moment constraints are satisfied while higher moments remain anisotropic.

**SIGReg — Sketched Isotropic Gaussian Regularization:** Frames collapse prevention as a hypothesis test H₀: P_θ = N(0,I). Solved via M random 1D projections (defeating curse of dimensionality) + Epps-Pulley characteristic function test (provably bounded gradients and curvature). Complexity O(N·M·K), linear in all dimensions. Single hyperparameter λ; stable across architectures (ResNets, ViTs, ConvNets) and scales (up to 1.8B parameters). Training loss achieves 85–99% Spearman correlation with downstream accuracy — enables label-free model selection.

**Dean-Kawasaki collapse framing (Akbar 2026):** An alternative to the information-theoretic view: dimensional collapse = stochastic drift of representation density under finite-batch noise and aggressive augmentation — analogous to a particle system drifting into a degenerate low-dimensional equilibrium. Covariance regularization acts as a thermodynamic restoring force constraining density toward N(0,I). Corollary: Cov→I also acts as "soft Batch Normalization" — maintaining gradient conditioning in deep MLPs without BN's non-local batch statistics.

**Key advantage:** avoids curse of dimensionality; dimensionality-independent regularization is possible via information-theoretic objectives.

**Barlow Twins — collapse prevention via redundancy reduction (Zbontar et al. 2021):** Twin encoders produce batch-normalized embeddings Z_A, Z_B. Loss drives the cross-correlation matrix toward identity:
```
L = Σ_i (1 − C_ii)²  +  λ Σ_{i≠j} C²_{ij}
C_ij = (Z_A_i · Z_B_j) / (||Z_A_i|| · ||Z_B_j||)
```
Diagonal term = invariance (augmented views map to same code). Off-diagonal term = decorrelation (redundancy reduction). Collapse-free by construction: a constant encoder produces a non-diagonal C, and the loss gradient drives components apart. No stop-gradient, predictor network, or momentum encoder needed.

Under Gaussian approximation, the off-diagonal Frobenius term ≈ −log det(Cov(Z)): a tractable proxy for −H(Z). This makes BT an instantiation of the **Information Bottleneck**: on-diagonal ≈ minimize H(Z|X); off-diagonal ≈ maximize H(Z). Gaussian entropy estimation is sample-efficient and dimension-independent — explaining BT's monotonic improvement with embedding dimensionality (up to 8192+ tested), unlike InfoNCE-based methods which saturate due to non-parametric curse of dimensionality.

Biological origin: Horace Barlow (1961) proposed the redundancy-reduction principle — sensory processing transforms correlated inputs into a factorial code (statistically independent components) — to explain visual cortex organization. BT is the direct ML operationalization. VICReg (JEPA's training signal) extends BT by adding a variance term; BT is its direct precursor.

---

## Information-Theoretic Unification of Training Objectives

Bordes et al. 2024 derive that all VLM (and by extension, all self-supervised) training objectives are instances of the same rate-distortion problem:

```
min_{p(z|x)}  I(f(X); Z)  +  β · H(X | Z)
```

- **Rate** `I(f(X);Z)` — mutual information between transformed input and representation; controlled by the data transformation f (augmentation, masking, modality). The entropy bottleneck term `log q(z)` bounds this.
- **Distortion** `H(X|Z)` — information preserved; controlled by the loss form. The reconstruction term `log q(x|z)` bounds this.

| Training family | Rate control | Distortion | Reconstruction? |
|---|---|---|---|
| **Contrastive (InfoNCE, CLIP)** | Masking / augmentation amount | Cosine similarity of equivalence classes | No |
| **Masking (MAE, FLAVA)** | Amount masked | L2 reconstruction in pixel/token space | Yes |
| **Non-contrastive (JEPA, VICReg)** | Augmentation invariance | Variance/covariance regularization | No |
| **Generative (VQ-VAE, Chameleon)** | Codebook bottleneck | Pixel/token reconstruction | Yes |

**Key insight:** the data transformation determines the rate (how much information is discarded); the loss form (contrastive vs. reconstructive) determines the distortion metric. JEPA's choice — representation-space prediction without reconstruction — can be read as minimizing rate by enforcing invariance while using variance/covariance as the distortion proxy instead of reconstruction error.

---

## Reasoning as Energy Minimization

Mode-2 planning in LeCun's architecture is EBM (Energy-Based Model) inference over action sequences:
```
â = argmin_a Σ_t C(s_t)
where s_t = WorldModel(s_{t-1}, a_{t-1})
```
Gradient-based search works when world model and cost are differentiable and smooth. For discrete action spaces: MCTS, dynamic programming, beam search.

More broadly: any reasoning task that can be formulated as constraint satisfaction is an EBM (Energy-Based Model) inference problem. This includes:
- Probabilistic inference in factor graphs (log-factors = energy terms)
- Analogical mapping (minimize structural/semantic constraint violations)
- Planning (minimize cumulative cost over predicted trajectory)

---

## Relationship to Existing Wiki Concepts

The EBM (Energy-Based Model) framework unifies several architectures already in the wiki:

| System | Energy function | Training | What minimization achieves |
|---|---|---|---|
| Hopfield network / associative memory | E = −½ Σ w_ij x_i x_j | Hebbian write | Pattern completion / retrieval |
| Boltzmann machine | E = −(½ v^T W v + b^T v) | Contrastive Hebbian | Density modeling |
| Predictive coding (PC) | E = Σ_l ε_l² | Local ε·x rule | Posterior over hidden causes |
| JEPA | E = ||s_y − Pred(s_x, z)||² | VICReg (non-contrastive) | Abstract world model |
| VAE | E = ||x − dec(z)||² + KL[q‖p] | ELBO | Latent generative model |
| **fcANN** | E = −½ σᵀ J σ, J = −Σ⁻¹ | Hebbian + anti-Hebbian (contrastive PC; K-S self-orthogonalization) | ~Orthogonal macro brain attractors; K-S-optimal storage capacity |
| V1 complex cell (energy model) | E = −([F^φ(k^φ·s)]² + [F^{φ+90°}(k^{φ+90°}·s)]²) | Fixed (developmental/evolutionary) | Phase-invariant orientation/SF detection; divisive normalization (`/ (σ² + Σ neighbors²)`) prevents response saturation — biological softmax |

---

## Open Problems

- Optimal regularization strategy for latent z (discrete, sparse, noisy, low-dim) remains an open design choice; each has different collapse prevention guarantees
- N(0,I) optimality (Theorem 1) assumes continuous data manifolds with smooth density; whether it extends to abstract/discrete/graph-structured embedding spaces (relevant for ARC-AGI action vocabulary) is unproven
- Non-contrastive EBM (Energy-Based Model) (I-JEPA) scales to ImageNet-scale image pretraining; V-JEPA extends to video; VL-JEPA (Chen et al. 2025) extends to vision-language with InfoNCE in embedding space, achieving SoTA world modeling — confirms non-contrastive EBM (Energy-Based Model) training generalizes across modalities

---

## Connections

- **[[wiki/entities/jepa-model.md]]** — JEPA is the non-contrastive EBM (Energy-Based Model) architecture for world models; JEPA's training via VICReg is the canonical non-contrastive regularized EBM (Energy-Based Model) method.
- **[[wiki/concepts/world-models.md]]** — world model planning = iterative EBM (Energy-Based Model) inference over action sequences; the differentiable cost and differentiable world model form a joint EBM (Energy-Based Model) that can be minimized via gradient descent.
- **[[wiki/concepts/predictive-coding.md]]** — PC's free energy F = −ELBO is an EBM (Energy-Based Model) energy function; PC (Predictive Coding) is the neuroscience instantiation of an EBM (Energy-Based Model) where the energy function is the hierarchical squared prediction error; the local ε·x update rule is gradient descent on this energy.
- **[[wiki/entities/boltzmann-machine.md]]** — Boltzmann machine is a probabilistic EBM (Energy-Based Model) trained with contrastive Hebbian learning; the historically foundational EBM (Energy-Based Model) for unsupervised learning in neural networks.
- **[[wiki/concepts/associative-memory.md]]** — Hopfield networks are EBMs; memory retrieval = energy minimization; modern Hopfield networks (polynomial/exponential capacity) extend the EBM (Energy-Based Model) formalism to higher-capacity retrieval.
- **[[wiki/concepts/abstract-reasoning.md]]** — reasoning as energy minimization is the EBM-based alternative to symbolic logic: any constraint satisfaction (analogical mapping, rule inference, planning) can be formulated as finding the low-energy configuration; Mode-2 planning in LeCun's architecture implements this.
- **[[wiki/papers/lecun-path-towards-autonomous-intelligence-2022.md]]** — primary source for this page's EBM (Energy-Based Model) framing, collapse taxonomy, training strategies, and reasoning-as-energy-minimization argument.
- **[[wiki/papers/barlow-twins-zbontar-2021.md]]** — mechanistic instantiation of non-contrastive regularized EBM (Energy-Based Model) training; cross-correlation matrix → identity as the principled collapse-prevention objective; IB interpretation under Gaussian approximation explains the high-dimensional embedding benefit.
- **[[wiki/papers/assran-ijepa-2023.md]]** — empirical confirmation that non-contrastive EBM (Energy-Based Model) training (EMA target encoder + information maximization) scales to ImageNet-level pretraining without contrastive samples or view augmentations.
- **[[wiki/papers/vlm-intro-bordes-2024.md]]** — derives the rate-distortion unification of all VLM training objectives; the information-theoretic unification section above follows from §2.3.3 of this paper.
- **[[wiki/papers/vicreg-bardes-2022.md]]** — provides exact VICReg loss formulas and ablations; the std-dev-not-variance insight and per-branch-independence design are the concrete implementation of the non-contrastive regularized EBM (Energy-Based Model) strategy described in this page.
- **[[wiki/papers/lejepa-balestriero-lecun-2025.md]]** — theoretical source of the isotropic Gaussian optimality theorem and SIGReg; proves that N(0,I) uniquely minimizes downstream risk and that SIGReg's characteristic-function matching is the provably correct way to enforce it.
- **[[wiki/papers/weak-sigreg-akbar-2026.md]]** — supervised adaptation of LeJEPA's SIGReg; adds the Dean-Kawasaki particle dynamics framing of collapse and demonstrates that single-term full-covariance regularization (`||Cov − I||_F`) generalizes outside SSL to BN-free supervised training.
- **[[wiki/concepts/shortcut-reasoning.md]]** — discriminative EBMs (cross-entropy classifiers) are maximally shortcut-prone because the energy is minimized as soon as any sufficient discriminative predictor is found; generative/reconstruction EBMs must model all training variation, forcing representations onto causally relevant features and making shortcuts structurally harder to exploit.
- **[[wiki/entities/fcann.md]]** — fcANN instantiates the EBM at whole-brain scale: J = −Σ⁻¹ is the biologically derived energy function; the Kanter-Sompolinsky orthogonality result shows how FEP-ANN learning drives the EBM toward the collapse-free maximum-capacity regime through self-orthogonalization.
- **[[wiki/papers/carandini-early-visual-2005.md]]** — source for the V1 complex cell energy model (Adelson & Bergen 1985) and divisive normalization (Heeger 1992); the biological fixed-weight EBM row in the unification table above.
- **[[wiki/queries/operator-collapse-in-fused-structural-codes.md]]** — the JEA collapse row instantiated on a measured TEM-lineage world model: eff-dim 4.80/128, action-driven signal 8.9% of code norm, yet 98.5% per-cell reconstruction — *partial* collapse survives a reconstruction objective because a decoder with free gain amplifies the residual. Also records the connection this page and TEM's prior loss had not made: **TEM's `lx_gt` and VICReg's variance term are the same anti-collapse mechanism derived twice**, from neuroscience and from SSL.
