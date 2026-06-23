---
title: "Cerebellum"
type: entity
tags: [cerebellum, motor-learning, associative-memory, sdm, marr, albus, granule-cells, purkinje-cells, supervised-learning]
created: 2026-06-22
updated: 2026-06-22
sources: [kanerva-sdm-1993]
related: [wiki/entities/sdm-model.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/pattern-separation.md, wiki/concepts/associative-memory.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/hebbian-learning.md, wiki/papers/kanerva-sdm-1993.md]
---

# Cerebellum

**The cerebellar cortex implements a biological Sparse Distributed Memory (SDM) for fine motor learning: high-dimensional input expansion (granule cells) + sparse activation regulated to p_opt + supervised Hebbian write (climbing fiber error signal) + majority-vote readout (Purkinje cells).**

---

## Circuit Components

| Cell type | SDM role | Approx. count (cat) | Connectivity |
|---|---|---|---|
| **Mossy fibers** (from cortex/brainstem) | Address input **x** | ~7M | Each reaches ~450 granule cells |
| **Granule cells** | Hard locations (rows of **A**) | ~10⁹ | 3–5 mossy fiber inputs each; ~1% active |
| **Parallel fibers** (granule axons, ~3mm) | Activation broadcast | — | Each reaches ~100–500 Purkinje cells |
| **Purkinje cells** | Output units **z** | ~10⁶ | Receive ~10⁵ parallel fiber inputs each |
| **Climbing fibers** (from inferior olive) | Word-in training signal **w** | ~7M | One per Purkinje cell; strong, one-shot drive |
| **Golgi cells** | Threshold regulation → p_opt | — | Feedback inhibition on granule cells |
| **Basket/stellate cells** | Lateral inhibition | — | Enforce sparse activation via k-WTA |

---

## Mapping to SDM

| SDM component | Cerebellar analog |
|---|---|
| Hard-address matrix **A** (M rows, k=3–5 nonzeros) | Granule cell mossy-fiber random connectivity |
| Activation vector **y** (sparse, ~1%) | Granule cell firing pattern |
| Contents matrix **C** | Parallel fiber→Purkinje synaptic weights (LTD-modifiable) |
| Word-in **w** | Climbing fiber error signal from inferior olive |
| Output **z** | Purkinje cell firing rate |
| Optimal p maintenance | Golgi cells adjust granule cell threshold dynamically |

---

## Historical Models

| Model | Key claims | SDM correspondence |
|---|---|---|
| **Marr (1969)** | 7,000 mossy fibers → 200,000 codon cells → 1 Purkinje cell; dynamic threshold; codon cells = associative memory | First SDM-like cerebellar model; Golgi cells = p regulator |
| **Albus (1971) / CMAC** | Systematic cubicle-tiling address structure; continuous input variables; climbing fiber = error signal; LTD (not LTP) at parallel→Purkinje | SDM over continuous multidimensional state space; extends SDM to sensorimotor inputs |
| **Kanerva (1993)** | Unifies Marr/Albus within SDM framework; hyperplane-design variant; Golgi cells as p_opt regulator | Formal proof that cerebellar cortex is a biological SDM |

---

## Key Implication: SDM as a Domain-General Primitive

The same mathematical primitive (random expansion **A** + sparse activation at p_opt + Hebbian write **C**) underlies two biologically distinct circuits:

| System | Write mechanism | Use case | Error signal |
|---|---|---|---|
| **HC / DG→CA3** | Unsupervised outer-product Hebbian (BTSP/STDP) | Episodic memory: cue → episode completion | None (autoassociative) |
| **Cerebellar cortex** | Supervised LTD via climbing fiber error | Motor learning: context → feedforward correction | Inferior olive error |

The distinction is not architectural (both are SDM) but in the **source of the word-in signal**: in HC, the mossy fiber input is the content to store; in cerebellum, the climbing fiber carries the correction signal. A reasoning model's fast-M store can implement either mode depending on whether a supervised error is available — unsupervised for episodic binding, supervised for skill acquisition.

---

## Limitations

- Cerebellar SDM implements feedforward motor correction, not iterative pattern completion — Purkinje cells are inhibitory to deep cerebellar nuclei, creating a one-shot output rather than recurrent attractor dynamics.
- Output dimension U (~10⁶ Purkinje cells) is small relative to the mossy fiber input dimension N (~7M), matching the M >> N >> U asymmetry of CMAC rather than the N ≈ U case of episodic memory.
- No intrinsic account of temporally extended motor sequences; CMAC tiles continuous state space for instantaneous corrections, not sequential programs.

---

## Connections

- **[[wiki/entities/sdm-model.md]]** — cerebellum is the biological instantiation of the SDM hyperplane design; the Golgi cell dynamic threshold is the biological mechanism for maintaining p near p_opt that the theoretical analysis requires.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — DG→CA3 is the second biological SDM instantiation; both use k=3–5 sparse address connections per hard location; the difference is write supervision (unsupervised HC vs. climbing-fiber-supervised cerebellum), not circuit topology.
- **[[wiki/concepts/sparse-distributed-representations.md]]** — cerebellar granule cell expansion (N→M with M >> N) is the same random high-dimensional projection SDR theory formalizes; ~1% active granule cells sit in the regime where inter-pattern interference is negligible.
- **[[wiki/concepts/pattern-separation.md]]** — DG granule cells and cerebellar granule cells share the same expansion + k=3–5 sparse address design; both use threshold regulation (Golgi cells / competitive inhibition) to enforce p_opt; convergent architecture in two circuits.
- **[[wiki/concepts/associative-memory.md]]** — parallel fiber→Purkinje LTD is the supervised analog of Hebbian C-matrix updates; climbing fiber one-shot error drive mirrors the outer-product write in unsupervised SDM.
- **[[wiki/concepts/two-learning-timescales.md]]** — cerebellar A (granule cell random connectivity, fixed) / C (parallel fiber synapses, trained via LTD) is a biological realization of the slow/fast split at the level of two distinct synapse populations with physically different update rules.
- **[[wiki/papers/kanerva-sdm-1993.md]]** — primary source for the SDM cerebellar mapping; Marr (1969) and Albus (1971) as the original models; quantitative cell-count correspondence.
