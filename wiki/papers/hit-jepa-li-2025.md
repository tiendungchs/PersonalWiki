---
title: "HiT-JEPA: A Hierarchical Self-supervised Trajectory Embedding Framework for Similarity Computation"
type: paper
tags: [jepa, hierarchical-representations, self-supervised-learning, trajectory, urban-computing, zero-shot-generalization]
created: 2026-06-23
updated: 2026-06-23
sources: [HiT-JEPA A Hierarchical Self-supervised Trajectory Embedding Framework for Similarity Computation]
related: [wiki/entities/jepa-model.md, wiki/concepts/hierarchical-representations.md, wiki/concepts/attention.md, wiki/concepts/world-models.md]
---

# HiT-JEPA — Li, Xue, Ao, Song & Salim 2025

**Citation:** Li L., Xue H., Ao S., Song Y., Salim F. — UNSW Australia. arXiv:2507.00028.

---

## Key Computational Insights

- **Three-level hierarchical JEPA** — Conv1D + MaxPool1D stacking produces point-level T^(1), segment-level T^(2) (n/2 length, 2d channels), and route-level T^(3) (n/4, 4d channels) representations; each level has its own context encoder / target encoder (EMA) / predictor triplet trained with SmoothL1 + VICReg independently.
- **Top-down attention spotlight** — high-level attention coefficient A^(l) (n^(l) × n^(l)) upsampled to A^(l-1) scale via ConvTranspose1D, then weighted-summed into the lower-level attention: A^(l-1) ← A^(l-1) + σ·Ã^(l) where σ is a learnable scale; applies to both context and target branches; guides fine-grained feature extraction toward globally salient regions.
- **Concatenation → collapse; attention injection → coherence** — ablation HiT_emb (upsampled embedding concatenation instead of attention) causes representation collapse (mean rank ~500 vs. ~1 for HiT-JEPA); HiT_no_attn (independent levels, no injection) degrades moderately; confirms attention-space (not embedding-space) is the right channel for cross-level communication.
- **High-level loss dominates** — final loss L = 0.05·L^(1) + 0.15·L^(2) + 0.80·L^(3); strong weighting toward the abstract level is necessary for generalization; point-level loss contributes primarily as a regularizer.
- **Zero-shot cross-domain transfer** — model trained on dense Porto GPS trajectories generalizes zero-shot to sparse Tokyo/NYC check-in sequences and Australian maritime vessel tracks; hierarchy enables summarization knowledge to transfer across data modalities and spatial scales.

## Limitations

- Three levels are pre-specified (point/segment/route); the vocabulary of abstraction levels is not discovered from data — directly illustrates the vocabulary co-discovery gap (Gap 3, open-problems.md).
- Evaluation domain (trajectory similarity computation) is urban computing, not abstract reasoning; generalization claim is cross-modality, not cross-task-structure.
- Hexagonal H3 spatial tokenization + node2vec pretraining introduces a domain-specific spatial representation stage not present in more general JEPA formulations.

## Links

- [[wiki/entities/jepa-model.md]] — HiT-JEPA is the first concrete three-level empirical instantiation of H-JEPA; top-down attention spotlight is the novel inter-level communication mechanism
- [[wiki/concepts/hierarchical-representations.md]] — adds a sequential-data instantiation of multi-level hierarchical self-supervised learning with top-down modulation
- [[wiki/concepts/attention.md]] — attention maps serve as the cross-level communication channel; upsampled via learned ConvTranspose1D
- [[wiki/concepts/world-models.md]] — trajectory encoder as a representation-space world model for spatiotemporal sequences
