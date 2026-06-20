---
title: "Relating Transformers to Models and Neural Representations of the Hippocampal Formation"
type: paper
tags: [transformer, TEM, attention, place-cells, grid-cells, positional-encodings, hippocampus]
created: 2026-06-12
updated: 2026-06-12
sources: [t-TEM]
related: [wiki/entities/tem-model.md, wiki/concepts/attention.md, wiki/concepts/factorized-representations.md, wiki/concepts/path-integration.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md]
---

# Relating Transformers to Models and Neural Representations of the Hippocampal Formation

Whittington, Warren & Behrens. *ICLR 2022*.

---

## Key Computational Insights

- **TEM memory retrieval = transformer self-attention.** The Hopfield attractor step `q M = q Σ pᵀp` is dot-product attention without the softmax. Keys/queries are the structural code `g̃`; values are the sensory code `x̃`. This follows by derivation from the outer-product memory structure `p = flatten(x̃ᵀ g̃)`, not analogy. Replacing linear Hopfield with softmax Hopfield gives TEM-t, which is a standard causal transformer.
- **Path integration `g` = learned recurrent positional encodings.** `g_{t+1} = σ(g_t W_a)` is a recurrently generated position encoding that learns the transition structure of the task (spatial topology, relational rules, grammar). Unlike fixed sinusoidal encodings, these adapt on-the-fly to any new environment traversal — the encoding inferred depends on the sequence of actions taken, not absolute sequence index.
- **TEM-t substantially outperforms TEM.** Convergence at ~20k gradient steps vs. TEM's ~50k; handles larger environments that exceed TEM's memory capacity. The performance gap is not just speed — TEM-t can solve problems TEM cannot, validating the architectural improvement.
- **Place cells = sparse Hopfield memory neurons.** Splitting self-attention into feature neurons (g̃, x̃) and memory neurons (softmax output layer) yields memory neurons that are sparsely activated, spatially tuned, and remap randomly between environments — matching hippocampal place cell properties without any additional biological assumptions.
- **Hippocampal indexing theory instantiated.** Hippocampus binds cortical representations across multiple brain areas (g̃, x̃, and any further c̃). Each new cortical region adds only n_c feature neurons; hippocampal memory neuron count stays fixed. Any cortical subset can reinstate the others via the index.

---

## Limitations

- TEM-t still requires clean `(observation, action)` pairs; no raw sensory stream.
- Performance comparison uses unoptimized TEM reference code — difference is qualitative, not a rigorous benchmark.
- Grammar/language-as-structural-positional-encoding is speculative; no language experiments conducted.

---

- [[wiki/entities/tem-model.md]] — TEM-t is TEM rewritten as a transformer; paper provides the formal derivation
- [[wiki/concepts/attention.md]] — the paper establishes the Hopfield ↔ attention correspondence at the core of this concept page
- [[wiki/concepts/path-integration.md]] — path integration is learned recurrent positional encoding; same equation, different framing
- [[wiki/entities/place-cells.md]] — memory neurons in the transformer correspond to place cells; paper provides the mechanistic account
- [[wiki/entities/hippocampal-entorhinal-system.md]] — hippocampal indexing theory instantiation and scaling argument
