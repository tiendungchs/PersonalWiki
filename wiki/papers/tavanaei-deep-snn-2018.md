---
title: "Deep Learning in Spiking Neural Networks"
type: paper
tags: [snn, deep-learning, stdp, bayesian-em, surrogate-gradient, lsnn, rbm, reservoir-computing]
created: 2026-06-23
updated: 2026-06-23
sources: []
related: [wiki/entities/snn.md, wiki/concepts/credit-assignment.md, wiki/concepts/hebbian-learning.md, wiki/entities/reservoir-computing.md, wiki/entities/boltzmann-machine.md]
---

# Deep Learning in Spiking Neural Networks

Tavanaei, Ghodrati, Kheradpisheh, Masquelier & Maida. *Neural Networks* 111 (2019) 47–63. (preprint 2018)

---

- **STDP ≈ Bayesian EM:** With winner-take-all lateral inhibition, STDP with Poisson inputs approximates online Expectation-Maximization for a multinomial mixture distribution (Nessler et al. 2009/2013); the WTA spike output is an E-step sample from the posterior; the STDP update is the M-step — unsupervised generative model learning from local spike-timing rules alone.
- **Two-track deep SNN:** Online learning (STDP or surrogate-gradient backprop) achieves 93–99% MNIST accuracy while remaining multi-layer trainable; offline ANN-to-SNN conversion achieves 99%+ at ~5× fewer operations but substitutes rate-coded firing rates for ReLU activations — not a spiking training algorithm.
- **Surrogate gradient (Lee et al. 2016):** Membrane potential V(t) acts as a differentiable proxy for the non-differentiable Heaviside spike function; enables backpropagation through spike-layer boundaries; 98.88% MNIST at 5× fewer operations than the equivalent ANN; V(t) is not synapse-local (a second-order bio-implausibility beyond weight transport).
- **LSNN (Bellec et al. 2018):** A reservoir of ALIF spiking neurons trained with BPTT + pseudo-derivatives achieves LSTM-comparable accuracy on sequential MNIST and TIMIT without explicit gating; the slow adaptation current in ALIF (τ_a ≫ τ_m) plays the role of LSTM cell state — sequential memory from neuronal dynamics rather than architectural machinery.
- **HBM ↔ Hopfield equivalence (Barra et al. 2012):** Hybrid Boltzmann machines (continuous hidden units, binary visible) are thermodynamically equivalent to Hopfield networks via marginalization; enables Hopfield simulation with O(NP) instead of O(N²) synapses — foundation for hardware-efficient spiking Hopfield implementations.

**Limitations:** All benchmarks are MNIST/CIFAR-scale; STDP unsupervised methods consistently underperform supervised/conversion methods by 2–5%; no SNN demonstrates cross-environment structural generalization; ImageNet-scale spiking learning is undemonstrated.

**Links to:** [[wiki/entities/snn.md]], [[wiki/concepts/credit-assignment.md]], [[wiki/entities/reservoir-computing.md]], [[wiki/entities/boltzmann-machine.md]]
