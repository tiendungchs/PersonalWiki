---
title: "Self-Attention Limits Working Memory Capacity of Transformer-Based Models — Gong & Zhang, NeurIPS Workshop 2024"
type: paper
tags: [working-memory, transformer, attention, N-back, capacity-limit, mechanistic-interpretability]
created: 2026-06-19
updated: 2026-06-19
sources: [transformer_wm_limit]
related: [wiki/concepts/working-memory.md, wiki/concepts/attention.md, wiki/papers/trnn-liu-2025.md]
---

**Citation:** Gong D, Zhang H (2024). *Self-Attention Limits Working Memory Capacity of Transformer-Based Models.* NeurIPS 2024 Workshop on Behavioral Machine Learning. Yale University.

- Causal transformers solve N-back tasks by concentrating attention on position i−N; this strategy is both the learned solution and the bottleneck — as N grows, more preceding positions compete in the softmax, dispersing attention away from the target.
- Total attention entropy $H_N = \sum_i H(A_{i,:})$ increases with N; test accuracy decreases with H_N (negative correlation, 1L-1H model); accuracy declines logarithmically with N — and this persists even with more layers/heads (L=2, H=4), only mitigated not eliminated.
- Context length is not the bottleneck: 24-character sequences are well within context window; failure is architectural, arising from softmax concentration difficulty, not storage.
- Executive attention theory (Engle et al.) maps cleanly: human WM limits come from attentional resource scarcity, not storage capacity; transformer shows the same pattern — the softmax normalization is the resource that gets divided.
- Multi-layer/multi-head architectures mitigate via implicit routing (each head can specialize to a different lag), but the fundamental softmax competition problem is not resolved — it is distributed across heads.

**Limitations:** Stripped-down transformer (no FFN, no LayerNorm) for interpretability — generalization to pretrained LLMs is unclear; only N-back tasks tested; does not explore architectural fixes (sparse attention, state-space models, auxiliary WM modules).

→ [[wiki/concepts/working-memory.md]] — provides mechanistic account of transformer WM capacity limit; attention entropy as the metric; executive attention theory parallel
→ [[wiki/concepts/attention.md]] — the softmax global competition that causes WM limits is the same global receptive field property that causes the localism gap in compositional generalization; two distinct failure modes from the same structural property
