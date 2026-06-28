---
title: "Temporal Multiplexing"
type: concept
tags: [temporal-multiplexing, multi-stream, connectome, timescales, ICN, parallel-processing, co-activation, frequency-bands]
created: 2026-06-27
updated: 2026-06-27
sources: [alderson-2026-multiscale-connectome]
related:
  - wiki/concepts/cortical-traveling-waves.md
  - wiki/concepts/criticality.md
  - wiki/concepts/two-learning-timescales.md
  - wiki/concepts/working-memory.md
  - wiki/concepts/canonical-microcircuit.md
  - wiki/entities/default-mode-network.md
  - wiki/entities/ms-ssm-model.md
  - wiki/papers/alderson-2026-multiscale-connectome.md
---

# Temporal Multiplexing

**The brain's large-scale functional connectome operates as multiple parallel, asynchronous processing streams at distinct intrinsic timescales — from ~20 ms (γ-band) to ~3000 ms (infraslow fMRI) — each governed by the same shared spatial vocabulary (ICN combinations) and the same transition grammar, yet running independently rather than as slowed/filtered versions of a single stream.**

---

## Core Evidence (Alderson et al. 2026)

| Timescale | Neural substrate | State lifetime |
|---|---|---|
| γ-band EEG | Superficial feedforward layers | ~20 ms |
| β-band EEG | Deep feedback layers | ~100–200 ms |
| α-band EEG | Mixed, visual/parietal | ~200–400 ms |
| θ-band EEG | Hippocampal/limbic-coupled | ~400–700 ms |
| δ-band EEG | Slow cortical potentials | ~700–2000 ms |
| Infraslow fMRI | Whole-cortex BOLD | ~3000 ms |

Six streams coexist. State lifetimes span >3 orders of magnitude. Crucially, identical blueprints at different timescales are **temporally asynchronous** — overlap is at chance (t(25) = 0.04–1.09, all p > 0.05/15).

---

## ICN Combinatorial State Space

7 canonical ICNs (VIS, SMN, DAN, VAN, LIM, FPN, DMN) → 126 blueprints (all non-empty subsets up to 6 ICNs):

$$N_{\text{states}} = \sum_{k=1}^{6} \binom{7}{k} = 126$$

Key properties:
- **Single-ICN states rare**: only ~12.2% of total dwell time
- **Multi-ICN states dominate**: brain exploits nearly full combinatorial space
- **DMN × task-positive frequent**: states #118 (DMN+FPN+VAN+DAN) and #126 (DMN+all-task-positive) are among the most expressed, contradicting strict anti-correlation models
- **Gradual transitions favored**: ~70% of transitions change by exactly 1 ICN; ~10% large jumps enabling efficient coverage of the state space

---

## Timescale-Overarching Principles

**Spatial principle**: the same 126-blueprint vocabulary fits all timescales above both null models (spatial shuffle and phase permutation), replicated in 3 independent datasets.

**Temporal principle**: transition probability matrix correlations across timescale pairs:

| Pair | Correlation |
|---|---|
| EEG band pairs | r = 0.90–0.96 |
| fMRI ↔ EEG | r = 0.62–0.67 |

Fractional occupancy "skylines" also preserved (r = 0.85–0.93 within EEG; r = 0.42–0.49 between fMRI and EEG).

→ A speed-invariant transition grammar governs state sequences regardless of which timescale is observed.

---

## Laminar Basis

| Stream speed | Dominant layer | Functional role |
|---|---|---|
| Fast (γ, β-high) | Superficial (L2/3) | Feedforward, sensory-driven |
| Slow (β-low, α, δ) | Deep (L5/6) | Feedback, prediction, context |

This maps onto the **Canonical Microcircuit** feedforward (superficial) vs. feedback (deep) architecture — temporal multiplexing is structurally grounded in laminar anatomy, not merely a functional phenomenon.

---

## Open Problems

1. Do timescale-overarching principles hold under task conditions, or are they rest-specific?
2. What mechanism enforces the shared transition grammar across timescales — is it the structural connectome topology, neuromodulatory gating, or an intrinsic attractor landscape?
3. Can the laminar distinction (fast/superficial vs. slow/deep) be exploited in ML architectures (e.g., separate feedforward and feedback streams with different temporal constants)?
4. Is the ICN combinatorial state space (126 blueprints) the right granularity, or would a finer parcellation reveal richer structure?

---

## Design Implications for Reasoning Models

| Biological principle | ML analog |
|---|---|
| Parallel asynchronous streams | Multi-timescale RNN with separate fast/slow units (e.g., MS-SSM, clockwork RNN) |
| ICN combinatorial state space | Module binding: model state = combination of independently active modules, not single winner-takes-all |
| Speed-invariant transition grammar | Shared transition parameters across timescale modules (weight tying or shared latent dynamics) |
| ~70% single-ICN-change transitions | Incremental state updates by design — small Hamming-distance steps preferred |
| DMN × task-positive co-activation | No architectural hard anti-correlation constraint; allow flexible integration across all module pairs |
| Laminar fast/slow substrate | Hierarchical stack with per-layer timescale constants: shallow layers = fast, deep layers = slow |

**(brainstorm)** A reasoning architecture that processes information at multiple timescales simultaneously — where each timescale module applies the same high-level state transition grammar but at its own intrinsic speed — may naturally support both rapid reflexive responses (fast streams) and slow deliberative reasoning (slow streams) without mode-switching overhead. The shared ICN vocabulary plays the role of a common representational format across streams.

---

## Connections

- **[[wiki/concepts/cortical-traveling-waves.md]]** — frequency-specific (alpha/beta) instrength subnetworks are the structural backbone for frequency-specific connectome streams; traveling wave direction and speed are per-frequency properties, making this the complementary structural mechanism for temporal multiplexing
- **[[wiki/concepts/criticality.md]]** — near-critical metastability is the operating regime enabling a large repertoire of transient ICN co-activation states; temporal multiplexing requires this regime to prevent any single stream from locking the system into a fixed attractor
- **[[wiki/concepts/two-learning-timescales.md]]** — slow W (structural, across environments) + fast M (episodic, within session) is the learning analog of temporal multiplexing; both principles assert that concurrent multi-timescale processes are the rule, not the exception
- **[[wiki/concepts/working-memory.md]]** — multi-timescale WM mechanisms (SFA traces, attractor dynamics, STSP) are the local node-level instantiations of the global temporal multiplexing picture; WM concepts describe *how* individual nodes maintain state; temporal multiplexing describes *how* the global connectome runs multiple streams in parallel
- **[[wiki/concepts/canonical-microcircuit.md]]** — the superficial (feedforward/fast) vs. deep (feedback/slow) layer split in the canonical microcircuit provides the laminar anatomical substrate for temporal multiplexing; each stream preference for superficial vs. deep aligns with the explore (superficial) vs. exploit (deep) functional split
- **[[wiki/entities/default-mode-network.md]]** — DMN is one of 7 ICN building blocks; DMN × task-positive co-activation as the most frequent multi-ICN blueprint directly challenges static anti-correlation models and supports flexible integration between DMN and external attention systems across all timescales
- **[[wiki/entities/ms-ssm-model.md]]** — MS-SSM implements multi-resolution (SWT) decomposition feeding parallel SSM arrays with scale-dependent initialization, operationalizing the core temporal multiplexing principle in an ML architecture; ablation confirms multi-scale structure (not selective gating) is the key inductive bias
- **[[wiki/papers/alderson-2026-multiscale-connectome.md]]** — primary empirical source establishing all claims on this page
