---
title: "Transformer"
type: entity
tags: [transformer, attention, sequence-transduction, multi-head-attention, positional-encoding]
created: 2026-06-23
updated: 2026-06-23
sources: [Attention Is All You Need]
related: [wiki/concepts/attention.md, wiki/concepts/structural-generalization.md, wiki/concepts/compositional-generalization.md, wiki/concepts/binding-problem.md, wiki/concepts/associative-memory.md, wiki/concepts/working-memory.md, wiki/concepts/canonical-microcircuit.md, wiki/entities/tem-model.md, wiki/papers/vaswani-attention-2017.md, wiki/papers/t-tem-whittington-2022.md]
---

# Transformer

Sequence transduction model based entirely on self-attention, eliminating recurrence and convolution. Introduced by Vaswani et al. 2017 as the dominant NLP architecture; now foundational across modalities.

---

## Architecture

| Component | Base | Big |
|-----------|------|-----|
| Encoder/Decoder layers N | 6 | 6 |
| d_model | 512 | 1024 |
| d_ff (feed-forward inner) | 2048 | 4096 |
| Attention heads h | 8 | 16 |
| d_k = d_v per head | 64 | 64 |
| Dropout P_drop | 0.1 | 0.3 |
| Parameters | 65M | 213M |

Each layer = Multi-Head Self-Attention → Add & LayerNorm → Position-wise FFN → Add & LayerNorm.

**Multi-Head Attention:**
```
MultiHead(Q,K,V) = Concat(head₁,...,headₕ) W^O
headᵢ = Attention(Q W^Q_i, K W^K_i, V W^V_i)
Attention(Q,K,V) = softmax(QK^T / √d_k) V
```

**Complexity vs. alternatives (Table 1, Vaswani 2017):**

| Layer Type | Complexity/layer | Sequential ops | Max path length |
|------------|-----------------|----------------|-----------------|
| Self-Attention | O(n²·d) | O(1) | O(1) |
| Recurrent | O(n·d²) | O(n) | O(n) |
| Convolutional | O(k·n·d²) | O(1) | O(log_k n) |

---

## Key Results

| Task | Score | Cost (FLOPs) |
|------|-------|--------------|
| WMT 2014 EN-DE (big) | 28.4 BLEU | 2.3×10¹⁹ |
| WMT 2014 EN-FR (big) | 41.8 BLEU | 2.3×10¹⁹ |
| WSJ constituency parsing (semi-sup.) | 92.7 F1 | — |

Surpassed all previous models including ensembles at a fraction of training cost. EN-DE big model trained in 3.5 days on 8 P100 GPUs.

---

## Limitations

- **O(n²) context cost** maps directly to WM capacity constraints: reasoning over long interaction sequences is architecturally expensive.
- **Sinusoidal positional encodings** assume linear Euclidean sequence order — fail for non-Euclidean graph structures; TEM-t fixes this with learned recurrent structural encodings.
- **Localism failure** (Hupkes 2020): global receptive field processes sub-expressions in full-sequence context, not in isolation; this is the one compositional facet where Transformer underperforms convolutional alternatives.
- No explicit compositional structure; binds representations via attention weights that are learned end-to-end, with no inductive bias toward systematic compositionality.

---

## Comparison to TEM-t

| Dimension | Transformer (Vaswani 2017) | TEM-t (Whittington 2022) |
|-----------|---------------------------|--------------------------|
| Q, K source | Arbitrary learned projections | Q=K=f(g) (structural code, MEC) |
| V source | Arbitrary learned projection | V=f(x) (sensory code, LEC) |
| Positional encoding | Fixed sinusoidal (sequence order) | Learned recurrent g (graph topology) |
| Structural generalization | Fails on novel graph structure | Succeeds (derivable from factorization) |
| Memory neurons | Implicit (softmax output) | Explicit place-cell interpretation |

---

## Connections

- **[[wiki/concepts/attention.md]]** — the Hopfield↔attention equivalence and multi-head formalism are the theoretical grounding for the Transformer's associative memory interpretation; this entity page is the engineering instantiation of that concept.
- **[[wiki/concepts/structural-generalization.md]]** — standard Transformer fails structural generalization because sinusoidal encodings capture linear sequence order not graph topology; TEM-t's learned recurrent encodings are the fix.
- **[[wiki/concepts/compositional-generalization.md]]** — Transformer leads 4 of 5 compositional facets (Hupkes 2020) but fails localism; global receptive field is the structural reason for this failure mode.
- **[[wiki/concepts/binding-problem.md]]** — O(1) maximum path length means any two positions can interact in a single step; this is the Transformer's key structural contribution to solving the feature-binding problem for long-range dependencies.
- **[[wiki/concepts/associative-memory.md]]** — softmax is a Boltzmann distribution over similarity scores (= −energy); the Transformer is a modern Hopfield network operating in the high-capacity regime (Ramsauer 2020).
- **[[wiki/concepts/working-memory.md]]** — context window is the WM capacity budget; O(n²) attention complexity is the architectural constraint that maps to biological WM capacity limits.
- **[[wiki/concepts/canonical-microcircuit.md]]** — individual attention heads specialize to distinct functional roles (anaphora, syntactic dependency) without explicit supervision, analogous to functional column specialization within the canonical microcircuit.
- **[[wiki/entities/tem-model.md]]** — TEM-t rewrites TEM as a constrained Transformer (Q=K=f(g), V=f(x)); the Vaswani architecture is the starting point from which TEM-t's structural factorization is derived.
- **[[wiki/papers/vaswani-attention-2017.md]]** — primary source; paper stub with the five key computational insights.
- **[[wiki/papers/t-tem-whittington-2022.md]]** — shows that the Transformer with learned structural positional encodings is TEM; the Hopfield↔attention derivation completes the hippocampus ↔ Transformer equivalence.
