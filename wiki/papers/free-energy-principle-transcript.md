---
title: "Free Energy Principle — Conceptual Introduction (video transcript)"
type: paper
tags: [free-energy-principle, predictive-coding, generative-model, variational-inference]
created: 2026-06-12
updated: 2026-06-12
sources: [free-energy-principle-transcript]
related: [wiki/concepts/predictive-coding.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/latent-states.md, wiki/concepts/information-theory.md]
---

# Free Energy Principle — Conceptual Introduction (video transcript)

**Source:** Video transcript (conceptual/popular science level). No equations; motivation and intuitive structure only. Mathematical formalism deferred.

---

## Key Computational Insights

1. **Brains as generative model builders, not pattern matchers** — evolutionary pressure selected for internal world models that infer hidden causes from partial observations, not direct stimulus-response mappings. Pattern matching fails on occluded or ambiguous input; generative models fill gaps using prior knowledge.

2. **Free energy as the optimization target** — variational free energy = tension between sensory evidence and prior beliefs; minimizing it selects the latent explanation that best balances accuracy (fits observation) and complexity (respects prior). Low free energy = good explanation.

3. **Two-component generative model** — prior `p(z)` over causes + likelihood `p(o|z)` generating observations. The recognition model `q(z|o)` approximates the intractable posterior by running in the opposite direction: observation → causes.

4. **Approximate inference via recognition model** — exact Bayesian inversion is computationally intractable (exponential in latent dimensions); the recognition model provides a fast amortized approximation, refined by iterative generation-evaluation loops.

5. **Two-timescale free energy minimization** — fast perception (adjust recognition model activations for current input, ~100ms) and slow learning (adjust generative model weights over time) both minimize F but over different parameters at different timescales.

---

## Limitations

Conceptual only — no equations given. Active inference extension (action as free energy minimization) and hierarchical predictive coding not covered. Mathematical formalism deferred to future videos. Equations in [[wiki/concepts/predictive-coding.md]] are added from domain knowledge, not this source.

---

## Links

- [[wiki/concepts/predictive-coding.md]] — core framework; equations derived from domain knowledge
- [[wiki/concepts/two-learning-timescales.md]] — FEP (Free Energy Principle) provides principled basis for the fast/slow split
- [[wiki/concepts/latent-states.md]] — latent causes z in FEP (Free Energy Principle) = latent states
- [[wiki/concepts/information-theory.md]] — free energy = −ELBO; accuracy term = cross-entropy; complexity term = KL
