---
title: "Efficient event-based delay learning in spiking neural networks"
type: paper
tags: [snn, synaptic-delay, eventprop, adjoint-method, neuromorphic, temporal-coding, credit-assignment]
created: 2026-06-27
updated: 2026-06-27
sources: ["Efficient event-based delay learning in spiking neural networks"]
related: [wiki/entities/snn.md, wiki/concepts/temporal-coding.md, wiki/concepts/credit-assignment.md, wiki/concepts/small-world-networks.md, wiki/concepts/hebbian-learning.md]
---

# Efficient Event-Based Delay Learning in SNNs

**Mészáros, Knight & Nowotny — *Nature Communications* 2025**

---

## Citation

Mészáros B., Knight J.C., Nowotny T. (2025). Efficient event-based delay learning in spiking neural networks. *Nature Communications*, 16, 5672. https://doi.org/10.1038/s41467-025-65394-8

---

## Key Computational Insights

- **EventProp extended to delays:** the adjoint method yields exact gradients w.r.t. both weights and delays simultaneously; backward dynamics are *identical* — delay gradient is a byproduct at zero extra cost:

  $$\frac{d\mathcal{L}}{dd_{ji}} = -w_{ji}\sum_{\{t_k | n(k)=i\}} (\lambda_{I,j} - \lambda_{V,j})\big|_{t_k^{\text{spike}} + d_{ji}}$$

- **Emission ≠ arrival:** with delays, spike emission time $t_k^{\text{spike}}$ and arrival time $t_k^{\text{spike}} + d_{mn}$ are distinct events; the full event set $\mathcal{E} = \mathcal{S} \cup \{t_k^{\text{spike}} + d_{mn}\}$ must be sorted; backward pass remains computable because all delays are non-negative.
- **Per-neuron buffer:** delay range increases buffer size per neuron only — not per synapse — so memory scales with $N$, not $N^2$; 26× faster and >2× less memory than dilated-convolution (PyTorch/SpikingJelly) baseline.
- **First recurrent delay learning:** prior methods (DelGrad) were feedforward-only and single-spike-per-neuron; this method supports arbitrary recurrent topology and multiple spikes.
- **Small-world delay distribution:** learned delays cluster near zero with a heavy tail of few long-range delays — mirrors the brain's EDR + rare LR shortcut topology.
- **Capacity argument (Maass & Schmitt):** $k$ adjustable delays compute a *strictly richer* function class than $k$ adjustable weights; recurrent delays are especially beneficial in small networks.

## Results

| Dataset | Best test accuracy | Note |
|---|---|---|
| Yin-Yang | ~same as DelGrad | Equivalent gradients confirmed |
| SHD | 93.24 ± 1.0% | 5× fewer parameters than delay-line SOTA |
| SSC | 76.1 ± 1.0% | 2-layer feedforward best |
| Braille | 83.1 ± 1.5% | Outperforms recurrent baseline (80.9%) |

## Limitations

- Discrete time grid; delays quantised to integer multiples of timestep (dt).
- Recurrent delay initialisation problem remains open — no principled initialisation strategy.
- No trainable time constants (isolated delay effect; heterogeneous τ not explored here).

## Links

- **[[wiki/entities/snn.md]]** — EventProp+delay adds a new entry to the SNN training taxonomy (exact-gradient, event-based, recurrent-capable).
- **[[wiki/concepts/temporal-coding.md]]** — gradient-based delay learning is a supervised complement to Hebbian W(s) delay selection.
- **[[wiki/concepts/credit-assignment.md]]** — adjoint method (EventProp) is the SNN-native exact credit assignment rule; event-based backward pass avoids dense BPTT memory.
- **[[wiki/concepts/small-world-networks.md]]** — learned delay distributions (mostly short, few long-range) mirror the brain's EDR + LR shortcut principle at the synapse level.
- **[[wiki/concepts/hebbian-learning.md]]** — contrasts with W(s) delay selection: Hebbian selects delays unsupervised via co-timing; EventProp selects delays via exact gradient descent.
