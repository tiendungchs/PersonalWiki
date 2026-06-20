---
title: "Information Theory (Entropy, KL Divergence)"
type: concept
tags: [information-theory, entropy, kl-divergence, cross-entropy, training-objectives]
created: 2026-06-12
updated: 2026-06-12
sources: [cross-entropy-first-principles-transcript, bolzman-machine-transcript]
related: [wiki/concepts/two-learning-timescales.md, wiki/entities/tem-model.md, wiki/concepts/predictive-coding.md, wiki/entities/boltzmann-machine.md, wiki/papers/boltzmann-machine-transcript.md]
---

# Information Theory (Entropy, KL Divergence)

**Surprisal, entropy, cross-entropy, and KL divergence quantify uncertainty and model mismatch — forming the universal training objective for all generative models in this wiki.**

---

## Core Quantities

**Surprisal** (self-information): `I(x) = log(1/p(x))`

Additive for independent events — the logarithm is *forced* by this additivity requirement. (Probability multiplies; surprise should add.)

**Entropy** — average surprisal under the true distribution:

```
H(P) = Σ_x P(x) log(1/P(x))
```

Measures inherent uncertainty. H = 0 when deterministic; maximized by the uniform distribution.

**Cross-entropy** — average surprise when true distribution is P but model assigns Q:

```
H(P,Q) = Σ_x P(x) log(1/Q(x))
```

Key property: `H(P,Q) ≥ H(P)` always — using the wrong model can only increase expected surprise. Asymmetric: `H(P,Q) ≠ H(Q,P)`.

**KL divergence** — extra surprise from model mismatch, beyond inherent uncertainty:

```
KL(P‖Q) = H(P,Q) − H(P) = Σ_x P(x) log(P(x)/Q(x))
```

`KL ≥ 0`; `KL = 0` iff `P = Q`. Asymmetric.

---

## Training Objective Equivalence

```
argmin_Q KL(P‖Q) = argmin_Q H(P,Q)
```

`H(P)` is constant w.r.t. model parameters — it is set by the training data, not by the model. Minimizing KL and minimizing cross-entropy select the same optimal Q. This is why implementations use cross-entropy loss rather than computing KL explicitly (the latter would also require estimating H(P) from samples).

---

## Variational Lower Bound (ELBO)

For latent-variable models where the marginal `p(o)` is intractable, the ELBO provides a tractable surrogate:

```
log p(o) ≥ ELBO = E_q[log p(o|z)] − KL[q(z|o) ‖ p(z)]
```

Equivalently, **variational free energy F = −ELBO**:

```
F = −E_q[log p(o|z)] + KL[q(z|o) ‖ p(z)]
     ↑ accuracy cost        ↑ complexity cost
  (cross-entropy with data)  (KL from prior)
```

**F ≥ −log p(o)** always — free energy upper-bounds sensory surprise. Minimizing F tightens this bound while avoiding the intractable posterior `p(z|o)`.

The Free Energy Principle (Friston) is the neuroscience interpretation: the brain minimizes F by maintaining a recognition model `q(z|o)` (approximate posterior) against a generative model `p(o|z)·p(z)`. This makes the cross-entropy + KL training objective the universal objective for both artificial generative models and biological perception.

---

## Instantiations in This Wiki

| System | KL / cross-entropy role |
|--------|------------------------|
| TEM slow weights W | Cross-entropy minimization over sensory predictions across environments |
| TEM fast weights M | Local prediction-error reduction within one environment |
| Predictive coding / FEP | Perception = minimize F = −E_q[log p(o\|z)] + KL[q(z\|o) ‖ p(z)]; learning = adjust p(o\|z), p(z) parameters |
| Generative models (VAEs, diffusion) | Maximize log-likelihood = minimize cross-entropy with data distribution |

---

## Why ELBO Exists: The Partition Function Problem

The Boltzmann machine ([[wiki/entities/boltzmann-machine.md]]) makes the intractability explicit. To maximize log P(data) under any energy-based model:

```
log P(data) = −E(data) − log Z     where Z = Σ_{s} exp(−E(s)/T)
```

Computing log Z requires summing over all 2^N states — intractable for N > ~20. This is not a quirk of energy-based models; it is the general problem of computing the marginal likelihood for any latent-variable model:

```
log p(o) = log ∫ p(o|z) p(z) dz       (intractable integral / sum)
```

The ELBO replaces this with a tractable lower bound by introducing an approximate posterior q(z|o):

```
log p(o) ≥ ELBO = E_q[log p(o|z)] − KL[q(z|o) ‖ p(z)]
```

The gap is `KL[q(z|o) ‖ p(z|o)]` — cost of using q instead of the true posterior. Minimizing F = −ELBO simultaneously tightens this bound and finds a good approximate posterior.

**Conceptual lineage:**

```
Boltzmann machine (intractable log Z)
  → Variational Bayes (tractable ELBO replaces log Z)
    → VAE (amortized recognition model q(z|o; φ))
      → FEP / Predictive Coding (hierarchical ELBO with local Hebbian updates)
        → TEM (factorized ELBO: structural g + episodic M)
```

Each step makes the same optimization more tractable or more biologically plausible.

---

## Open Problems for Reasoning Models

- **KL asymmetry as architectural choice:** `KL(P‖Q)` is mean-seeking — the model spreads probability mass to cover all modes of P, which can represent multiple competing hypotheses. `KL(Q‖P)` is mode-seeking — the model collapses to one mode. Which direction is used shapes whether a reasoning system can represent uncertainty over multiple interpretations simultaneously.

- **Two nested KL problems:** the two-timescale architecture suggests a slow outer KL (shared structure across environments) and a fast inner KL (episodic content within one environment). No unified formal objective has been derived specifying how these interact.

---

## Connections

- **[[wiki/concepts/two-learning-timescales.md]]** — slow W and fast M each minimize cross-entropy over different distributions (cross-environment structural regularity vs. single-environment episodic binding); the two-timescale split is formally two nested KL minimization problems with different data distributions P.
- **[[wiki/entities/tem-model.md]]** — TEM's training objective is cross-entropy minimization over sensory predictions; the KL-to-cross-entropy equivalence explains why TEM code uses cross-entropy loss despite the theory being framed as KL divergence minimization.
- **[[wiki/concepts/predictive-coding.md]]** — FEP frames the cross-entropy + KL objective as Bayesian brain inference: free energy F = −ELBO = accuracy cost + KL complexity; minimizing F unifies perceptual inference (fast, activations) and model learning (slow, weights) under a single variational objective.
- **[[wiki/entities/boltzmann-machine.md]]** — partition function Z is the concrete instance of the log p(o) intractability that motivates the ELBO; the conceptual lineage from Boltzmann machine through variational Bayes to FEP is the historical progression from intractable to tractable optimization of the same objective.
- **[[wiki/papers/boltzmann-machine-transcript.md]]** — source for Boltzmann distribution derivation and partition function; motivates why variational inference exists.
