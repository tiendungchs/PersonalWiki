---
title: "Self-Supervised Learning from Images with a Joint-Embedding Predictive Architecture (I-JEPA)"
type: paper
tags: [self-supervised-learning, JEPA, energy-based-models, vision-transformers, representation-learning, masking]
created: 2026-06-23
updated: 2026-06-23
sources: [jepa]
related: [wiki/entities/jepa-model.md, wiki/concepts/energy-based-models.md, wiki/concepts/world-models.md, wiki/concepts/hierarchical-representations.md, wiki/papers/lecun-path-towards-autonomous-intelligence-2022.md]
---

# Self-Supervised Learning from Images with a Joint-Embedding Predictive Architecture (I-JEPA)

**Assran, Duval, Misra, Bojanowski, Vincent, Rabbat, LeCun, Ballas. Meta AI (FAIR) / McGill / Mila / NYU. CVPR 2023.**

---

## Five Key Computational Insights

- **Representation-space prediction is semantically necessary.** Predicting target-encoder output vs. pixels: 66.9% vs. 40.7% top-1 linear probe on 1% ImageNet (ViT-L/16, 500 ep). The target encoder discards unpredictable pixel-level details; predicting its outputs forces the context encoder to extract semantic content. Directly validates LeCun's JEPA thesis at scale.

- **Multi-block masking strategy controls abstraction level.** Four large-scale target blocks (scale 0.15–0.2) from a spatially distributed context block (scale 0.85–1.0): 54.2% vs. random masking 17.6% / block masking 20.2% / rasterized 15.5% (ViT-B/16, 1% ImageNet linear probe). Masking scale is the primary lever for controlling what level of abstraction is learned — larger semantic targets force semantic representations; small local patches force texture representations.

- **Target masking at encoder output, not input.** Masking the OUTPUT of the target-encoder produces semantic-level prediction targets: 67.3% vs. 56.1% input-masking (ViT-H/16, 300 ep). Output masking lets the encoder see the full image before masking, producing richer abstract targets than masking patches at the input.

- **EMA target encoder prevents collapse without negatives.** Target encoder θ̄ = EMA(θ) with momentum m=0.996→1.0 scheduled. The asymmetric context/target encoder design prevents representation collapse without contrastive samples, view augmentations, or stop-gradients. Combined with information-maximization on the context encoder output, this makes I-JEPA fully non-contrastive.

- **Compute efficiency from harder prediction signal.** ViT-H/14 I-JEPA requires less compute than ViT-S/16 iBOT; 5× fewer pretraining epochs than MAE to match or exceed it. Representation-space prediction provides a more informative gradient per iteration than pixel reconstruction, causing faster convergence. Predictor bottleneck (width 384 vs. 1024 = encoder width) improves downstream accuracy by forcing efficient context→target mapping.

---

## Limitations

- Results on static images only; extension to video or multi-modal inputs not demonstrated in this paper.
- Optimal masking hyperparameters (block scale, count, context scale) are image-dataset-specific; transfer to other modalities requires retuning.
- Predictor visualizations confirm I-JEPA discards background and fine-grained texture — may limit tasks requiring precise local spatial reasoning.

---

## Links

- [[wiki/entities/jepa-model.md]] — I-JEPA empirically instantiates LeCun's JEPA; resolves the "no empirical validation" limitation; adds concrete EMA (Exponential Moving Average) + multi-block masking architecture
- [[wiki/concepts/energy-based-models.md]] — I-JEPA confirms non-contrastive EBM (Energy-Based Model) training scales to ImageNet; ablations validate collapse prevention via asymmetric encoder
- [[wiki/concepts/world-models.md]] — I-JEPA demonstrates representation-space world models learn semantic content from images without hand-crafted augmentations
- [[wiki/concepts/hierarchical-representations.md]] — masking scale controls abstraction level; this principle generalizes to H-JEPA multi-level design
- [[wiki/papers/lecun-path-towards-autonomous-intelligence-2022.md]] — I-JEPA is the empirical realization of the JEPA proposal from LeCun 2022 (cited as [48])
