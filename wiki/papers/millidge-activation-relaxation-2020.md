---
title: "Activation Relaxation: A Local Dynamical Approximation to Backpropagation in the Brain"
type: paper
tags: [credit-assignment, backpropagation, biological-plausibility, local-learning, dynamical-systems, NGRAD]
created: 2026-06-22
updated: 2026-06-22
sources: [backprop_in_the_brain]
related: [wiki/concepts/credit-assignment.md, wiki/concepts/predictive-coding.md, wiki/concepts/dendritic-computation.md, wiki/concepts/hebbian-learning.md]
---

# Activation Relaxation — Millidge, Tschantz, Seth & Buckley (2020)

**Citation:** Millidge B, Tschantz A, Seth AK, Buckley CL. "Activation Relaxation: A Local Dynamical Approximation to Backpropagation in the Brain." Preprint, 2020.

---

## Key Computational Insights

- **Dynamical gradient derivation:** AR designs a leaky-integrator dynamical system whose equilibrium = backpropagated gradients. Forward pass sets activations; a parallel relaxation phase iterates all layers simultaneously until convergence. No sequential backward sweep, no global controller.
- **Counterexample to NGRAD hypothesis:** The NGRAD hypothesis (Lillicrap et al. 2020) claims all biologically plausible backprop approximations encode gradients as spatial or temporal activity differences. AR reaches exact backprop gradients using inter-layer error dynamics without any activity-difference representation — the first explicit counterexample.
- **Single neuron type:** Unlike predictive coding (which requires separate representational and error neuron populations per layer), AR uses a single neuron population, simplifying the biological circuit substantially.
- **Weight transport via Hebbian backwards weights:** Replacing the exact weight transpose W^T with learnable backwards weights ψ (trained by a local Hebbian rule Δψ ∝ x_l · x_{l+1}) maintains full performance. Fixed random backwards weights (feedback alignment) are less stable.
- **Nonlinear derivatives removable:** Dropping the activation-function derivative term from the weight update has negligible effect on performance; interpreted as projection onto the nearest linear subspace. The fully simplified update requires only local activations and the layer above mapped through backward weights — potentially implementable in neuronal circuitry.

## Limitations

- Requires two distinct phases: a feedforward sweep and a dynamical relaxation phase — challenging for continuous-time sensory processing in biological brains.
- The relaxation phase requires storing the original forward-pass activations while gradients are computed, which needs a biological short-term memory mechanism (proposed: apical dendritic compartments or oscillatory phase coordination).
- Demonstrated only on MNIST and FashionMNIST; generalization to more complex tasks untested.

## Links

- [[wiki/concepts/credit-assignment.md]] — AR occupies a near-zero-bias position in the bias-variance taxonomy, as the only local rule that converges to exact backprop gradients
- [[wiki/concepts/predictive-coding.md]] — AR challenges PC as the default biologically plausible backprop approximation: simpler circuit (one neuron type), and counterexamples the shared NGRAD assumption
- [[wiki/concepts/dendritic-computation.md]] — apical dendrites proposed as the solution to AR's two-phase problem: segregated compartments maintain the forward-pass activation during the relaxation phase
- [[wiki/concepts/hebbian-learning.md]] — the backwards weight learning rule in AR (Δψ ∝ x_l · x_{l+1}) is a Hebbian coincidence rule applied to feedback connections
