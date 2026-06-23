---
title: "DINOv3"
type: entity
tags: [self-supervised-learning, vision-transformers, foundation-models, representation-learning, dense-features, scaling]
created: 2026-06-23
updated: 2026-06-23
sources: [DINOv3]
related: [wiki/entities/dinov2-model.md, wiki/entities/jepa-model.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/energy-based-models.md, wiki/papers/dinov3-simeoni-2025.md, wiki/papers/lejepa-balestriero-lecun-2025.md]
---

# DINOv3

**Self-supervised vision foundation model (Meta AI, 2025) scaling DINOv2 to 7B parameters with Gram anchoring regularization that prevents dense feature degradation at scale; first time an SSL model matches weakly-supervised models on image classification.**

---

## Architecture (7B Teacher)

| Component | DINOv2 | DINOv3 |
|---|---|---|
| Backbone | ViT-giant (1.1B) | ViT-7B (6.7B) |
| Depth | 40 blocks | 40 blocks |
| Embed dim | 1536 | 4096 |
| Patch size | 14 | 16 |
| Pos. embeddings | Learnable | Axial RoPE + box jitter |
| FFN | SwiGLU | SwiGLU |
| DINO prototypes | 128k | 256k |
| iBOT prototypes | 128k | 96k |

**Distilled family:** ViT-S (21M), ViT-S+ (29M), ViT-B (86M), ViT-L (0.3B), ViT-H+ (0.8B). ViT-L performance is close to 7B teacher.

**RoPE box jitter:** coordinate box `[-1,1]` randomly scaled to `[-s,s]` where `s∈[0.5,2]`; improves robustness to resolution and aspect ratio.

---

## Training Pipeline

### Phase 1 — Pre-training (1M iterations, constant schedules)
`ℒ_Pre = ℒ_DINO + ℒ_iBOT + 0.1 · ℒ_DKoleo`

Departing from DINOv2's cosine schedule, constant learning rate enables indefinite training without fixing the optimization horizon.

**Data — LVD-1689M:** ~17B Instagram images → 5-level hierarchical k-means (200M/8M/800k/100k/25k clusters using DINOv2 embeddings) + retrieval-based curation + IN1k/IN22k/Mapillary. Homogeneous IN1k batches = 10% of training.

### Phase 2 — Gram Anchoring Refinement (applied after 1M iterations)
`ℒ_Ref = w_D·ℒ_DINO + ℒ_iBOT + w_DK·ℒ_DKoleo + w_Gram·ℒ_Gram`

**Gram anchoring objective:**
`ℒ_Gram = ||X_S · X_S^T − X_G · X_G^T||_F^2`

where `X_S` and `X_G` are L2-normalized patch feature matrices (P×d) of student and Gram teacher respectively. The Gram teacher is a frozen early checkpoint (100k–200k iterations); it is updated every 10k iterations to track the EMA teacher.

**Why Gram matrices, not features:** Gram loss constrains pairwise similarity structure of patches without pinning absolute feature directions — local features are free to move as long as their mutual similarity structure is preserved. This decouples global semantic learning (DINO) from local spatial consistency.

**High-resolution Gram anchoring:** Gram teacher processes images at 2× resolution then bicubically downsamples; transfers enhanced patch-level consistency of higher-resolution features into the student.

### Phase 3 — Post-Training
- **Resolution scaling:** 10K iterations at mixed resolutions (512/768 global, 112–336 local); RoPE enables resolution generalization beyond training range (stable features observed at 4096px).
- **Multi-student distillation:** Teacher inference shared across all GPU groups; reduces per-GPU cost and enables parallel distillation of multiple student sizes.
- **Text alignment (LiT paradigm):** Frozen DINOv3 backbone + 2 trainable transformer layers + text encoder trained from scratch; mean-pooled patches concatenated with CLS before text matching.

---

## Key Results

| Task | Metric | DINOv3 | DINOv2 | Best competitor |
|---|---|---|---|---|
| ADE20k segmentation (linear) | mIoU | **55.9** | 49.5 | AM-RADIO 53.0 |
| ADE20k (Mask2Former, frozen backbone) | mIoU | **63.0** | — | ONE-PEACE 63.0 (fine-tuned) |
| COCO detection (Plain-DETR, frozen) | mAP | **66.1** | — | PEspatial 66.0 (fine-tuned!) |
| DAVIS tracking (M-res) | J&F | **79.7** | 73.6 | AM-RADIO 77.3 |
| NYUv2 depth (linear) | RMSE | **0.309** | 0.372 | AM-RADIO 0.340 |
| ImageNet (linear) | top-1 | **88.4%** | 87.3% | PEcore 89.3% (weakly-supervised) |
| ImageNet-C | corruptions | **19.6** | 24.1 | SigLIP 2: 30.0 |
| VOC unsupervised obj. discovery | CorLoc | **best** | degrades | — |

**First competitive frozen-backbone detection:** Plain-DETR (100M trainable) on DINOv3 (7B, frozen) matches all fine-tuned competitors with >300M trainable parameters.

**In-domain exception (from LeJEPA paper):** LeJEPA trained on Galaxy10 (11K images) outperforms DINOv3 pretrained on hundreds of millions of images — principled SSL (SIGReg) beats scale when in-domain distribution is narrow.

---

## Limitations

- 7B teacher requires substantial compute; practical deployment relies on distilled variants.
- Motion/temporal understanding (SSv2 70.1%) lags V-JEPA 2 (75.4%) — image-only SSL misses temporal structure.
- Gram anchoring adds a second training phase; the right Gram teacher checkpoint selection (100–200K iterations) requires validation.
- N(0,I) assumption implicit in KoLeo may be suboptimal for domain-specific abstract representation spaces (LeJEPA finding; see [[wiki/papers/lejepa-balestriero-lecun-2025.md]]).

---

## Connections

- **[[wiki/entities/dinov2-model.md]]** — DINOv3 is the direct successor: same DINO+iBOT+KoLeo recipe scaled to 7B; Gram anchoring directly addresses DINOv2's dense feature degradation at scale; RoPE replaces DINOv2's learnable positional embeddings for resolution generalization.
- **[[wiki/entities/jepa-model.md]]** — The DINOv2/DINOv3 EMA teacher-student pattern is the architectural ancestor of I-JEPA's target encoder; LeJEPA's SIGReg provably outperforms both DINOv2 and DINOv3 in-domain, identifying KoLeo as a weaker version of N(0,I) regularization.
- **[[wiki/concepts/hierarchical-representations.md]]** — DINOv3 maintains the CLS (global semantic) + patch (local spatial) dual-level representation; Gram anchoring preserves the patch-level hierarchy independently of the global DINO objective.
- **[[wiki/concepts/energy-based-models.md]]** — DINOv3 is a non-contrastive discriminative EBM: cross-entropy between student and EMA teacher prototype scores minimizes without explicit negative pairs; Gram loss is an additional structural energy term.
- **[[wiki/papers/lejepa-balestriero-lecun-2025.md]]** — LeJEPA's in-domain Galaxy10 result (11K images beats DINOv3 transfer from hundreds of millions) establishes the boundary between scale-based and principled-SSL regimes; relevant for abstract reasoning where training data is always small.
- **[[wiki/papers/dinov3-simeoni-2025.md]]** — primary source; Gram anchoring derivation, LVD-1689M curation, multi-student distillation, and comprehensive benchmark results.
