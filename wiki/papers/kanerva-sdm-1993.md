---
title: "Sparse Distributed Memory and Related Models — Kanerva 1993"
type: paper
tags: [sdm, associative-memory, cerebellum, pattern-separation, sparse-coding, capacity, random-projection]
created: 2026-06-22
updated: 2026-06-22
sources: [kanerva-sdm-1993]
related: [wiki/entities/sdm-model.md, wiki/entities/cerebellum.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/associative-memory.md, wiki/concepts/pattern-separation.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/factorized-representations.md]
---

# Sparse Distributed Memory and Related Models — Kanerva 1993

**Citation:** Kanerva, P. (1993). "Sparse Distributed Memory and Related Models." In M.H. Hassoun (ed.), *Associative Neural Memories: Theory and Implementation*, pp. 50–76. Oxford University Press. (Revised 2002.)

---

## Key Computational Insights

- **SDM as generalized RAM:** Rather than exact-address activation (H=0), Sparse Distributed Memory (SDM) activates all M hard locations within Hamming radius H of query **x**; storage increments/decrements counter rows of **C** for every active location; retrieval pools all active counters via majority vote. Formally equivalent to outer-product Hebbian learning on a random-projection basis: **C = YᵀW** where **Y** is the sparse activation matrix.
- **Quantitative capacity analysis:** Signal-to-noise ratio μ/σ is maximized at optimal activation probability p_opt = (2MT)^{−1/3}; gives asymptotic capacity τ = T_max/M ≈ 0.1 (fidelity φ ≥ 0.99). Keeler (1988) proves this equals Hopfield capacity per storage element (~0.14N) — but SDM's τ is *independent of address dimension N*. Doubling M (hardware) doubles T_max without requiring larger patterns.
- **Fixed-A / variable-C as circuit-level slow/fast factorization:** Hard-address matrix **A** is sampled at random once and never modified (structural projection); only contents **C** is written per episode (episodic content). This is the two-timescale factorization instantiated at individual synapse populations — the most concrete biological instantiation of the slow-W/fast-M split.
- **Cerebellar cortex as biological SDM:** Mossy fibers (N=millions) → granule cells (M=billions, ~1% active) → parallel fiber→Purkinje synapses (**C**); climbing fibers carry the "word-in" training signal paired one-to-one with Purkinje cells. Golgi cells dynamically regulate the granule cell firing threshold to maintain p near p_opt — biological optimization of the theoretical activation probability. The same SDM primitive implements *two* distinct learning systems: hippocampal episodic memory (unsupervised Hebbian) and cerebellar motor learning (climbing-fiber-supervised).
- **Hyperplane design (Jaeckel/Marr/Albus CMAC):** With only k=3–5 nonzero entries per row of **A** (matching granule cell mossy fiber count), activation becomes a conjunction detector rather than Hamming-distance ball. Same p_opt; biologically realizable at zero learning cost for the address structure. Albus' CMAC extends this to continuous multidimensional inputs via systematic cubicle tiling — the earliest sensorimotor SDM model.

---

## Limitations

- Capacity formula assumes uniform random data; performance degrades with clustered inputs unless **A** is adapted to the data distribution.
- Sequential memory requires explicit pointer chains (address of pattern t stores t+1) — no structured asymmetric weights as in DenseNet/SeqNet.
- Hyperplane design (sparse **A**, k=3–5) has less complete theoretical analysis than the Hamming-ball design; dynamic threshold (Golgi cell) is required to maintain constant p.

---

## Links

- [[wiki/entities/sdm-model.md]] — full architecture table, capacity results, variant comparison
- [[wiki/entities/cerebellum.md]] — biological mapping: granule cell / Purkinje cell / climbing fiber correspondence
- [[wiki/concepts/sparse-distributed-representations.md]] — SDR scaling laws as the dendritic-segment view of the same interference-avoidance geometry; p_opt connects to NMDA threshold predictions
- [[wiki/concepts/associative-memory.md]] — SDM as the unifying framework generalizing Hopfield and correlation-matrix memories; Keeler capacity equivalence
- [[wiki/concepts/pattern-separation.md]] — DG→CA3 as biological SDM hyperplane design; quantitative mapping of granule cells to hard locations
- [[wiki/concepts/two-learning-timescales.md]] — fixed **A** / variable **C** as circuit-level instantiation of slow-W/fast-M split
- [[wiki/concepts/factorized-representations.md]] — SDM address scaffold vs. content as a third factorization axis nested within TEM's structural/sensory and Vector-HaSH's dynamics/content splits
