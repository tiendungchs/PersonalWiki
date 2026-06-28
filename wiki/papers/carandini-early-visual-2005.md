---
title: "Do We Know What the Early Visual System Does? — Carandini et al. 2005"
type: paper
tags: [early-vision, V1, receptive-fields, normalization, energy-model, predictive-models, gain-control]
created: 2026-06-26
updated: 2026-06-26
sources: []
related: [wiki/concepts/energy-based-models.md, wiki/concepts/hierarchical-representations.md, wiki/papers/dicarlo-visual-object-recognition-2012.md]
---

# Do We Know What the Early Visual System Does? — Carandini et al., J Neurosci 2005

Carandini, Demb, Mante, Tolhurst, Dan, Olshausen, Gallant & Rust. *J. Neuroscience* 25(46): 10577–10597.

## Key Computational Insights

- **LNP model** (Linear-Nonlinear-Poisson): linear spatiotemporal filter → static nonlinearity → Poisson spike generation. Explains ~80% of retinal ganglion cell variance on white noise; fails for natural scenes because the linear filter must be re-estimated at every contrast/luminance level — adaptive gain control must be added dynamically.
- **Divisive normalization** (Heeger 1992): `V1 response = [linear sum]² / (σ² + Σ pooled_neighbors²)`; divides each neuron's drive by the pooled activity of neurons sharing its spatial location but spanning all orientations/SFs. Achieves contrast invariance and automatic response range compression — biological precursor of softmax normalization in self-attention.
- **Energy model of V1 complex cells** (Adelson & Bergen 1985): `R = [F^φ(k^φ * s)]² + [F^{φ+90°}(k^{φ+90°} * s)]²` — two phase-shifted Gabor filters, squared and summed. Produces phase-invariant, orientation/SF-selective responses; a fixed quadratic compatibility function between stimulus and preferred feature (biological EBM with evolutionary weights).
- **~40% of explainable variance** in V1 responses is captured by the best current feedforward models (linear + second-order mechanisms) under natural viewing. Olshausen & Field (2005) estimate ~85% of overall V1 function is unaccounted for once biased neuron sampling and stimulus ecology are corrected for.
- The missing variance is dominated by contextual modulation (stimuli outside the classical receptive field, driven by recurrent V1 connections and feedback from higher areas) and temporal adaptation — both requiring recurrent or top-down processing.

## Limitations

- Standard models perform well (~80%) on white noise but degrade substantially for natural scenes; V1 is substantially harder to model than retina/LGN.
- Simple/complex cell dichotomy is likely a measurement artifact; a continuous nonlinearity spectrum is more accurate.
- Biased electrode sampling (toward higher-firing neurons) and restricted stimulus sets (gratings rather than natural movies) cause systematic overestimation of model completeness.

## Links

- **[[wiki/concepts/energy-based-models.md]]** — the V1 complex cell energy model is a biological fixed-weight EBM; divisive normalization is the neural mechanism analogous to softmax normalization that prevents response saturation.
- **[[wiki/concepts/hierarchical-representations.md]]** — provides the quantitative baseline (~40% explainable variance) showing that even V1 feedforward models fail substantially under natural viewing, supporting the claim that feedforward hierarchy alone is insufficient.
- **[[wiki/papers/dicarlo-visual-object-recognition-2012.md]]** — DiCarlo 2012 extends the visual hierarchy analysis from V1 to IT cortex; the present paper provides the quantitative V1 baseline that DiCarlo's manifold-untangling account builds on.
