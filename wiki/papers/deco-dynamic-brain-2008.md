---
title: "The Dynamic Brain: From Spiking Neurons to Neural Masses and Cortical Fields"
type: paper
tags: [neural-field-theory, mean-field, fokker-planck, neural-mass, lif-neuron, hodgkin-huxley, bifurcation, traveling-wave, cann, oscillations, seizure, multi-scale]
created: 2026-06-25
updated: 2026-06-25
sources: [deco-dynamic-brain-2008]
related: [wiki/concepts/neural-field-theory.md, wiki/concepts/ring-attractor.md, wiki/concepts/working-memory.md, wiki/entities/snn.md]
---

Deco G., Jirsa V.K., Robinson P.A., Breakspear M., Friston K. (2008). "The Dynamic Brain: From Spiking Neurons to Neural Masses and Cortical Fields." *PLOS Computational Biology*, 4(8), e1000092.

**Key computational insights:**
- Fokker-Planck reduction: `∂p/∂t = -∂/∂ν[μp] + ½ ∂²/∂ν²[σ²p]` collapses N stochastic LIF (Leaky Integrate-and-Fire) neurons into a population-density PDE; mean firing rate ς(μ_v) is the sufficient statistic linking scales.
- Neural mass ODE (mesoscale): `dμ_a/dt = κς(μ_v) - 2γμ_a - γ²μ_v` — damped second-order oscillator driven by sigmoid activation; captures local E-I dynamics without tracking individual spikes.
- Neural field PDE (macroscale): `∂²μ/∂t² + 2γ ∂μ/∂t - c²∇²μ = -μ + κς(μ)` — wave equation on the cortical sheet; propagation speed c and conduction delays introduce oscillatory modes via Hopf bifurcation.
- Amari bump solution: localized persistent-activity state in a 2D neural field with Mexican-hat connectivity (short-range excitation, long-range inhibition) is the theoretical foundation for CANNs (Continuous Attractor Neural Networks) and the ring attractor.
- Bifurcations as computation: stochastic → limit-cycle → chaos transitions correspond to distinct neural computations (stable perception / rhythmic oscillation / multistability), controlled by neuromodulatory gain κ.
- Corticothalamic seizure model: 3 Hz absence seizures arise as Hopf bifurcation in the corticothalamic loop (cortex + TC (Thalamo-Cortical) relay + TRN (Thalamic Reticular Nucleus)); spatial spread and frequency specificity both emerge from the PDE.
- Traveling wave types: spiral, target, and doubly-periodic wave patterns emerge from the neural field PDE with conduction delays; linked to cortical gamma/theta oscillations and spreading depression.

**Limitations:** Mean-field derivation assumes spatial homogeneity and Gaussian noise — breaks down for heterogeneous networks with non-Gaussian fluctuations; bump solutions require hand-tuned Mexican-hat kernels not easily learned end-to-end by gradient descent; PDE continuum limit invalid below ~0.5 mm (column scale).

**See also:** [[wiki/concepts/neural-field-theory.md]] · [[wiki/concepts/ring-attractor.md]] · [[wiki/concepts/working-memory.md]] · [[wiki/entities/snn.md]]
