---
title: "Synaptic Modifications in Cultured Hippocampal Neurons — Bi & Poo, J Neurosci 1998"
type: paper
tags: [stdp, synaptic-plasticity, ltp, ltd, nmda, hebbian-learning, hippocampus, coincidence-detection]
created: 2026-06-21
updated: 2026-06-21
sources: [bi-poo-stdp-1998]
related: [wiki/concepts/hebbian-learning.md, wiki/concepts/dendritic-computation.md, wiki/entities/hippocampal-entorhinal-system.md]
---

# Synaptic Modifications in Cultured Hippocampal Neurons — Bi & Poo 1998

Bi G-Q, Poo M-M. *J Neurosci* 18(24):10464–10472, 1998. PMID: 9852584.

---

- **Asymmetric ±20ms STDP window**: pre→post within 20ms → LTP (Long-Term Potentiation) (+48.4%); post→pre within 20ms → LTD (Long-Term Depression) (−18%); ~5ms transition zone at Δt ≈ 0; no plasticity outside a ±40ms window. Direction is set by causal order, not just co-activation — the Hebbian "fire together wire together" rule requires temporal refinement.
- **Synaptic-strength ceiling for LTP (Long-Term Potentiation) only**: LTP (Long-Term Potentiation) restricted to weak synapses (initial EPSC <500 pA, inverse log-linear relationship, r = −0.72); LTD (Long-Term Depression) has no strength dependence (r = 0.037). Strong connections are intrinsically protected from further potentiation — a natural upper-bound mechanism equivalent to the BCM sliding threshold, requiring no global homeostatic signal.
- **NMDA receptor required for both directions**: d-AP5 (25 µM) blocks both LTP (Long-Term Potentiation) and LTD (Long-Term Depression) completely. NMDA's Mg²⁺-unblock kinetics — requiring near-simultaneous pre-activation (glutamate binding) and postsynaptic depolarization (back-propagating AP) — implement the ±20ms coincidence window at the molecular level.
- **Cell-type specificity — E→E only**: Glutamatergic synapses onto GABAergic interneurons show zero plasticity under identical correlated-spiking protocols (mean change: −0.3 ± 3.4% for LTP (Long-Term Potentiation) protocol, −1.7 ± 2.0% for LTD (Long-Term Depression) protocol; p < 0.001 vs. glutamatergic targets). Inhibitory neurons lack a major Ca²⁺ signaling pathway (Sik et al. 1998); STDP operates exclusively at excitatory→excitatory connections.
- **L-type Ca²⁺ channel asymmetry**: Nimodipine (10 µM) abolishes LTD (Long-Term Depression) entirely (−1.2 ± 1.3%, not significant) but only partially reduces LTP (Long-Term Potentiation) (27.3 ± 8.6%, still significant). Different Ca²⁺ sources underlie the two plasticity directions: LTP (Long-Term Potentiation) via NMDA-dominated Ca²⁺ influx; LTD (Long-Term Depression) requires L-type Ca²⁺ channels activated by back-propagating action potentials.

**Limitations**: In vitro dissociated culture — in vivo STDP windows vary (cortical slices: 10–25ms; some reports broader); experiments at room temperature (in vivo kinetics differ at 37°C); only E→E and E→I plasticity characterized, not I→E or I→I.

---

- [[wiki/concepts/hebbian-learning.md]] — this paper is the empirical foundation for the STDP temporal refinement row; quantifies the ±20ms window, strength ceiling, and cell-type constraint that the Hebbian concept page summarizes
- [[wiki/concepts/dendritic-computation.md]] — NMDA Mg²⁺-unblock kinetics are the molecular implementation of the STDP coincidence window; L-type Ca²⁺ channels are the separate route for LTD
- [[wiki/entities/hippocampal-entorhinal-system.md]] — data from dissociated hippocampal (CA1/CA3 mixed) neurons; STDP operates on glutamatergic recurrent collaterals of the type present in CA3
