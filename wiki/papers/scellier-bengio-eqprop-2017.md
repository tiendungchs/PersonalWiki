---
title: "Equilibrium Propagation: Bridging the Gap between Energy-Based Models and Backpropagation — Scellier & Bengio 2017"
type: paper
tags: [credit-assignment, energy-based, contrastive-hebbian, stdp, biologically-plausible, hopfield]
created: 2026-06-23
updated: 2026-06-23
sources: [Equilibrium Propagation Bridging the Gap between Energy-Based Models and Backpropagation]
related: [wiki/entities/equilibrium-propagation.md, wiki/concepts/credit-assignment.md, wiki/concepts/hebbian-learning.md, wiki/entities/boltzmann-machine.md, wiki/concepts/associative-memory.md, wiki/concepts/predictive-coding.md]
---

# Scellier & Bengio 2017 — Equilibrium Propagation

Scellier B & Bengio Y (2017). Equilibrium Propagation: Bridging the Gap between Energy-Based Models and Backpropagation. *Front. Comput. Neurosci.* 11:24. doi: 10.3389/fncom.2017.00024

---

## Key Computational Insights

- **Single-circuit gradient descent via two-phase energy minimization.** Free phase (β=0): input clamped, network relaxes to free fixed point u⁰ (inference). Nudged phase (β>0): output units weakly pushed toward target d via external force β(d_i−y_i), network relaxes to u^β. The contrastive rule ΔW_{ij} ∝ (1/β)[ρ(u^β_i)ρ(u^β_j) − ρ(u⁰_i)ρ(u⁰_j)] exactly computes ∂J/∂W in the limit β→0 (Theorem 1). Both phases use identical leaky-integrator dynamics ds/dt = −∂F/∂s; no separate backward circuit.

- **Fixes CHL and CD theoretical failures.** Contrastive Hebbian Learning (CHL) uses full output clamping (β→∞), whose objective J_CHL = E(u^∞) − E(u⁰) can go negative when the two phases land in different energy modes, making learning deteriorate. EqProp uses weak clamping (small β>0); the implicit function theorem guarantees u^β stays near u⁰ (same energy mode), so J = ½‖y⁰−d‖² is always non-negative and well-defined. CD_1 computes a biased gradient that can cycle indefinitely; EqProp computes the correct gradient in the limit.

- **STDP is the continuous-time EqProp weight update.** The rule dW_{ij}/dt ∝ ρ(u_i) d/dt[ρ(u_j)] + ρ(u_j) d/dt[ρ(u_i)] = d/dt[ρ(u_i)ρ(u_j)] (tied version for symmetric weights), integrated over the path u⁰→u^β during the nudged phase, yields exactly the contrastive rule. The postsynaptic signal is the *rate of change* of firing rate d/dt[ρ(u_j)], not the instantaneous rate — a biologically distinct prediction from standard STDP.

- **Framework generalizes beyond Hopfield.** EqProp applies to any total energy F(θ,v,β,s) = E(θ,v,s) + βC(θ,v,s) where network dynamics are gradient flow. The Hopfield model is the prototype; arbitrary recurrent architectures with any cost function C qualify. The energy function alone specifies the model, the objective, and the learning rule — anatomy → energy function → plasticity is a complete specification path.

- **Scalability bottleneck: free phase relaxation scales quadratically with depth.** Empirically: 20/100/500 iterations for 1/2/3 hidden layers on MNIST. Persistent particles (re-using the previous epoch's fixed point per example) partially mitigate this. Layer-wise learning rates needed in practice despite theory requiring a single rate — attributed to finite-precision fixed-point approximation.

---

## Limitations

- Symmetric weights W_{ij} = W_{ji} required for the Hopfield energy to define a valid fixed-point system; most serious biological implausibility. May emerge from autoencoder objectives (Arora et al. 2015) or feedback alignment; undemonstrated at scale.
- Slow free-phase relaxation on digital hardware makes large-scale experiments expensive. Analog circuits that physically settle to equilibrium are the envisioned implementation.
- Not included in the Bartunov et al. 2018 ImageNet-scale bio-plausible comparison (computationally prohibitive); ImageNet scalability remains untested.

---

## Links to wiki pages

- [[wiki/entities/equilibrium-propagation.md]] — full algorithm, equations, comparison table, reasoning-model implications
- [[wiki/concepts/credit-assignment.md]] — EqProp in the bias–variance taxonomy; formal unifier of temporal-error models
- [[wiki/concepts/hebbian-learning.md]] — STDP as continuous-time EqProp; tied-weight STDP interpretation
- [[wiki/entities/boltzmann-machine.md]] — CHL vs. EqProp: full vs. weak output clamping; two-phase learning history
- [[wiki/concepts/associative-memory.md]] — EqProp as gradient-correct training method for supervised Hopfield networks
