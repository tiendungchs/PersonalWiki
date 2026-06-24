---
title: "The Spiking Tolman-Eichenbaum Machine: Emergent Spatial and Temporal Coding through Spiking Network Dynamics"
type: paper
tags: [spiking-neural-networks, grid-cells, place-cells, phase-precession, tolman-eichenbaum-machine, theta-oscillations, STDP, neuromodulation]
created: 2026-06-21
updated: 2026-06-21
sources: [spiking-tem-kawahara-2025]
related: [wiki/entities/tem-model.md, wiki/entities/grid-cells.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/concepts/phase-precession.md, wiki/concepts/hebbian-learning.md, wiki/concepts/neuromodulation.md, wiki/concepts/sparse-distributed-representations.md, wiki/concepts/predictive-coding.md]
---

# Spiking TEM — Kawahara & Fujisawa, bioRxiv 2025

**Citation:** Kawahara D, Fujisawa S. *The Spiking Tolman-Eichenbaum Machine: Emergent Spatial and Temporal Coding through Spiking Network Dynamics.* bioRxiv 2025. doi: 10.1101/2025.10.16.682754

---

## 5 Key Computational Insights

- **Phase precession emerges from learned spiking dynamics** — LIF (Leaky Integrate-and-Fire) neurons + surrogate-gradient backpropagation (slow W) + STDP (fast M) + theta inhibitory input + neuromodulatory gain G are sufficient to produce MECII cells whose spike phase advances systematically earlier across the theta cycle as the agent traverses a firing field. No oscillatory interference, hand-crafted connectivity, or explicit temporal target is required; the phenomenon emerges from the interaction of learning and dynamics.

- **Grid codes compensate for sensory ambiguity** — grid cell formation is maximally strong (~60% neurons) when the environment has ~20 sensory neurons but 64 positions (information gap). When sensory neurons match or exceed positions (no aliasing), grid cell proportion drops sharply. This establishes grid codes as an *internal prior that fills the gap when external signals are insufficient to determine location* — the computational role that makes grid coding relevant to abstract latent-graph discovery under aliased observations.

- **Predictive grid cells emerge in MECIII** — MECIII neurons exhibit higher gridness when evaluated at position t+1 rather than current position t (p = 2.98×10⁻⁶). The generative/inference split of the TEM framework naturally produces this MECII (current-state encoder) vs. MECIII (one-step-ahead predictor) functional specialization without explicit supervision.

- **Neuromodulation G gates temporal coding mode** — the learnable gain factor G (scaling total synaptic input; G ≈ ACh/DA analog) controls phase precession vs. locking: (a) G on + theta in MECIII on → MECII precesses (80.2%), MECIII locks (86.7%); (b) G off + theta on → both lock; (c) G on + theta off → both precess. Neuromodulation thus governs not just learning rate but which temporal coding *regime* each MEC layer occupies.

- **Minimum mechanism package: four jointly necessary components** — ablation study (Table 2): removing STDP → 10.1% grid cells (baseline 59.6%); removing theta inhibition → 25.6%; removing neuromodulation G → 0.0%; removing hippocampal sparsity loss term → 0.9%. All four are necessary; architectural completeness, not parameter tuning, determines grid cell emergence. The theta mechanism operates indirectly through sparsity: theta inhibition improves spatial tuning of CA1 → increases sparsity → structured MEC input → grid cells.

---

## Limitations

- Square/diamond grid geometry rather than canonical hexagonal grids; prior work (Dordek et al., Stachenfeld et al.) suggests non-negative MEC→HC weight constraints may be required for hexagonal geometry.
- No phase diversity across grid cells → the population lacks the toroidal coding structure observed in vivo (Gardner et al. 2022).
- BPTT + surrogate gradient for slow-W learning; biologically implausible. Predictive coding and e-prop are candidate replacements not yet tested in this framework.

---

## Links

- [[wiki/entities/tem-model.md]] — Spiking TEM extends the original TEM with spike-based computation
- [[wiki/concepts/phase-precession.md]] — first emergent demonstration of phase precession in a learned spiking model
- [[wiki/entities/grid-cells.md]] — predictive MECIII cells and sensory-ambiguity-driven emergence are new grid cell results
- [[wiki/entities/hippocampal-entorhinal-system.md]] — MECII/MECIII functional dissociation grounded in neuromodulation
- [[wiki/concepts/neuromodulation.md]] — G as temporal coding mode controller, not just learning rate
- [[wiki/concepts/hebbian-learning.md]] — STDP is jointly necessary for grid emergence (ablation)
