---
title: "Linear Spatial World Models Emerge in Large Language Models — Tehenan, Moya, Long & Lin 2025"
type: paper
tags: [world-models, mechanistic-interpretability, linear-representation-hypothesis, llm, emergence, activation-steering, spatial-representation, compositionality, latent-graph-discovery]
created: 2026-07-09
updated: 2026-07-09
sources: [linear-spatial-world-models]
related: [wiki/concepts/world-models.md, wiki/concepts/latent-graph-discovery.md, wiki/papers/emergent-linear-world-models-nanda-2023.md, wiki/concepts/representational-geometry.md, wiki/concepts/compositional-generalization.md, wiki/queries/central-framing-epistemic-audit.md, wiki/entities/grid-cells.md]
---

# Linear Spatial World Models Emerge in Large Language Models

**Tehenan, Moya, Long & Lin, 2025 (arXiv:2506.02996).** Probes `LLaMA-3.2-3B-Instruct` for an implicit spatial world model. Defines one formally as `W = ⟨R³, O, S, T⟩` (Euclidean space, objects, world-state = object positions, transition function `T`), then tests whether the residual stream encodes it. Synthetic dataset: 61 objects × 6 spatial relations, prompts like *"The cup is above the table. The book is to the left of the cup,"* annotated with ground-truth positions.

## Key computational insights

- **A spatial world model emerges from *text alone*.** No grounding, no images, no game rules — next-token pretraining over language is sufficient pressure to build a low-dimensional subspace *approximately isomorphic to R³*. The purest natural-attractor datapoint in the wiki: unlike OthelloGPT (fully-observable game), language only *partially* observes physical space, yet a coherent metric world model still emerges — a stronger emergence claim than Nanda's under partial observability.
- **Linear representation hypothesis holds for space.** Linear probes decode spatial relations near-perfectly, *matching* non-linear MLP probes → the structure is linearly encoded (no non-linear gap). Probe direction `w_i ∝ µ_i − µ_rest`.
- **The subspace mirrors R³ geometry.** Opposite relations are antipodal (`w_below ≈ −w_above`); independent relations orthogonal (`above ⊥ left`). Alignment sharpens in **deeper layers** (layer 24 best) and is only clean **after PCA projection** (e.g. `left↔right` cosine 0.96→0.999; `in-front↔behind` 0.11→0.995 at layer 24). Original-space cosines are weak (~0.4–0.5) — structure is real but low-variance, recoverable only in the right basis.
- **Compositionality = vector addition.** Composed relations approximate the sum of atomic directions (`µ_above + µ_left ≈ µ_above-left`). PCA-space alignment: 2D mean cosine 0.993 (angle 6°); 3D weaker (mean angle ~20°). Direct evidence for the frame's "complex relations = linear combinations of basis directions."
- **Objects occupy consistent positions in the same subspace.** `obj1-above` mean embedding aligns with `ŵ_above` at cosine 0.97; k-means cluster purity 77.5%; top-3 PCA dims ≈100% of variance → the model reuses one metric frame for both relations and object states (`O ⊂ S ⊂ R² ⊂ W`).
- **Causal usage test (activation steering).** Injecting a PCA-derived spatial direction into the residual stream steers the model's stated relation: **74.3% overall**. Strong asymmetry — `above/below/left` ≈100%, `right` 79%, `in-front` 62%, **`behind` 5%**. Multi-token relations ("in front of") resist steering, likely a tokenization artifact. Confirms the subspace is *used*, not merely present — but **not uniformly steerable**.

## Limitations

- Only the *static* fragment of `W`: the transition function `T` (movement, dynamics), temporal structure, and object permanence are **not tested** — the world model is spatial-but-frozen.
- Physical 3D space is the *maximally embeddable/metric* slice — says nothing about non-embeddable symbolic structure.
- Single model family (`LLaMA-3.2-3B`); limited relation set; steering asymmetry unexplained; structure visible only post-PCA (basis-dependence caveat, per Nanda).

Links: [[wiki/concepts/world-models.md]] · [[wiki/papers/emergent-linear-world-models-nanda-2023.md]] · [[wiki/concepts/latent-graph-discovery.md]] · [[wiki/queries/central-framing-epistemic-audit.md]]
