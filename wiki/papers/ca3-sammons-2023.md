---
title: "Structure and function of the hippocampal CA3 module"
type: paper
tags: [hippocampus, CA3, associative-memory, pattern-completion, connectomics, electrophysiology]
created: 2026-06-20
updated: 2026-06-20
sources: [Structure and function of the hippocampal CA3 module]
related: [wiki/concepts/associative-memory.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/concepts/engrams.md, wiki/queries/building-blocks-mec-hc-pfc.md]
---

# Structure and Function of the Hippocampal CA3 Module

Sammons, Vezir, Moreno-Velasquez et al. — *PNAS* 2023. DOI: 10.1073/pnas.2312281120

**Method:** Combined 3D EM (Expectation Maximization) (ATUM-multiSEM, 965×808×62 µm at 4 nm resolution; 7 reconstructed axons, 1,062 annotated synapses) with multipatch electrophysiology (up to 8 simultaneous cells; 1,172 tested pairs across 52 mice) and spiking network simulations (LIF + log-normal weights + inhibitory STDP).

---

## Key Computational Insights

- **CA3 connectivity is ~9–11%**, not <1%: EM (Expectation Maximization) finds 11.2 ± 2.7% within 50 µm; electrophysiology finds 8.8% (103/1,172 pairs). Both methods agree across independent labs — ~10× above Guzman et al. 2016's estimate.
- **Random connectivity at this rate suffices for pattern completion**: reciprocal and disynaptic motifs occur at chance levels given 8.8% basal rate. Motif enrichment (invoked by Guzman 2016 to compensate for <1% connectivity) is not required.
- **Pattern completion obeys c × M ≈ const**: successful sequence replay requires a minimum product of connectivity (c) and assembly size (M). At 8.8%, a wide range of M values support reliable replay without non-random structure.
- **Log-normal synaptic weights confirmed**: median EPSP 0.66 mV; amplitude distribution is log-normal. Majority of connections are weak; a small number are large — the mechanism by which embedded assemblies stand above background noise.
- **Inhibitory STDP balances E/I for selective replay**: I→E synapses are trained by an STDP plasticity rule to maintain an asynchronous-irregular (AI) state, preventing runaway excitation and enabling discrete assembly replay without spreading to non-pattern neurons.

---

## Limitations

- EM (Expectation Maximization) from a single P31 male mouse; 62 µm slice thickness means truncated axons — measured connectivity is likely a *lower bound*.
- Discrepancy with Guzman et al. 2016 attributed to species (mouse vs. rat), slice storage method (interface chamber vs. beaker), and cell density differences; not fully resolved.

---

## Links

- **[[wiki/concepts/associative-memory.md]]** — connectivity data empirically grounds the CA3-as-Hopfield-attractor claim; log-normal weights match the sparse assembly-embedding mechanism.
- **[[wiki/entities/hippocampal-entorhinal-system.md]]** — CA3 anatomy and function within the broader HC system; new section added summarizing connectivity findings.
- **[[wiki/concepts/engrams.md]]** — high CA3 connectivity supports rapid engram completion from partial cues; reduces the assembly-size requirement for reliable recall.
- **[[wiki/queries/building-blocks-mec-hc-pfc.md]]** — Block 2B (pattern completion bridge) now has direct biological grounding: 8.8% random connectivity supports iterative attractor dynamics without architectural tricks.
