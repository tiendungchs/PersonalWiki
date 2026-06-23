---
title: "LeJEPA: Provable and Scalable Self-Supervised Learning Without the Heuristics — Balestriero & LeCun 2025"
type: paper
tags: [self-supervised-learning, jepa, non-contrastive, collapse-prevention, representation-learning, isotropic-gaussian, sigreg]
created: 2026-06-23
updated: 2026-06-23
sources: [LeJEPA]
related: [wiki/entities/jepa-model.md, wiki/concepts/energy-based-models.md, wiki/concepts/representational-geometry.md, wiki/papers/vicreg-bardes-2022.md, wiki/papers/barlow-twins-zbontar-2021.md, wiki/papers/assran-ijepa-2023.md, wiki/papers/weak-sigreg-akbar-2026.md]
---

# LeJEPA: Provable and Scalable Self-Supervised Learning Without the Heuristics

**Balestriero & LeCun (arXiv 2511.08544, 2025). Equal contribution; Meta-FAIR + Brown + NYU.** Derives JEPA training from first principles: proves the isotropic Gaussian is the uniquely optimal embedding distribution, instantiates it via SIGReg, and eliminates all ad-hoc SSL heuristics (teacher-student, stop-gradient, EMA, register tokens) by construction.

---

## Key Computational Insights

- **Isotropic Gaussian optimality (Theorem 1):** For any downstream task family, the isotropic Gaussian N(0,I) uniquely minimizes the integrated squared bias of both linear probes (Lemmas 1–2: anisotropy amplifies both bias and variance) and nonlinear probes (k-NN, kernel; Theorem 7). Constraint: fixed total variance Tr(Cov) = κ. This is a proof, not a heuristic — it transforms collapse prevention from ad-hoc engineering to targeted optimization.

- **SIGReg — Sketched Isotropic Gaussian Regularization:** Frames collapse prevention as a statistical hypothesis test H₀: P_θ = N(0,I). Uses 1D random projections (sketching) to decompose the high-dimensional test into M univariate directional tests — defeating the curse of dimensionality. The Epps-Pulley characteristic function test is selected for provably bounded gradients, linear O(N·M·K) complexity, and smooth curvature. VICReg is recovered as a degenerate case (using mean+std test instead of Epps-Pulley), which also explains VICReg's known shortcut solutions.

- **Informative training loss:** LeJEPA training loss achieves 85% Spearman correlation with downstream accuracy out of the box; a simple scaling law `C^(α) = ρ_s(train_loss / λ^α, test_accuracy)` with α≈0.4 pushes this to ~99%. First SSL framework enabling label-free model selection and cross-validation without supervised probing.

- **In-domain pretraining beats massive-scale transfer:** LeJEPA pretrained on Galaxy10 (11k images) with default hyperparameters outperforms DINOv2/DINOv3 pretrained on hundreds of millions of natural images, in both linear probe and full fine-tuning regimes. Challenges the assumption that large-scale generic pretraining is universally dominant.

- **Architecture-agnostic and heuristic-free:** Single hyperparameter λ. No teacher-student, no stop-gradient, no EMA schedule, no register tokens. Stable training up to ViT-g (1.8B parameters). Works across ResNets, ViTs, ConvNets, MaxViTs, Swin Transformers from the same recipe. 79% top-1 ImageNet-1k with ViT-H/14.

---

## Limitations

- Validated on visual domains (images, video, astronomy); abstract/symbolic domains untested — does N(0,I) optimality transfer when the data manifold is discrete or graph-structured?
- Hierarchical stacking (H-JEPA) not addressed; LeJEPA resolves the single-level collapse problem but leaves multi-level abstract action vocabulary discovery open.
- Strong SIGReg (all-moment matching) vs. Weak-SIGReg (2nd-moment only) achieve similar downstream performance in practice; theoretical explanation for why 2nd-moment suffices is missing.

---

## Connections

- **[[wiki/entities/jepa-model.md]]** — LeJEPA is the theoretically grounded instantiation of JEPA: proves what distribution JEPA's embeddings should follow and provides SIGReg as the practical tool to enforce it; closes the "not yet in the wiki" forward reference in jepa-model.md.
- **[[wiki/concepts/energy-based-models.md]]** — SIGReg is the provably optimal non-contrastive regularization strategy for EBM training; Theorem 1 explains *why* existing methods (VICReg, BT) work and where they fall short.
- **[[wiki/concepts/representational-geometry.md]]** — Theorem 1 is a representational geometry result: the isotropic (spherical) geometry uniquely minimizes worst-case downstream bias; connects to CCGP/SD framework where equal-variance coding directions are a prerequisite for robust linear readout.
- **[[wiki/papers/vicreg-bardes-2022.md]]** — VICReg is a degenerate case of SIGReg (mean+std test, not Epps-Pulley); LeJEPA strictly generalizes VICReg by enforcing all moments of the embedding distribution, not just variance and covariance.
- **[[wiki/papers/assran-ijepa-2023.md]]** — I-JEPA is the predecessor SSL instantiation; LeJEPA supersedes I-JEPA's EMA+stop-gradient collapse prevention with provable SIGReg, matching or exceeding I-JEPA performance at 3× lower training compute.
- **[[wiki/papers/weak-sigreg-akbar-2026.md]]** — Weak-SIGReg adapts the 2nd-moment version of SIGReg for supervised learning; this paper is the source of Strong SIGReg (all-moment CF matching); the two together form a continuum of Gaussian-alignment regularizers.
