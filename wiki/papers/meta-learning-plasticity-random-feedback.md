---
title: "Meta-learning biologically plausible plasticity rules with random feedback pathways"
type: paper
tags: [credit-assignment, meta-learning, hebbian-learning, feedback-alignment, plasticity-rules, biologically-plausible]
created: 2026-06-27
updated: 2026-06-27
sources: [meta-learning-plasticity-random-feedback]
related: [wiki/concepts/credit-assignment.md, wiki/concepts/meta-learning.md, wiki/concepts/hebbian-learning.md, wiki/concepts/dendritic-computation.md]
---

# Meta-learning biologically plausible plasticity rules with random feedback pathways

**Shervani-Tabar & Rosenbaum. Nature Communications, 2023.**

---

## Key Computational Insights

- **Weight transport failure:** Feedback alignment (FA; Lillicrap et al. 2016) replaces W^T with fixed random B but fails in deep networks and online/low-data regimes (~25% vs. 70% BP accuracy, 5-layer net, online MNIST).
- **Meta-learning setup:** Inner loop = online (batch=1) training from random weight init per episode (250 data points); outer loop = gradient through unrolled computation updates plasticity coefficients Θ; L1 penalty + meta-parameter sharing enforce sparsity and globally shared rules.
- **Discovered F^bio rule:**
  $$\mathcal{F}^{\text{bio}} = -\theta_0\mathbf{e}_\ell\mathbf{y}_{\ell-1}^T - \theta_2\mathbf{e}_\ell\mathbf{e}_{\ell-1}^T + \theta_9\!\left(\mathbf{y}_\ell\mathbf{y}_{\ell-1}^T - (\mathbf{y}_\ell\mathbf{y}_\ell^T)\mathbf{W}_{\ell-1,\ell}\right)$$
  Three terms: (1) pseudo-gradient, (2) eHebb (error-based Hebbian), (3) Oja's rule.
- **eHebb mechanism:** For linear networks, $\mathbb{E}[\mathbf{e}_\ell\mathbf{e}_{\ell-1}^T|B]\propto B^T$ — the error-correlation update pushes W toward B^T, creating an auxiliary channel that accelerates forward-backward weight alignment within the same iteration (vs. two-iteration delay for pure FA).
- **Oja's rule mechanism:** Promotes orthonormal weight rows via unsupervised PCA-like feature extraction; bypasses the alignment problem by improving the forward path independently of backward signals; reduces inter-row correlation, improving feature separation in hidden layers.
- **Biological grounding:** All three terms are local (update depends only on pre/post-synaptic signals and current weight). Burst/spike multiplexing or apical/basal dendritic compartments can implement the forward/backward signal separation eHebb requires; co-burst events between adjacent cortical layers implement the error co-activity product $\mathbf{e}_\ell\mathbf{e}_{\ell-1}^T$.

## Limitations

- Evaluated on MNIST/EMNIST classification only; not tested at ImageNet scale or in RL settings.
- The meta-training outer loop (gradient through unrolled computation) is not biologically plausible — the discovered rules are plausible but the discovery process is not.
- Meta-parameter sharing forces a single global rule; layer-specific rules may improve performance further.

## Links

- [[wiki/concepts/credit-assignment.md]] — F^bio as an improved feedback alignment entry in the bias–variance taxonomy; meta-learning as a systematic search over the plasticity-rule space
- [[wiki/concepts/meta-learning.md]] — meta-learning the plasticity coefficients themselves (not task representations or weight initializations) is a distinct axis of the meta-learning framework
- [[wiki/concepts/hebbian-learning.md]] — eHebb as an error-driven Hebbian variant; Oja's rule role in stabilizing multi-layer learning via unsupervised orthonormalization
- [[wiki/concepts/dendritic-computation.md]] — burst/spike multiplexing and apical/basal compartmentalization as the biological substrate enabling local forward/backward signal separation required by eHebb
