---
title: "Information Theory (Entropy, KL (Kullback-Leibler) Divergence)"
type: concept
tags: [information-theory, entropy, kl-divergence, cross-entropy, training-objectives, compression, solomonoff, algorithmic-information-theory]
created: 2026-06-12
updated: 2026-06-23
sources: [cross-entropy-first-principles-transcript, bolzman-machine-transcript, Language Modeling Is Compression, hutter-aixi-2000, choi-intelligence-density-2026]
related: [wiki/concepts/two-learning-timescales.md, wiki/entities/tem-model.md, wiki/concepts/predictive-coding.md, wiki/entities/boltzmann-machine.md, wiki/papers/boltzmann-machine-transcript.md, wiki/papers/language-modeling-compression-deletang-2023.md, wiki/concepts/intelligence-density.md]
---

# Information Theory (Entropy, KL (Kullback-Leibler) Divergence)

**Surprisal, entropy, cross-entropy, and KL (Kullback-Leibler) divergence quantify uncertainty and model mismatch — forming the universal training objective for all generative models in this wiki.**

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

`H(P)` is constant w.r.t. model parameters — it is set by the training data, not by the model. Minimizing KL (Kullback-Leibler) and minimizing cross-entropy select the same optimal Q. This is why implementations use cross-entropy loss rather than computing KL (Kullback-Leibler) explicitly (the latter would also require estimating H(P) from samples).

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

The Free Energy Principle (Friston) is the neuroscience interpretation: the brain minimizes F by maintaining a recognition model `q(z|o)` (approximate posterior) against a generative model `p(o|z)·p(z)`. This makes the cross-entropy + KL (Kullback-Leibler) training objective the universal objective for both artificial generative models and biological perception.

---

## Instantiations in This Wiki

| System | KL (Kullback-Leibler) / cross-entropy role |
|--------|------------------------|
| TEM slow weights W | Cross-entropy minimization over sensory predictions across environments |
| TEM fast weights M | Local prediction-error reduction within one environment |
| Predictive coding / FEP (Free Energy Principle) | Perception = minimize F = −E_q[log p(o\|z)] + KL[q(z\|o) ‖ p(z)]; learning = adjust p(o\|z), p(z) parameters |
| Generative models (VAEs, diffusion) | Maximize log-likelihood = minimize cross-entropy with data distribution |
| LLM + arithmetic coding | Training log-loss = lossless compression rate; Chinchilla 70B beats domain-specific compressors (PNG/FLAC) on images/audio despite text-only training — evidence that large-scale prediction extracts modality-agnostic structure |

---

## Compression-Prediction Equivalence

**Shannon's source coding theorem:** the expected code length for any lossless encoder is bounded by `H(ρ)`. Arithmetic coding achieves code length `≈ −log₂ ρ̂(x₁:ₙ)` — 1-bit overhead regardless of sequence length. The expected code length is therefore the cross-entropy:

```
E[code length] ≈ H(ρ, ρ̂) = E_{x∼ρ}[−log₂ ρ̂(xᵢ | x<ᵢ)]
```

**Minimizing log-loss = minimizing lossless compression rate.** The cross-entropy training objective for all language models — and the accuracy term `−E_q[log p(o|z)]` in variational free energy — are maximum-compression objectives. FEP (Free Energy Principle) minimization is compression rate minimization.

### Solomonoff Predictor — Theoretical Ceiling

Optimal *universal* lossless compression (over all computable distributions) recovers the **Solomonoff predictor**: a Bayesian mixture over all Turing-computable programs weighted by description length:

```
S(x₁:ₙ) = Σ_{q ∈ Q} 2^{−|q|} · q(x₁:ₙ)
```

Prior weight `2^{−|q|}` is Occam's razor operationalized — shorter programs receive exponentially larger mass. **Predicting optimally ≡ compressing optimally ≡ Solomonoff induction.** LLMs are parameter-bounded, training-distribution-limited approximations. The gap to the Solomonoff predictor is the formal statement of why current models fail at abstract reasoning over genuinely novel domains: their compression prior was formed over a finite training distribution, not all computable programs.

### Active Extension: AIXI (AI with (X) induction (I)) and the Passive/Active Boundary

The Solomonoff predictor applies only to **passive** environments — sequences the agent observes but does not influence. Hutter 2000 (AIXI [[wiki/papers/hutter-aixi-2000.md]]) extends ξ to ξ^AI, conditioned on the agent's full action history, enabling the universal prior to drive active decision-making:

```
AIXI selects action y_k = argmax_{y_k} Σ_{x_k} ... Σ_{x_{m_k}} max_{y_{m_k}} Σ_q 2^{-l(q)} [c(x_k) + ... + c(x_{m_k})]
```

This is the formal limit of the compression-prediction equivalence:

| Regime | Credit/error bounds | Examples |
|--------|-------------------|---------|
| **Passive** (agent output does not affect stream) | K(µ)-bounded — tight, proven by Solomonoff | Sequence prediction, classification, LLMs |
| **Active** (agent output selects what information is revealed) | No K(µ)-bounded bound; proven impossible | Games, exploration, function minimization, ARC-AGI-3 |

The boundary is not a limitation of AIXI (AI with (X) induction (I)) — it is a formal impossibility result. No unbiased agent can guarantee bounded regret in active environments solely as a function of K(µ). This formalizes why pattern-recognition architectures (which solve only the passive case) are architecturally insufficient for abstract reasoning requiring exploration and planning.

### Intelligence Density: The Generative Dual of K

$\mathcal{I}(S) = \log_2 N(S) / C(S)$ (Choi 2026 [[wiki/papers/choi-intelligence-density-2026.md]] [[wiki/concepts/intelligence-density.md]]) is the **inverse/dual of Kolmogorov complexity**: $K$ compresses output → program (minimum description length for given data); $\mathcal{I}$ measures program → output generative power (diversity achievable from a given description length). The two measures are formally dual with opposite optimisation directions.

**Inverse of MDL:** Rissanen's Minimum Description Length finds the optimal $C$ that compresses given data. $\mathcal{I}$ instead asks: given a fixed $C$, how many Kolmogorov-independent outputs can the system produce?

**Uniform vs. non-uniform computation dichotomy:**
| Computation class | $C$ | Domain | $\mathcal{I}(n)$ | Status |
|---|---|---|---|---|
| Uniform (single Turing machine for all input sizes) | Fixed | Unbounded | $\to \infty$ | *Knows* |
| Non-uniform (different circuit per input size, e.g., VLSI adder family) | Grows with $n$ | Bounded per machine | $\Theta(1)$ | Computes but does not *know* |

The passive/active boundary from AIXI (AI with (X) induction (I)) theory and the uniform/non-uniform boundary from complexity theory are both manifestations of the same underlying distinction: whether a finite description can handle an unbounded domain.

### Scaling Law Twist

Standard log-loss rewards larger models unconditionally. *Adjusted* compression rate — (model bytes + compressed bytes) / raw bytes — has a critical point: beyond the optimal model size for each dataset size, additional parameters cost more than the compression gain they provide. Dataset size is a hard upper bound on usable model size. Chinchilla's compute-optimal scaling laws follow as a corollary of this compression theorem.

### Tokenization as Pre-Compression

Tokenization is lossless pre-compression: reduces sequence length (more information per context token) at the cost of a larger vocabulary (harder per-step prediction). The two effects cancel exactly in theory. In practice: small models benefit from larger vocabularies; large models do not. **Reasoning model implication:** tokenizer granularity determines the information density of the in-context WM window — the effective capacity of the fast inner loop.

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
      → FEP (Free Energy Principle) / Predictive Coding (hierarchical ELBO with local Hebbian updates)
        → TEM (factorized ELBO: structural g + episodic M)
```

Each step makes the same optimization more tractable or more biologically plausible.

---

## Open Problems for Reasoning Models

- **KL asymmetry as architectural choice:** `KL(P‖Q)` is mean-seeking — the model spreads probability mass to cover all modes of P, which can represent multiple competing hypotheses. `KL(Q‖P)` is mode-seeking — the model collapses to one mode. Which direction is used shapes whether a reasoning system can represent uncertainty over multiple interpretations simultaneously.

- **Two nested KL (Kullback-Leibler) problems:** the two-timescale architecture suggests a slow outer KL (Kullback-Leibler) (shared structure across environments) and a fast inner KL (Kullback-Leibler) (episodic content within one environment). No unified formal objective has been derived specifying how these interact.

---

## Connections

- **[[wiki/concepts/two-learning-timescales.md]]** — slow W and fast M each minimize cross-entropy over different distributions (cross-environment structural regularity vs. single-environment episodic binding); the two-timescale split is formally two nested KL (Kullback-Leibler) minimization problems with different data distributions P.
- **[[wiki/entities/tem-model.md]]** — TEM's training objective is cross-entropy minimization over sensory predictions; the KL-to-cross-entropy equivalence explains why TEM code uses cross-entropy loss despite the theory being framed as KL (Kullback-Leibler) divergence minimization.
- **[[wiki/concepts/predictive-coding.md]]** — FEP (Free Energy Principle) frames the cross-entropy + KL (Kullback-Leibler) objective as Bayesian brain inference: free energy F = −ELBO = accuracy cost + KL (Kullback-Leibler) complexity; minimizing F unifies perceptual inference (fast, activations) and model learning (slow, weights) under a single variational objective.
- **[[wiki/entities/boltzmann-machine.md]]** — partition function Z is the concrete instance of the log p(o) intractability that motivates the ELBO; the conceptual lineage from Boltzmann machine through variational Bayes to FEP (Free Energy Principle) is the historical progression from intractable to tractable optimization of the same objective.
- **[[wiki/papers/boltzmann-machine-transcript.md]]** — source for Boltzmann distribution derivation and partition function; motivates why variational inference exists.
- **[[wiki/papers/language-modeling-compression-deletang-2023.md]]** — empirical and theoretical grounding: log-loss = compression rate via arithmetic coding; Chinchilla 70B cross-modal compression as evidence that large-scale prediction extracts modality-agnostic structure; Solomonoff predictor as the ceiling; scaling law twist from adjusted compression rates; tokenization as pre-compression stage.
- **[[wiki/papers/hutter-aixi-2000.md]]** — extends Solomonoff's passive predictor to the active decision-making case via ξ^AI; establishes the passive/active boundary as a formal impossibility — K(µ)-bounded credit bounds exist only in passive environments; exploration emerges as a theorem from the Kolmogorov simplicity prior.
- **[[wiki/concepts/intelligence-density.md]]** — $\mathcal{I}$ is the generative dual of $K$ (output→program vs. program→output diversity) and the inverse of MDL; the uniform/non-uniform computation dichotomy maps exactly onto $\mathcal{I}(n) \to \infty$ (knowing) vs. $\mathcal{I}(n) = \Theta(1)$ (computation without knowing).
