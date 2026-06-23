---
title: "Assessing the Scalability of Biologically-Motivated Deep Learning Algorithms and Architectures — Bartunov et al., NIPS 2018"
type: paper
tags: [credit-assignment, backpropagation, target-propagation, feedback-alignment, scalability, locally-connected, weight-sharing]
created: 2026-06-22
updated: 2026-06-22
sources: [Assessing the Scalability of Biologically-Motivated Deep Learning Algorithms and Architectures]
related: [wiki/concepts/credit-assignment.md, wiki/concepts/dendritic-computation.md, wiki/concepts/predictive-coding.md, wiki/concepts/two-learning-timescales.md]
---

# Assessing the Scalability of Biologically-Motivated Deep Learning Algorithms and Architectures

Bartunov S, Santoro A, Richards BA, Marris L, Hinton GE, Lillicrap TP. *NIPS 2018*.

---

## Five Key Computational Insights

- **First ImageNet-scale test of bio-plausible algorithms: all fail.** FA achieves 93.1% top-1 error; DTP and SDTP achieve 98–99%; BP achieves 71.4% (locally-connected) and 63.9% (ConvNet). The failure is categorical, not marginal.

- **SDTP introduced: fully gradient-free DTP variant.** Eliminates the last remaining BP step in DTP (penultimate-layer target computation) by using the learned inverse function instead. Performance degrades on CIFAR and fails on ImageNet; root cause is low-entropy target diversity — with only 10 output classes, the inverse mapping cannot produce input-specific targets for the penultimate layer.

- **Weight sharing is not the bottleneck; the learning algorithm is.** BP on locally-connected networks (biologically plausible spatial structure, no weight sharing) outperforms all bio-plausible algorithms on locally-connected networks by ~20–30 percentage points on CIFAR and ~22 points on ImageNet top-1. The convolutional vs. locally-connected gap for BP itself is small (~7 points on ImageNet), confirming that weight sharing gives a moderate benefit but is not what makes BP succeed.

- **Formal unification: BP is a limiting case of TP.** Appendix 5.6 shows that if the approximate inverse function g equals the Jacobian of the forward function (g = df/dh), then minimizing the TP local loss is equivalent to a gradient descent step on the global loss — i.e., DTP and BP share a functional form with differing approximation assumptions.

- **"Behavioural realism" as a necessary criterion.** Physiological plausibility alone is insufficient; a learning algorithm must also scale to tasks humans perform. This frames the benchmark: any proposed bio-plausible learning rule must be evaluated on ImageNet-difficulty tasks, not just MNIST.

---

## Limitations

- Spiking dynamics, Dale's law, and recurrent architectures all set aside. Results apply to feedforward rate-coded networks only.
- All algorithms still require distinct forward and backward phases — a second-order bio-implausibility that none of the variants address.
- Hyperparameter sensitivity of TP variants is high; results may not reflect the best achievable performance with further tuning.

---

## Links

- [[wiki/concepts/credit-assignment.md]] — primary home for DTP/SDTP in the bias–variance taxonomy; ImageNet scalability results added there
- [[wiki/concepts/dendritic-computation.md]] — paper notes Sacramento et al.'s dendritic error backpropagation as an alternative not tested here
- [[wiki/concepts/predictive-coding.md]] — equilibrium propagation (Scellier & Bengio) cited as a related untested variant
- [[wiki/concepts/two-learning-timescales.md]] — scalability failure constrains which bio-plausible rules are viable candidates for the slow-W outer loop
