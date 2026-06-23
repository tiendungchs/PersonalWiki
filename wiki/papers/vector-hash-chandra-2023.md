---
title: "High-capacity flexible hippocampal associative and episodic memory enabled by prestructured spatial representations — Chandra, Sharma, Chaudhuri & Fiete, bioRxiv 2023"
type: paper
tags: [associative-memory, episodic-memory, hippocampus, grid-cells, factorized-representations, capacity, sequence-memory]
created: 2026-06-22
updated: 2026-06-22
sources: [High-capacity flexible hippocampal associative and episodic memory enabled by prestructured "spatial" representations]
related: [wiki/entities/vector-hash-model.md, wiki/concepts/associative-memory.md, wiki/concepts/factorized-representations.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/grid-cells.md, wiki/papers/podlaski-context-modular-memory-2025.md]
---

# Vector-HaSH — Chandra, Sharma, Chaudhuri & Fiete (bioRxiv 2023)

Chandra S, Sharma S, Chaudhuri R, Fiete IR. "High-capacity flexible hippocampal associative and episodic memory enabled by prestructured 'spatial' representations." *bioRxiv* 2023.11.28.568960.

---

## Five Key Computational Insights

- **Scaffold/content factorization solves the memory cliff.** The grid-hippocampal circuit forms a content-free scaffold: fixed random projections from MEC grid cells to HC, plus a fixed return projection learned once from early spatial exploration, generate K^M stable attractor states where K is the number of phases per grid module and M is the number of modules. A separate plastic HC↔neocortex heteroassociation layer stores sensory content without ever touching the scaffold weights. Adding new memories perturbs content weights but not scaffold dynamics → no cliff, graceful degradation instead.

- **Exponential capacity at linear network cost.** M grid modules × K phases per module → K^M scaffold fixed points; required HC cell count scales only O(M) — logarithmically with the number of fixed points. All basins are convex, uniform in size, and there are no spurious attractors. This does not violate classical Hopfield bounds because the fixed points are content-free (not user-defined).

- **Strong generalization from the metric structure of grid phases.** Scaffold weights need only be learned from O(MK_max) states — a vanishing fraction of K^M total states — visited in a metric (contiguous) order (e.g., traversal of a small spatial region). The ordered topology of grid phase space is the essential ingredient: replacing grid phases with random fixed patterns of identical sparsity destroys strong generalization, requiring exponentially many training examples.

- **Episodic/sequence memory via low-dimensional vector transitions.** Sequencing is abstracted into shift operations on the 2D torus of grid phases (the velocity integration mechanism), then heteroassociated with sensory content at each step. Hopfield-based sequence models fail at ~50 steps; Vector-HaSH sequences are limited only by heteroassociative capacity, which degrades gracefully.

- **Memory palace as second-order scaffolding.** Previously learned spatial sequences (location-landmark associations) serve as a scaffold for new non-spatial content: recalled (even approximate) landmark sensory states are heteroassociated with new neocortical items. Because landmark recall is reliable even when imprecise, the associated new items are recalled with high fidelity far into the memory continuum. First circuit account of the method of loci technique.

---

## Limitations

- HC modeled as a uniform population; no subregional specificity (CA3/CA1/DG roles unaccounted).
- Grid modules assumed independent; cross-module correlations and grid phase drift not modeled.
- The MLP mapping from HC state to grid velocity (sequence stepping mechanism) lacks a specified biological substrate.

---

## Links to Wiki Pages

- **[[wiki/entities/vector-hash-model.md]]** — full architecture table, key results, comparison to Hopfield and related models
- **[[wiki/concepts/associative-memory.md]]** — scaffold/content factorization resolves the memory cliff; exponential fixed-point capacity section
- **[[wiki/concepts/factorized-representations.md]]** — second factorization axis (scaffold/content) orthogonal to TEM's g/x/p split
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — Vector-HaSH as circuit model of the MEC-HC system
- **[[wiki/entities/grid-cells.md]]** — grid modules as pre-structured hash space; strong generalization property
- **[[wiki/papers/podlaski-context-modular-memory-2025.md]]** — neighbor: both exceed Hopfield cliff via complementary mechanisms (gating vs. scaffold)
