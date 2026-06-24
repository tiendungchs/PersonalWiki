---
title: "Attention Is All You Need — Vaswani et al., NeurIPS 2017"
type: paper
tags: [attention, transformer, multi-head-attention, positional-encoding, sequence-transduction]
created: 2026-06-23
updated: 2026-06-23
sources: [Attention Is All You Need]
related: [wiki/concepts/attention.md, wiki/entities/transformer-model.md, wiki/concepts/binding-problem.md, wiki/concepts/compositional-generalization.md, wiki/concepts/structural-generalization.md, wiki/concepts/associative-memory.md]
---

# Attention Is All You Need — Vaswani et al., NeurIPS 2017

Vaswani, Shazeer, Parmar, Uszkoreit, Jones, Gomez, Kaiser & Polosukhin. *Advances in Neural Information Processing Systems*, 2017.

---

## Key Computational Insights

- **Scaled Dot-Product Attention** — `Attention(Q,K,V) = softmax(QK^T / √d_k) V`. The `√d_k` scaling prevents the dot products from saturating the softmax into vanishing-gradient regions at large key dimensionality; without it, additive attention outperforms dot-product attention for large d_k.

- **Multi-Head Attention** — projecting Q, K, V into h=8 independent subspaces (d_k=d_v=64 each) and concatenating outputs costs the same FLOPs as single-head attention at full d_model=512, but allows the model to jointly attend to different representation subspaces at each position. Individual heads specialize without explicit supervision: head 5 resolves anaphora, others track long-range syntactic dependencies (Figures 3–5).

- **O(1) maximum path length** — any two positions interact in a single self-attention step (O(1) sequential ops, O(1) max path), vs. O(n) for recurrent layers and O(log_k n) for dilated convolutions. This is the core architectural argument for why attention supports long-range binding where recurrence fails.

- **Sinusoidal positional encodings** — `PE(pos, 2i) = sin(pos / 10000^{2i/d_model})`, `PE(pos, 2i+1) = cos(...)`. Sinusoidal chosen over learned embeddings because it may extrapolate to longer sequences; ablation (Table 3, row E) shows near-identical results. Key implication: position representation form is not the binding bottleneck — what matters is the structural information encoded.

- **Feed-forward sublayer as position-wise transformation** — `FFN(x) = max(0, xW₁ + b₁)W₂ + b₂` applied identically and independently at each position; inner dimension d_ff=2048 (4× d_model). This is the compute-per-position budget that attention routing feeds into; the two-sublayer structure (attention → FFN) cleanly separates relational routing from per-position processing.

---

## Limitations

- **O(n²·d) complexity**: quadratic in sequence length; prohibitive for very long sequences; directly maps to WM capacity constraints in the reasoning model context.
- **Absolute positional encodings**: sinusoidal encodings represent linear sequence order, not task-structural (non-Euclidean) graph order; structural generalization to new graph topologies requires learned recurrent encodings (TEM-t).
- **Localism failure**: global receptive field is a structural liability for sub-expression-local processing — the one compositional facet where Transformer underperforms convolutional models (Hupkes 2020).

---

## Links

- [[wiki/concepts/attention.md]] — primary concept page; Hopfield↔attention equivalence, multi-head formalism, complexity table
- [[wiki/entities/transformer-model.md]] — Transformer as an entity; architecture table, key results, comparison to TEM-t
- [[wiki/concepts/binding-problem.md]] — O(1) max path length is the transformer's key structural contribution to long-range feature binding
- [[wiki/concepts/compositional-generalization.md]] — localism failure; global receptive field as the limiting facet
- [[wiki/concepts/structural-generalization.md]] — sinusoidal positional encodings as the mechanism that fails on non-Euclidean task structure
- [[wiki/concepts/associative-memory.md]] — softmax = Boltzmann distribution; Hopfield ↔ attention derivation grounds the formalism
