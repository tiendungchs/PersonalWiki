---
title: "Equilibrium Propagation"
type: entity
tags: [credit-assignment, energy-based, contrastive-hebbian, stdp, biologically-plausible, hopfield, gradient-descent]
created: 2026-06-23
updated: 2026-06-23
sources: [Equilibrium Propagation Bridging the Gap between Energy-Based Models and Backpropagation, towards_biologically_plausuble_DL]
related: [wiki/concepts/credit-assignment.md, wiki/concepts/hebbian-learning.md, wiki/concepts/associative-memory.md, wiki/concepts/predictive-coding.md, wiki/entities/boltzmann-machine.md, wiki/papers/scellier-bengio-eqprop-2017.md, wiki/papers/theories-backprop-brain-whittington-2019.md, wiki/papers/bengio-bioplausible-dl-2015.md]
---

# Equilibrium Propagation

**A biologically plausible learning framework where two-phase energy minimization with identical leaky-integrator dynamics performs both inference and credit assignment, computing the exact gradient of an objective via a local contrastive Hebbian rule — no separate backward circuit required.**

Scellier & Bengio (2017). Prototype: continuous Hopfield network. Applies to any energy-based model with gradient-flow dynamics.

---

## Setup

| Symbol | Meaning |
|---|---|
| s = {h, y} | state variable (hidden + output units; input x always clamped) |
| E(θ, s) | internal energy — Hopfield-style; requires W_{ij} = W_{ji} |
| C(y, d) = ½‖y−d‖² | cost function |
| F = E + βC | total energy; β ≥ 0 is the influence parameter |
| u⁰ | free fixed point: arg min_s E (β=0) — the network's prediction |
| u^β | nudged fixed point: arg min_s F (β>0) — slightly improved prediction |

**Hopfield energy (prototype):**
$$E(u) = \frac{1}{2}\sum_i u_i^2 - \frac{1}{2}\sum_{i\neq j} W_{ij}\rho(u_i)\rho(u_j) - \sum_i b_i\rho(u_i)$$

**Dynamics — same in both phases:**
$$\frac{ds}{dt} = -\frac{\partial F}{\partial s}$$

---

## Two-Phase Protocol

| Phase | β | Force on output units y | Network settles to |
|---|---|---|---|
| **Free** (phase 1) | 0 | None — y relaxes freely | u⁰ (prediction / inference) |
| **Nudged** (phase 2) | small β > 0 | β(d_i − y_i) — weak pull toward target d | u^β (slightly lower cost) |

The "back-propagation" in phase 2 is the perturbation at output units propagating backward through hidden layers via the same gradient-flow dynamics — no dedicated backward circuit.

---

## Learning Rule (Theorem 1, Scellier & Bengio 2017)

$$\frac{\partial J}{\partial \theta}\bigg|_{\theta} = \lim_{\beta \to 0} \frac{1}{\beta}\!\left(\frac{\partial F}{\partial \theta}\bigg|_{u^\beta} - \frac{\partial F}{\partial \theta}\bigg|_{u^0}\right)$$

For weights W_{ij} (using ∂F/∂W_{ij} = −ρ(u_i)ρ(u_j)):

$$\boxed{\Delta W_{ij} \propto \frac{1}{\beta}\!\left[\rho(u_i^\beta)\rho(u_j^\beta) - \rho(u_i^0)\rho(u_j^0)\right]}$$

- **Local:** depends only on pre/post activities at two equilibrium points
- **Exact:** computes ∂J/∂W in the limit β→0 (not just an approximation)
- **Two interpretations:** (1) anti-Hebbian at u⁰, Hebbian at u^β; (2) continuous Hebbian during the path u⁰→u^β

---

## STDP Derivation

During the nudged phase, the instantaneous weight update is:

$$\frac{dW_{ij}}{dt} \propto \rho(u_i)\frac{d\rho(u_j)}{dt} + \rho(u_j)\frac{d\rho(u_i)}{dt} = \frac{d}{dt}\!\left[\rho(u_i)\rho(u_j)\right]$$

Integrating over the path u⁰ → u^β:

$$\Delta W_{ij} \propto \rho(u_i^\beta)\rho(u_j^\beta) - \rho(u_i^0)\rho(u_j^0)$$

This is the EqProp rule. The postsynaptic signal is d/dt[ρ(u_j)] — the *rate of change* of firing rate — not the instantaneous rate. This "tied" form (symmetric pre/post contributions) arises from the symmetric weight constraint W_{ij} = W_{ji}.

---

## Comparison to Related Algorithms

| Algorithm | Phase 2 clamping | Objective | Theoretical issue |
|---|---|---|---|
| Contrastive Hebbian (CHL, Movellan 1990) | Full (β→∞) | E(u^∞) − E(u⁰) | J_CHL can be negative (mode mismatch) |
| Contrastive Divergence (CD, Hinton 2002) | k-step MCMC | log-likelihood (biased estimator) | CD_1 may cycle indefinitely |
| Recurrent BP (Pineda 1987; Almeida 1987) | Same objective | ½‖y⁰−d‖² | Phase 2 uses linearized dynamics — different circuit type |
| **Equilibrium Propagation** (Scellier & Bengio 2017) | Weak (β small) | ½‖y⁰−d‖² | Symmetric weights; slow free phase on digital hardware |

---

## Limitations

1. **Symmetric weights** W_{ij} = W_{ji} — required for energy function validity; the primary bio-implausibility. Autoencoder pretraining or feedback alignment may produce approximate symmetry; undemonstrated at scale.
2. **Free-phase depth scaling** — 20/100/500 iterations for 1/2/3 hidden layers on MNIST; exponential on digital hardware. Analog circuits that physically relax to equilibrium are the intended substrate.
3. **ImageNet undemonstrated** — excluded from Bartunov et al. 2018 comparison; no large-scale empirical result.
4. **Layer-wise learning rates needed** in practice — theory requires a single rate, but finite fixed-point precision causes layer-dependent effective update magnitudes.

---

## For Building a Reasoning Model

EqProp is the canonical theoretical resolution to **Gap 4** (biologically plausible slow-W learning): it proves that local contrastive Hebbian updates at energy equilibrium compute the *exact* gradient of a well-defined objective, with no additional assumptions. The practical gaps (symmetric weights, analog scale) remain.

- **Free phase = inference:** the network settling to u⁰ is structurally identical to predictive coding's free-energy minimization phase — both minimize E via gradient flow before any learning occurs. EqProp and PC (Predictive Coding) are the same family.
- **Nudged phase = active inference:** the target d acts as a weak external signal biasing equilibrium (not a hard clamp); this is the supervised analog of active inference, where preferred outcomes gently pull the generative model's fixed point rather than forcing it.
- **Design implication:** any energy-based module in a reasoning architecture can be trained with EqProp if it supports symmetric recurrent connections; the same circuit that performs inference also performs credit assignment.

---

## EqProp vs. Targetprop

The two main candidates for biologically plausible slow-W learning differ on the exactness/symmetry tradeoff:

| Property | EqProp (Scellier & Bengio 2017) | Targetprop (Bengio et al. 2015) |
|---|---|---|
| **Gradient accuracy** | Exact as β→0 (Theorem 1) | High-bias approximation via DAE theorem |
| **Weight symmetry** | Required: W_{ij} = W_{ji} | Not required: f and g trained independently |
| **Computation** | Two fixed-point relaxations (free + nudged) | Feedforward pass + iterative inference dynamics |
| **STDP form** | Tied (symmetric pre/post) | Asymmetric (S_i · V̇_j) |
| **Biological framing** | Energy minimization / contrastive Hebbian | Variational EM (Expectation Maximization) (E-step inference, M-step weights) |
| **Validated at** | MNIST; ImageNet excluded (too slow) | MNIST; DTP collapses at ImageNet (Bartunov 2018) |

Both fail at ImageNet scale. EqProp's exactness advantage is theoretical — it has never been tested beyond MNIST. Targetprop's freedom from weight symmetry is practically important but does not compensate for high bias at scale.

---

## Open Problems

- Does weight symmetry emerge from autoencoder pretraining in multi-layer energy networks?
- Can feedback alignment (random B ≈ W^T) extend EqProp to asymmetric weights while preserving exactness?
- Can feedforward initialization (Bengio et al. 2016) or persistent particles reduce free-phase iterations from O(L³) to O(L) in practice?

---

## Connections

- **[[wiki/concepts/credit-assignment.md]]** — EqProp proves that local contrastive Hebbian updates at energy fixed points compute the exact gradient, establishing the theoretical ceiling for what purely local two-phase Hebbian rules can achieve; it is the formal unifier of all temporal-error credit assignment classes.
- **[[wiki/concepts/hebbian-learning.md]]** — the EqProp update is the time-integral of a tied STDP rule where the postsynaptic signal is d/dt[ρ(u_j)], providing the most principled derivation that a biologically observed STDP form computes exact gradients rather than merely approximating them.
- **[[wiki/concepts/associative-memory.md]]** — the continuous Hopfield network is the prototype energy-based model for EqProp; EqProp is the gradient-correct training algorithm that replaces CHL (Contrastive Hebbian Learning) for supervised Hopfield learning.
- **[[wiki/concepts/predictive-coding.md]]** — EqProp's free phase (gradient-flow settling to u⁰) is structurally identical to PC's inference phase (free-energy minimization); both are temporal-error credit assignment models that use network convergence to a fixed point as their effective backward pass.
- **[[wiki/entities/boltzmann-machine.md]]** — EqProp fixes the Boltzmann machine's CHL (Contrastive Hebbian Learning) mode-mismatch bug by replacing full output clamping with weak clamping (β small); the implicit function theorem guarantees the nudged fixed point stays in the same energy mode as the free fixed point.
- **[[wiki/papers/scellier-bengio-eqprop-2017.md]]** — primary source: Theorem 1 proof, STDP derivation, comparison to CHL/CD/Almeida-Pineda, and MNIST experiments.
- **[[wiki/papers/theories-backprop-brain-whittington-2019.md]]** — situates EqProp as the formal unifier of all four temporal-error credit assignment classes (CHL, GeneRec, continuous update, EqProp); all are energy-based networks whose dynamics converge before weight updates.
- **[[wiki/papers/bengio-bioplausible-dl-2015.md]]** — targetprop is the direct competitor to EqProp for biologically plausible slow-W: trades EqProp's exactness for freedom from the weight symmetry constraint; both are Bengio-lab proposals attacking Gap 4 from different angles.
