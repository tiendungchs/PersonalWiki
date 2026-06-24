---
title: "A Survey of Encoding Techniques for Signal Processing in Spiking Neural Networks — Auge et al., Neural Processing Letters 2021"
type: paper
tags: [snn, spike-coding, rate-coding, temporal-coding, sdr, stdp, neuromorphic]
created: 2026-06-21
updated: 2026-06-21
sources: []
related: [wiki/concepts/sparse-distributed-representations.md, wiki/concepts/hebbian-learning.md, wiki/entities/htm-thousand-brains.md, wiki/entities/ltc-model.md]
---

# A Survey of Encoding Techniques for Signal Processing in Spiking Neural Networks

**Citation:** Auge D, Hille J, Mueller E, Knoll A. (2021). *Neural Processing Letters*, 54, 1683–1720. https://doi.org/10.1007/s11063-021-10562-2

---

## Key Computational Insights

- **Rate vs. temporal two-category taxonomy.** All SNN encoding schemes split on whether exact spike timing is information-bearing. Rate codes (count rate `v = N_spike/T`, density, population) are computationally equivalent to ANN activation values, enabling near-lossless ANN→SNN conversion with ReLU (99.42% MNIST). Temporal codes (TTFS, phase, ISI/burst, synchrony, TC) achieve higher information density (`log₂(N!)` vs. `log₂(N+1)` bits per spike for ROC vs. count) and faster reaction times but require architecturally matched networks.

- **SDRs are synchrony/correlation codes.** The paper formally places sparse distributed representations under the correlation/synchrony subcategory: "a subset of neurons inside a population is active at any given point of time" encodes a pattern via the *identity* of co-active units, not their rates. This grounds SDR (Sparse Distributed Representations) capacity formulas in spike-timing theory — SDR (Sparse Distributed Representations) recognition requires only that the co-active subset fires within a narrow coincidence window (matching NMDA spike detection windows of 1–5 ms).

- **Phase coding and reference oscillations.** Phase coding encodes information as a time offset `Δt` relative to a periodic reference oscillation; observed in cat visual cortex (Gray et al. 1989). This provides the SNN-level mechanism by which theta/gamma oscillations in HC and neocortex serve as information *channels* (carrying amplitude in the spike phase), not merely pacemakers or synchrony signals.

- **Hybrid multi-scale coding.** Rate and temporal codes confer complementary advantages across timescales: temporal codes enable fast post-onset responses; rate codes accumulate accuracy for sustained stimuli. Fairhall et al. 2001 show biological neurons shift coding scheme based on the timescale of input variation. The biological hierarchy (sensory → cortical → HC) plausibly layers temporal coding at sensory onset atop rate coding at higher integrative areas.

- **ANN→SNN conversion as an engineering bridge.** Training standard deep networks (CNNs, feedforward) with ReLU then converting via count rate code achieves lossless transfer with orders-of-magnitude power reduction on neuromorphic hardware. Establishes that the representational content learned by gradient descent is preserved when migrated to spike-rate format; the gap is architectural (lack of temporal recurrence), not informational.

---

## Limitations

- Encoding-only scope: training algorithms, network topology, and hardware efficiency of temporal codes are outside the survey and remain under-characterized.
- No controlled cross-scheme comparison on identical architectures; accuracy differences in the MNIST table conflate encoding scheme with learning algorithm and network depth.
- Hybrid coding theory is noted as "not yet clearly defined" — no formal framework for multi-timescale encoding in recurrent networks is provided.

---

## Links to Concept / Entity Pages

- [[wiki/concepts/sparse-distributed-representations.md]] — SDRs classified as synchrony coding; coincidence window ties to NMDA spike timing
- [[wiki/concepts/hebbian-learning.md]] — STDP is the canonical temporal learning rule enabled by precise spike timing; rate codes favour instead contrastive Hebbian learning
- [[wiki/entities/htm-thousand-brains.md]] — HTM (Hierarchical Temporal Memory) explicitly uses SDR (Sparse Distributed Representations) synchrony coding in its spatial pooler
- [[wiki/entities/ltc-model.md]] — LTC's input-dependent `τ_sys` implements a single-neuron adaptive encoding window, a continuous-time analog of multi-scale hybrid coding
