---
title: "Brain's Learning Algorithm — Predictive Coding from First Principles (video transcript)"
type: paper
tags: [predictive-coding, backpropagation, biological-plausibility, local-learning, energy-based-models]
created: 2026-06-12
updated: 2026-06-12
sources: [brain-learning-algorithm-transcript]
related: [wiki/concepts/predictive-coding.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/information-theory.md]
---

# Brain's Learning Algorithm — Predictive Coding from First Principles (video transcript)

**Source:** Video transcript; builds predictive coding from energy minimization, deriving update rules and neural connectivity from first principles. Technical level — includes equations and mechanistic derivations.

---

## Key Computational Insights

1. **Backprop's two biologically fatal violations** — (1) *Discontinuous processing:* backprop requires neurons to freeze forward-pass activations during the backward pass; brains process information continuously with no pause between sensing and learning. (2) *Non-local coordination:* backprop requires a global controller switching the entire network between phases in strict temporal sequence with cell-by-cell precision; brains are locally autonomous, massively parallel.

2. **Energy function = sum of squared prediction errors** — `E = Σ_l Σ_i ε_{l,i}²` where `ε_{l,i} = x_{l,i} − Σ_k w_{lk} x_{l+1,k}`. Minimizing by gradient descent derives all update rules with no extra assumptions.

3. **Activity update — local two-term balance** — `dx_{l,i}/dt = −ε_{l,i} + Σ_k w_{lk} ε_{l−1,k}`: first term pulls activity toward top-down prediction; second term pulls toward better predicting the layer below. Equilibrium = energy minimum for current input.

4. **Weight update — Hebbian-like and local** — `Δw_{lk} ∝ ε_{l,i} · x_{l+1,k}` (prediction error × presynaptic activity). Fully local. Weight transport problem (symmetric forward/backward weights needed) naturally mitigates because both synapses follow the same update rule and converge independently — approximate with nonlinearities.

5. **Mandatory two-population architecture per layer** — Representational neurons `x` (encode estimates; inhibited by own error neuron; excited by error neurons from layer below) + error neurons `ε` (compute actual − predicted; excited by own `x`; inhibited by top-down predictions from layer above). Maps to cortical superficial layers (error, bottom-up) vs. deep layers (predictions, top-down).

---

## Limitations

Activation functions omitted for clarity — with nonlinearities the weight transport resolution becomes approximate rather than exact. No quantitative comparison with backprop performance. Catastrophic forgetting advantage described theoretically but not benchmarked.

---

## Links

- [[wiki/concepts/predictive-coding.md]] — primary target; algorithmic content added here
- [[wiki/concepts/two-learning-timescales.md]] — activity update (fast, per-input) = perception timescale; weight update (slow, across inputs) = learning timescale
- [[wiki/concepts/information-theory.md]] — squared prediction errors ↔ MSE ↔ −log likelihood under Gaussian → connects to ELBO formulation
