---
title: "An Approximation of Error Backpropagation in a Predictive Coding Network with Local Hebbian Synaptic Plasticity — Whittington & Bogacz, Neural Computation 2017"
type: paper
tags: [predictive-coding, backpropagation, hebbian-learning, credit-assignment, biologically-plausible-learning, supervised-learning]
created: 2026-06-22
updated: 2026-06-22
sources: [whittington-bogacz-pc-backprop-2017]
related: [wiki/concepts/predictive-coding.md, wiki/concepts/credit-assignment.md, wiki/concepts/hebbian-learning.md, wiki/concepts/two-learning-timescales.md]
---

# Whittington & Bogacz 2017 — PC (Predictive Coding) Approximates Backprop

Whittington JCR & Bogacz R. *Neural Computation* 29(5):1229–1262 (2017). PMID 28333583.

---

## Key Computational Insights

- **Prediction error nodes ≈ backprop δ terms.** At steady state in learning mode, PC's error nodes ε_l satisfy the same recursive formula as backprop's error terms δ_l: `ε_l = f'(a_l) Σ_k w_{lk} ε_{l-1,k}`. Both quantities carry the information required to compute ∂F/∂w at each layer.

- **Fully local Hebbian weight update.** The weight update `Δw_{lk} ∝ ε_l · x_{l+1}` — prediction error at level l × presynaptic activity at level l+1 — is a product of activities of the two neurons the synapse connects. No backward phase freeze, no weight transport required.

- **Three convergence conditions.** PC (Predictive Coding) = exact backprop when: (a) the network already predicts all training samples perfectly; (b) predictions are close to targets (near-perfect learning); (c) output-layer variance parameter σ_out → 0, which reduces the perturbative effect of clamping the output. In general nonlinear networks, this is an approximation with finite bias.

- **Bidirectional association.** With equal noise parameters on input and output arms, PC (Predictive Coding) learns the first principal component of the joint distribution — simultaneously supporting forward (input→output) and reverse (output→input) inference. Setting σ_out ≪ σ_in recovers backprop (forward regression); setting σ_in ≪ σ_out gives inverse regression. Standard backprop provides no backward inference.

- **MNIST validation.** A 784–600–600–10 PC (Predictive Coding) network achieves ~1.7–1.8% validation error, matching a standard ANN with backprop. The σ_out → 0 case tracks the ANN learning curve most closely; both eventually reach 0% training error.

---

## Limitations

- **Weight symmetry unconfirmed.** The mathematical derivation requires feedforward and feedback weights to be symmetric; no anatomical evidence. Preliminary simulations suggest it is not necessary, but formal proof deferred.
- **One-to-one error–variable node pairing.** The two-population architecture assigns one error node per variable node — a precise pairing with no clear anatomical counterpart.
- **Linear error-node assumption.** Error nodes must operate in a linear regime (near zero baseline) to remain valid; typical pyramidal neuron firing rates are too sparse to guarantee this.

---

## Links

- **[[wiki/concepts/predictive-coding.md]]** — full derivation of the PC (Predictive Coding) energy function, two-population architecture, and how Whittington & Bogacz 2017 establishes the bias floor for the PC (Predictive Coding) credit assignment approximation.
- **[[wiki/concepts/credit-assignment.md]]** — places this result in the bias–variance taxonomy: PC (Predictive Coding) occupies medium-bias/medium-variance; convergence to exact backprop at the energy minimum defines the minimum achievable bias.
- **[[wiki/concepts/hebbian-learning.md]]** — the weight update Δw ∝ ε·x is a supervised Hebbian rule: the error node ε provides a teaching signal that modulates the Hebbian co-activation product, bridging unsupervised co-activation plasticity and gradient-based learning.
- **[[wiki/concepts/two-learning-timescales.md]]** — the PC (Predictive Coding) weight rule is the candidate biologically plausible slow-W learning algorithm; this paper provides the formal ground for using PC (Predictive Coding) as the outer-loop credit assignment rule in architectures that prohibit global backward passes.
