---
title: "TEM (Tolman-Eichenbaum Machine)"
type: entity
tags: [model, structural-generalization, world-models, relational-memory, hippocampus]
created: 2026-06-09
updated: 2026-06-12
sources: [t-TEM, TEM]
related: [wiki/concepts/latent-graph-discovery.md, wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/path-integration.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/latent-states.md, wiki/concepts/attention.md, wiki/concepts/information-theory.md, wiki/entities/cscg-model.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/grid-cells.md, wiki/entities/place-cells.md, wiki/papers/t-tem-whittington-2022.md, wiki/papers/tem-whittington-2020.md]
---

# TEM — The Tolman-Eichenbaum Machine

**Paper:** Whittington et al., Cell 2020. Companion perspective: Whittington et al., arXiv 2022.

Neural network model of the hippocampal-entorhinal system. Learns to predict future sensory observations while navigating graph-structured environments. Core innovation: factorized structural (`g`, MEC) and sensory (`x`, LEC) codes bound conjunctively in hippocampus (`p`).

---

## Architecture

| Component | Variable | Brain | Role |
|-----------|----------|-------|------|
| Structural code | `g` | MEC (grid cells) | Abstract graph position; generalizes across environments |
| Sensory input | `x` | LEC | Current observation; environment-specific |
| Conjunctive code | `p` | HC (place cells) | Binds g × x; episodic memory |
| Slow weights | `W` | MEC plasticity | Transition rules; shared |
| Fast weights | `M` | HC synapses | Episodic bindings; per-environment |

---

## Key Results (TEM 2020)

- Zero-shot first-presentation inference on transitive inference, social hierarchies, 2D spatial graphs
- Spontaneous emergence of grid cells, band cells, border cells, OVCs — all from path-integration objective, no supervision
- Non-random hippocampal remapping predicted and verified (Barry 2012, Chen 2018 data)
- Non-spatial hippocampal cells (spatial, chunking, counting) reproduced (Sun et al., 2020)

## Novel Results (Perspective 2022)

Using TEM to formally unify non-spatial hippocampal cell types as latent state representations:

| Task | Cell type | TEM account |
|------|-----------|-------------|
| T-maze alternation | Splitter cells | Latent "big-loop" dimension |
| 4-lap reward task | Lap-specific cells | Latent lap counter |
| Tower accumulation | Evidence cells | Position × evidence latent space |

TEM learns *both* spatial and non-spatial cells simultaneously — both are needed for full generalization.

---

## TEM-t (Transformer Reformulation)

Whittington et al. (ICLR 2022) [[wiki/papers/t-tem-whittington-2022.md]] show TEM is a causal transformer with learned recurrent positional encodings:

| TEM | Transformer (TEM-t) |
|-----|---------------------|
| Path integration `g_{t+1} = σ(g_t W_a)` | Recurrent positional encoding |
| Outer-product memory `p = flatten(x̃ᵀ g̃)` | Key-value memory |
| Hopfield retrieval `q M` | Dot-product self-attention |
| Linear Hopfield (TEM) / softmax (TEM-t) | — |

**TEM-t** (softmax Hopfield) converges at ~20k gradient steps vs. TEM's ~50k and handles larger environments TEM cannot fit in memory. The performance gap confirms the transformer framing is a genuine architectural improvement, not just reformulation.

---

## TEM + CSCG Integration (Proposed)

TEM handles structural generalization; CSCG handles fast local map learning in novel environments. Both use multiple clone hippocampal cells per observation → easy to combine formally. Proposed: TEM-like model where HC is additionally predictive of future HC states. Not yet implemented.

## Limitations

- Requires clean (observation, action) pairs — no structure discovery from raw data
- Slow W learning uses backprop — biologically implausible; leading candidate replacement is theta-phase error-driven learning (CLS 2011, [[wiki/papers/cls-oreilly-2011.md]]: 4–8 Hz minus/plus phase delta rule in HC), but the W update at cortical timescale remains unresolved
- Tested on graphs up to 127 nodes; scaling unknown

---

## Connections

- **[[wiki/concepts/structural-generalization.md]]** — TEM is the reference proof-of-concept; it demonstrates that the five minimal ingredients produce zero-shot structural generalization empirically.
- **[[wiki/concepts/factorized-representations.md]]** — TEM's g/x/p + W/M architecture is the factorized representation instantiated; every design choice in TEM follows from the factorization principle.
- **[[wiki/concepts/two-learning-timescales.md]]** — TEM implements the two-timescale split concretely; W (slow backprop across environments) and M (fast Hebbian per environment) are TEM's variables, not abstractions.
- **[[wiki/entities/cscg-model.md]]** — complementary model: CSCG handles the novel-environment regime that TEM's slow W cannot immediately address; a unified model combining both is proposed but not yet built.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — TEM is a computational model of this biological system; understanding TEM requires knowing which component maps to which brain region.
- **[[wiki/concepts/attention.md]]** — TEM-t is TEM rewritten as a transformer; the Hopfield ↔ attention equivalence is the mathematical bridge, and TEM-t's performance gains confirm the transformer framing as an architectural improvement.
- **[[wiki/papers/t-tem-whittington-2022.md]]** — source for TEM-t; provides the full derivation of TEM as a transformer and the performance comparisons.
- **[[wiki/concepts/information-theory.md]]** — TEM's training objective is cross-entropy minimization over sensory predictions; the KL-to-cross-entropy equivalence explains why code uses cross-entropy loss despite the theory framing learning as KL divergence minimization.
- **[[wiki/papers/tem-whittington-2020.md]]** — primary source paper; foundational Cell 2020 results for structural generalization, emergent cell types, and zero-shot inference on transitive/social hierarchy tasks.
- **[[wiki/concepts/latent-graph-discovery.md]]** — TEM is the reference implementation of two-level latent graph discovery: W encodes the meta-graph, M encodes the instance-graph, and the g/x/p factorization solves two-level entanglement; TEM's limitations (pre-given action vocabulary, flat hierarchy) mark the open frontiers of the latent graph discovery problem.
