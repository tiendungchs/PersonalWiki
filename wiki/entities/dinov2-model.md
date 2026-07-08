---
title: "DINOv2"
type: entity
tags: [self-supervised-learning, vision-transformers, foundation-models, representation-learning, non-contrastive]
created: 2026-06-23
updated: 2026-07-02
sources: [DINOv2 Learning Robust Visual Features without Supervision]
related: [wiki/entities/dinov3-model.md, wiki/entities/jepa-model.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/energy-based-models.md, wiki/concepts/attention.md, wiki/papers/dinov2-oquab-2023.md]
---

# DINOv2

**Self-supervised vision foundation model (Meta AI, 2023) combining image-level and patch-level discriminative objectives with a curated training corpus; first SSL model to match or surpass CLIP on diverse benchmarks without fine-tuning.**

---

## Architecture

| Component | Spec |
|---|---|
| Backbone | ViT-giant (1.1B params, patch size 14); also ViT-L/B/S variants |
| Teacher | Exponential Moving Average of student weights (EMA momentum 0.994→1.0) |
| DINO head | MLP → softmax prototype distribution (image-level CLS (Complementary Learning Systems) loss) |
| iBOT head | MLP → prototype distribution on masked patch tokens (patch-level MIM loss) |
| KoLeo regularizer | `ℒ_koleo = -(1/n) Σ log d_{n,i}` — maximizes nearest-neighbor entropy within batch |
| Registers | 4 register tokens (added post-publication; needed to suppress high-norm patch artifacts) |

**Training loss:**
`ℒ = ℒ_DINO + ℒ_iBOT + 0.1 · ℒ_KoLeo`

**Data — LVD-142M:** k=4 nearest-neighbor retrieval (ViT-H/16 cosine similarity) from 1.2B uncurated web images, seeded by small curated corpus. Curated diversity beats uncurated scale on out-of-domain tasks.

---

## Key Results

| Task | Metric | Value | vs. CLIP |
|---|---|---|---|
| ImageNet (linear probe) | top-1 | 86.5% | Matches open-source CLIP |
| ADE20k segmentation (lin. probe) | mIoU | 49.5 | Strongly outperforms |
| DAVIS tracking | J&F (M-res) | 73.6 | Strongly outperforms |
| NYUv2 depth (linear probe) | RMSE | 0.372 | Strongly outperforms |
| SPair semantic correspondence | recall | 56.1 | N/A |

**Emergent spatial decomposition:** PCA of frozen DINOv2 patch tokens separates foreground/background (1st PC) and semantic object parts (subsequent PCs) that match across categories despite changes in pose and species — arising solely from iBOT patch-level objective, no spatial labels used.

**Sim-to-real transfer:** DINOv2 bridges simulation-to-real domain gap in Depth Anything V2 (DAv2); other backbones (SAM) fail this transfer — attributed to broad, non-task-specific feature space.

---

## Limitations

- Dense features degrade during extended training at scale (DINOv3's Gram anchoring solves this).
- EMA (Exponential Moving Average) teacher-student requires aligned architectures; cross-modal or asymmetric-branch training is not natively supported (VICReg/branch-independence addresses this).
- No latent uncertainty representation (no z); point-estimate encoder only.
- LVD-142M inherits geographic/socioeconomic bias from ImageNet/Google Landmarks seeds (25.7% Europe–Africa gap; 31.7% high vs. low income gap).

---

## Comparison to Successors

| Property | DINOv2 | DINOv3 | I-JEPA |
|---|---|---|---|
| Scale | 1.1B params | 7B params → distilled family | Up to ViT-H/14 |
| Dense feature stability | Degrades at scale | Gram anchoring fixes this | N/A (images only) |
| Pos. embeddings | Learnable | RoPE (axial) | Absolute sincos |
| Collapse prevention | EMA (Exponential Moving Average) + KoLeo | EMA (Exponential Moving Average) + KoLeo + Gram | EMA (Exponential Moving Average) (SIGReg in LeJEPA) |
| In-domain efficiency | Needs billions of images | Needs billions of images | LeJEPA on 11K beats both |

---

## Connections

- **[[wiki/queries/sota-review-brain-inspired-abstract-reasoning.md]]** — §4.5 casts DINOv2 as the *perception front-end* (not a world model) of the world-model pivot; its emergent, label-free object-part decomposition (patch-token PCA) is a candidate solution to the objectness/Core-Knowledge prior the review flags as missing (§3, §8.3), slotting into the sensory front-end (Blocks 1A+2A).
- **[[wiki/entities/dinov3-model.md]]** — DINOv3 is DINOv2's direct successor: same DINO+iBOT+KoLeo training recipe, scaled to 7B params, with Gram anchoring added to prevent dense feature degradation that DINOv2 suffers at scale.
- **[[wiki/entities/jepa-model.md]]** — DINOv2's EMA (Exponential Moving Average) teacher-student design (same momentum schedule 0.994→1.0), iBOT masked patch prediction, and KoLeo regularizer are all directly inherited by I-JEPA / V-JEPA 2; DINOv2 is the architectural ancestor of the JEPA family.
- **[[wiki/concepts/hierarchical-representations.md]]** — DINOv2's CLS+patch dual-level objective is a two-scale hierarchy; emergent part segmentation from patch-token PCA is empirical evidence that self-supervised patch-level objectives produce semantically structured spatial codes without spatial supervision.
- **[[wiki/concepts/energy-based-models.md]]** — DINO/iBOT cross-entropy between student and EMA (Exponential Moving Average) teacher prototype scores is a non-contrastive discriminative EBM: the energy is the cross-entropy between softmax distributions, minimized without explicit negative pairs.
- **[[wiki/concepts/attention.md]]** — DINOv2's frozen ViT patch features demonstrating segmentation and depth from linear probes confirms that self-attention over patches produces spatially structured representations when trained with patch-level objectives.
- **[[wiki/papers/dinov2-oquab-2023.md]]** — primary source; provides ablations for dual-objective, KoLeo, and data curation; source of LVD-142M curation methodology and emergent part-segmentation finding.
