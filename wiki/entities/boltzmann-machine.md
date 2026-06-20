---
title: "Boltzmann Machine"
type: entity
tags: [boltzmann-machine, generative-model, energy-based, stochastic, hopfield, contrastive-learning, rbm]
created: 2026-06-12
updated: 2026-06-12
sources: [bolzman-machine-transcript]
related: [wiki/concepts/predictive-coding.md, wiki/concepts/attention.md, wiki/concepts/information-theory.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/associative-memory.md, wiki/entities/tem-model.md, wiki/papers/boltzmann-machine-transcript.md]
---

# Boltzmann Machine

**Hinton & Sejnowski (1985). A Hopfield network extended with stochastic updates and hidden units, enabling it to learn the probability distribution of training data rather than memorizing specific patterns.**

Two modifications transform any Hopfield network into a Boltzmann machine:
1. **Stochasticity** — replace deterministic sign(h_i) updates with probabilistic updates governed by the Boltzmann distribution
2. **Hidden units** — add neurons that do not correspond to data; develop internal representations of abstract features

---

## Architecture

| Dimension | Hopfield Network | Boltzmann Machine |
|---|---|---|
| Update rule | Deterministic: `x_i ← sign(h_i)` | Stochastic: `P(x_i=1) = σ(2h_i/T)` |
| Learning objective | Minimize energy of stored patterns | Maximize log P(training data) |
| Learning rule | Hebbian: `Δw ∝ x_i x_j` | Contrastive Hebbian: `Δw ∝ ⟨x_i x_j⟩_data − ⟨x_i x_j⟩_free` |
| Unit types | Visible only | Visible + hidden |
| Capability | Pattern completion (recall) | Generative sampling (creation) |

---

## Boltzmann Distribution

The stochastic update rule is derived from statistical physics. For a system with energy E(s):

```
P(s) = exp(−E(s)/T) / Z     where Z = Σ_{s'} exp(−E(s')/T)
```

- **T (temperature):** controls exploration vs. exploitation. High T → near-uniform sampling (creative but noisy); low T → near-deterministic greedy descent (Hopfield limit).
- **Z (partition function):** normalization over all 2^N possible states — the source of computational intractability.

For a single neuron update, applying the Boltzmann distribution to the two-state case (on/off) yields the **sigmoid update rule**:

```
P(x_i = 1) = σ(2h_i / T)     where h_i = Σ_j w_{ij} x_j
```

The sigmoid is not an architectural choice — it is derived from the Boltzmann distribution applied to a binary choice with energy defined by the Hopfield weight matrix.

---

## Contrastive Hebbian Learning

Objective: maximize `log P(data) = −E(data) − log Z`.

Two competing forces:
- **Minimize E(data):** pull energy wells down around training patterns
- **Minimize log Z:** push the energy surface up elsewhere (preventing the network from assigning low energy to non-data states)

This gives the **contrastive Hebbian rule**:

```
Δw_ij ∝ ⟨x_i x_j⟩_data − ⟨x_i x_j⟩_free
```

**Two training phases:**

| Phase | Visible units | Hidden units | Measures |
|---|---|---|---|
| **Positive** (data-clamped) | Fixed to training pattern | Settle freely via stochastic updates | ⟨x_i x_j⟩_data — what co-activates given real data |
| **Negative** (free-running) | Unconstrained | Unconstrained | ⟨x_i x_j⟩_free — what the model hallucinates |

The contrastive rule strengthens connections active in data and weakens connections active in hallucinations — shaping the energy landscape so data patterns occupy deep wells and non-data patterns occupy high ridges.

---

## Hidden Units

Designated neurons with no direct data correspondence. In the positive phase they are inferred (settle freely given clamped visible units); in the negative phase they hallucinate alongside visible units. Over training they develop:
- **Abstract feature detectors** — internal codes for higher-order correlations not visible in individual pixels/tokens
- **Latent variables** — the conceptual precursor to VAE latent codes and TEM's structural code `g`

The number of hidden units is a design hyperparameter; more hidden units → richer internal representations but slower convergence.

---

## Restricted Boltzmann Machine (RBM)

Bipartite restriction: no within-layer connections; only visible-hidden edges allowed.

**Advantage:** given hidden unit states, all visible units are conditionally independent → entire visible layer can be updated in parallel (and vice versa). This turns O(N) serial updates into O(1) parallel steps, making training practical.

Despite reduced connectivity, RBMs retain most of the expressive power of full Boltzmann machines and were widely used as building blocks in early deep belief networks (Hinton 2006).

---

## Key Limitation: Partition Function Intractability

`log Z = log Σ_{s} exp(−E(s)/T)` requires summing over all 2^N states. This is computationally intractable for any network with more than ~20 units.

**Practical workaround (contrastive divergence):** approximate the negative phase expectation by running only k steps of Markov chain sampling from the training pattern rather than waiting for equilibrium. Biased but fast.

**Theoretical resolution:** the variational free energy / ELBO replaces the exact log Z with a tractable lower bound. This is the conceptual bridge from Boltzmann machines to modern generative models (VAEs, FEP/predictive coding). See [[wiki/concepts/information-theory.md]].

---

## Comparison to Related Models

| Dimension | Boltzmann Machine | VAE / TEM | Predictive Coding |
|---|---|---|---|
| Z | Explicit, intractable | Replaced by ELBO | Approximated by free energy F |
| Learning | Contrastive Hebbian (two-phase) | Backprop (ELBO gradient) | Local Δw ∝ ε·x (one-phase Hebbian) |
| Hidden latents | Unstructured | Factorized z | Hierarchical representational neurons |
| Generation | Stochastic sampling | Decoder | Top-down prediction |
| Biological plausibility | High (local rule, two phases) | Low (backprop required) | High (local rules, no global coordinator) |

---

## Connections

- **[[wiki/concepts/predictive-coding.md]]** — the contrastive Hebbian rule's two phases (positive: data-clamped; negative: free-running) are the structural precursor to PC's two-population architecture (error neurons driven by sensory input vs. representational neurons driven by top-down prediction); PC is the tractable hierarchical extension of Boltzmann learning that replaces the equilibrium sampling requirement with local error propagation.
- **[[wiki/concepts/attention.md]]** — the softmax in transformer self-attention is the Boltzmann distribution `P ∝ exp(similarity/T)` applied to key-query similarity scores; the temperature parameter in softmax is literally T; this makes the Hopfield ↔ attention derivation physically grounded, not merely algebraic.
- **[[wiki/concepts/information-theory.md]]** — partition function intractability (`log Z` over 2^N states) is precisely the problem that the ELBO solves; variational free energy F = −ELBO is a tractable upper bound on −log Z; Boltzmann machines motivate why variational inference is necessary.
- **[[wiki/concepts/two-learning-timescales.md]]** — the positive phase (data-clamped visible units, freely settling hidden units) implements fast episodic binding (M-analog); the negative phase (freely running weights-only model) implements the prior shaped by slow learning (W-analog); the two-phase contrastive structure anticipates the two-timescale split.
- **[[wiki/entities/tem-model.md]]** — TEM's Hopfield-style memory (reformulated as transformer attention in TEM-t) implicitly uses the Boltzmann distribution via softmax; TEM's variational training objective is the factorized, tractable answer to the Boltzmann machine's intractable Z.
- **[[wiki/papers/boltzmann-machine-transcript.md]]** — primary source.
- **[[wiki/concepts/associative-memory.md]]** — Hopfield network is the deterministic (T→0) limit of the Boltzmann machine; contrastive Hebbian extends one-shot Hebbian by adding a free-running negative phase that pushes energy up for non-data states, reshaping the full energy landscape rather than just drilling wells at stored patterns.
