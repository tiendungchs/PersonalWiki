---
title: "The Free-Energy Principle: A Rough Guide to the Brain — Friston 2009"
type: paper
tags: [free-energy-principle, active-inference, predictive-coding, precision, neuromodulation, bayesian-brain]
created: 2026-06-21
updated: 2026-06-21
sources: [The free-energy principle - a rough guide to the brain]
related: [wiki/concepts/predictive-coding.md, wiki/concepts/neuromodulation.md, wiki/concepts/attention.md, wiki/concepts/two-learning-timescales.md, wiki/entities/prefrontal-cortex.md, wiki/entities/basal-ganglia.md]
---

# The Free-Energy Principle: A Rough Guide to the Brain — Friston 2009

**Citation:** Friston, K. (2009). The free-energy principle: a rough guide to the brain? *Trends in Cognitive Sciences*, 13(7), 293–301.

---

## Key Computational Insights

- **FEP as survival constraint:** Self-organizing agents must occupy a limited repertoire of states to exist (resist disorder) → must minimize long-term average surprise (entropy) → but surprise is intractable (requires knowing all hidden world states) → minimize variational free-energy F ≥ −log p(y|m) as a tractable upper bound. Every adaptive change in the brain minimizes F.

- **Active inference — action as symmetric to perception:** Perception reduces F by updating the recognition density q(z|m) to better approximate the true posterior (changes predictions). Action reduces F by changing sensory input y to conform to predictions (changes sensations). Both are gradient descents on F; they are complementary, not independent. Crucially, action can only affect the *accuracy* term of F, not complexity — so action samples the sensorium to make predictions self-fulfilling, resolving the gap between desired and actual states. This subsumes goal-directed behavior without requiring a value function.

- **Three-tier sufficient statistics:** The brain encodes three classes of sufficient statistics, each minimizing F at a different timescale: (1) **states** — synaptic activity encoding expected hidden causes (~ms, perceptual inference); (2) **parameters/weights** — synaptic efficacy encoding causal regularities (hours–days, perceptual learning = Hebbian-like ε·x plasticity); (3) **precisions** — synaptic gain encoding inverse variance of states (~100ms, attention). Recognition dynamics for states are first-order ODEs; for parameters and precisions, they are second-order with accumulated gradient traces (synaptic tags). This partitions the brain's optimization into three non-redundant tiers.

- **Attention = precision optimization, not channel selection:** Under hierarchical generative models, inference requires weighting prediction errors by their reliability (precision = inverse variance). Optimizing precision scales the gain of error-units; high-precision errors exert greater influence on representations above. This is the mathematical definition of attention: "attention is simply the process of optimising precision during hierarchical inference" (Friston 2009). Cholinergic (ACh) gain modulation in posterior sensory systems is the neurobiological implementation — precision in exteroceptive hierarchies.

- **DA as precision / incentive salience (contradicts Doya 2002's DA = TD error):** If action is called upon to suppress prediction errors *when predictions are precise*, then dopamine encoding precision of prior expectations (not prediction error on reward) produces all the same behavioral signatures — plus explains bradykinesia in Parkinson's disease as impoverished action from imprecise priors (low DA → small prediction errors → poverty of movement). Friston reframes DA as encoding "the value of prediction error" (incentive salience, per Berridge 2007) rather than "the prediction error on value" (TD error, per Schultz 1998). See **Contradiction** in [[wiki/concepts/neuromodulation.md]].

---

## Limitations

- Opinion/review paper (2009): no computational experiments; implementation details are sketched via the DCM framework rather than derived from scratch.
- Laplace (Gaussian) approximation is convenient but may be too restrictive for multimodal recognition densities (bistable percepts are cited as evidence against multimodal q, but this is debated).
- DA = precision vs. DA = TD error remains empirically unresolved; both accounts make similar predictions for standard reward-conditioning paradigms.

---

## Links

- [[wiki/concepts/predictive-coding.md]] — core FEP formalism; this paper adds active inference (action) and precision (three-tier representation)
- [[wiki/concepts/neuromodulation.md]] — Contradiction: DA=precision here vs. DA=TD error (Doya 2002)
- [[wiki/concepts/attention.md]] — biological attention redefined as precision optimization, complementary to transformer self-attention account
- [[wiki/entities/basal-ganglia.md]] — action selection in BG interpreted as DA-gated precision that enables motor action
