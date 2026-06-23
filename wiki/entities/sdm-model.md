---
title: "SDM (Sparse Distributed Memory)"
type: entity
tags: [sdm, associative-memory, sparse-coding, capacity, hebbian, random-projection, kanerva]
created: 2026-06-22
updated: 2026-06-22
sources: [kanerva-sdm-1993]
related: [wiki/entities/cerebellum.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/associative-memory.md, wiki/concepts/pattern-separation.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/factorized-representations.md, wiki/entities/vector-hash-model.md, wiki/papers/kanerva-sdm-1993.md]
---

# SDM (Sparse Distributed Memory)

**Kanerva's 1988 model of human long-term memory as a two-layer feedforward network with a fixed random-projection address layer (A) and a modifiable counter-based content layer (C); generalizes both Hopfield networks and correlation-matrix memories, with capacity independent of input dimension.**

---

## Architecture

| Component | Symbol | Dimensions | Role |
|---|---|---|---|
| Hard-address matrix | **A** | M × N, binary ±1 | Fixed random scaffold; each row is one hard location's address |
| Query address | **x** | N-bit ±1 | Input pattern activating nearby hard locations |
| Activation vector | **y** | M-bit, sparse | y_m = 1 iff Hamming(**A**_m, **x**) ≤ H; only p×M locations active |
| Contents matrix | **C** | M × U, integer counters | Modifiable memory; initialized to 0 |
| Word-in vector | **w** | U-bit ±1 | Pattern to store |
| Sum vector | **s** | U integers | **s** = **C**ᵀ**y** (weighted sum over active locations) |
| Output | **z** | U-bit ±1 | **z** = sign(**s**) (majority vote) |

**Storage:** **C** += **y** · **w**ᵀ (outer-product Hebbian increment; +1 for each active-location/1-bit pair, −1 for 0-bit)  
**Retrieval:** **z** = sign(**C**ᵀ**y**)

---

## Key Parameters and Results

| Quantity | Formula | Sample values (M=10⁶, T=10⁴) |
|---|---|---|
| Activation probability | p = P(Hamming(**A**_m, **x**) ≤ H) | Chosen to match p_opt |
| Optimal p | p_opt = (2MT)^{−1/3} | ≈ 0.037% → ~370 active locations |
| Asymptotic capacity | τ = T_max/M ≈ 0.1 | At φ=0.99: T_max ≈ 10⁵ for M=10⁶ |
| Signal | μ = pM | ~370 aligned votes for target |
| Noise variance | σ² ≈ pM(1 + p²MT) | ~370 + small cross-talk |

Keeler (1988): SDM capacity per storage element equals Hopfield (~0.14N); but SDM's τ is **N-independent** — doubling M doubles T_max without requiring larger patterns.

---

## Comparison to Related Models

| Model | Capacity | N-dependence | Sequential? | Biological mapping |
|---|---|---|---|---|
| RAM (H=0, M=2^N) | 1 per location | None (all addresses enumerated) | No | — |
| Hopfield (1982) | ~0.14N | Bounded by N | No | CA3 recurrent collaterals |
| Correlation-matrix (Anderson/Kohonen) | ~N | Bounded by N | No | Heteroassociative cortex |
| **SDM (basic)** | **~0.1M** | **None (M free)** | Via pointer chains | DG→CA3; cerebellar cortex |
| DNC (Graves 2016) | N expandable locations | None | Via temporal link matrix | HC/PFC external memory |
| Vector-HaSH | ⟨K⟩^M | None | Via shift operator | Grid/HC circuit |

---

## Variants

| Variant | Key change | Biological analog |
|---|---|---|
| **Hyperplane design** (Jaeckel 1989) | k=3–5 nonzero entries per **A**_m row; activate iff all match | Cerebellar/DG granule cells (3–5 mossy fiber inputs) |
| **Marr (1969)** | Sparse **A**; dynamic threshold via Golgi-cell equivalent; 200,000 granule cells per Purkinje cell | Cerebellar cortex (fully specified model) |
| **Albus CMAC (1971)** | Systematic cubicle tiling over continuous N-dimensional state space; error-correction learning via climbing fibers | Motor learning from continuous joint-angle inputs |

---

## For Building a Reasoning Model

- The fixed-**A** / variable-**C** decomposition licenses a design choice: the address projection into fast-M space should be fixed randomly after initialization, not trained — it provides near-orthogonal addressing for any uniform random distribution; only **C** needs episodic writes.
- τ ≈ 0.1 is the **operational capacity limit**: a reasoning model's fast-M store must monitor episode count against this limit and trigger consolidation (SWR replay) before T approaches 0.1M.
- The hyperplane-design A (k=3–5 active inputs per hard location) is more metabolically efficient and matches the observed granule cell wiring economy; conjunction-detection rather than distance-ball activation is biologically preferred.

---

## Connections

- **[[wiki/concepts/sparse-distributed-representations.md]]** — SDM is the formal architecture for SDR computation: **A** implements random expansion, **y** implements sparse threshold activation at p_opt, **C** implements Hebbian write; the false-positive hypergeometric bound and SDM capacity formula τ≈0.1 are complementary descriptions of the same interference-avoidance geometry.
- **[[wiki/concepts/associative-memory.md]]** — SDM generalizes both Hopfield (H=0, M=2^N) and correlation-matrix memories as special cases; Keeler (1988) establishes capacity equivalence per storage element, but SDM's M-based capacity is N-independent, enabling hardware-scalable episodic memory without increasing pattern dimensionality.
- **[[wiki/concepts/pattern-separation.md]]** — DG→CA3 is a biological SDM using the hyperplane design: granule cells = hard locations, mossy fiber random k-connectivity = sparse **A** rows, k-WTA inhibition = p_opt regulation, mossy fiber→CA3 Hebbian synapses = **C** writes.
- **[[wiki/concepts/two-learning-timescales.md]]** — fixed **A** (structural scaffold, initialized once) = slow-W analog; modifiable **C** (episodic content) = fast-M; this is the most explicit circuit-level implementation of the two-timescale split — not just "slow weights vs. fast activations" but two distinct synapse populations with different update rules.
- **[[wiki/concepts/factorized-representations.md]]** — SDM's A/C split is a third factorization axis (address scaffold vs. content) nested within Vector-HaSH's scaffold/content split and TEM's structural/sensory split; SDM proves the random scaffold does not need to be trained — random A already provides near-orthogonal addressing.
- **[[wiki/entities/cerebellum.md]]** — cerebellar cortex is a biological SDM (hyperplane/Marr variant): granule cells = hard locations, parallel fiber→Purkinje synapses = **C**, climbing fibers = word-in signal; Golgi cells maintain p near p_opt dynamically; confirms the SDM primitive is domain-general (episodic HC vs. motor cerebellum).
- **[[wiki/entities/vector-hash-model.md]]** — Vector-HaSH's fixed random grid→HC projection is functionally **A**; its plastic HC↔cortex heteroassociative layer is functionally **C**; SDM provides the mathematical basis for why the scaffold projection does not require learned geometry.
- **[[wiki/papers/kanerva-sdm-1993.md]]** — primary source: full capacity analysis, optimal p_opt derivation, neural network equivalence, cerebellar mapping, and Jaeckel/CMAC hyperplane variants.
