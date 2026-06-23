---
title: "Networks of Spiking Neurons: The Third Generation of Neural Network Models"
type: paper
tags: [snn, temporal-coding, computational-complexity, expressiveness, coincidence-detection]
created: 2026-06-23
updated: 2026-06-23
sources: [Networks of Spiking Neurons]
related: [wiki/entities/snn.md, wiki/concepts/temporal-coding.md, wiki/concepts/binding-problem.md]
---

# Networks of Spiking Neurons: The Third Generation

Maass, W. (1997). *Neural Networks*, 10(9), 1659–1671.

---

## Key Computational Insights

- **Three-generation hierarchy**: 1st gen = threshold gates (digital output); 2nd gen = sigmoidal gates (analog); 3rd gen = spiking neurons (spike trains). SNNs are *strictly more powerful* per neuron count — not merely biologically motivated.

- **Linear temporal coding**: encoding analog value x as firing time T − xc puts the weighted sum into the time domain. For type B neurons (continuous piecewise-linear PSPs), the firing time satisfies t_v = T_out − Σ sign(ε_u,v)·w_u,v·x_u — weights play the identical algebraic role as in rate-coded nets; the difference is continuous temporal shift rather than threshold crossing.

- **Coincidence detection (CD_n)**: a function requiring 1 type B spiking neuron, but Ω(n/log n) threshold gates (1st gen) or Ω(n²) sigmoidal gates (2nd gen). This is the formal lower bound establishing SNN expressiveness superiority.

- **Element distinctness (ED_n)**: fires iff any two of n real-valued inputs are equal under temporal coding. Requires Ω(n) hidden units in sigmoidal nets; computable by a single spiking neuron in a noise-robust manner.

- **Type A vs. Type B**: piecewise-constant (type A) SNNs fail for real-valued numerical inputs — no simulation of threshold circuits for analog input is possible. Piecewise-linear (type B) SNNs are universal approximators for continuous functions, subsume 2nd gen entirely.

---

## Limitations

- Pure expressiveness result — no learning algorithm provided; says nothing about *how* SNNs learn coincidence detection.
- Type B results require the linear segment of EPSPs; idealized models (type A) miss this and are strictly weaker.
- Stochastic SNNs can compute CD_n/ED_n but analog power degrades with noise level (Maass & Orponen 1997).

---

## Connections

- **[[wiki/entities/snn.md]]** — establishes the three-generation hierarchy and type A/B distinction that ground all theoretical claims about SNN expressiveness.
- **[[wiki/concepts/temporal-coding.md]]** — linear temporal coding (T − xc) is the encoding primitive that converts the weighted-sum formalism into the time domain, giving type B SNNs their extra computational power.
- **[[wiki/concepts/binding-problem.md]]** — CD_n is the formal coincidence detection primitive: a single spiking neuron does the work of Ω(n²) sigmoidal gates, making spiking substrates the natural implementation for synchrony-based binding.
