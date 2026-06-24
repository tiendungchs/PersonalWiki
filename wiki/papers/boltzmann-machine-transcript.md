---
title: "Boltzmann Machine — From Hopfield to Generative Models (transcript)"
type: paper
tags: [boltzmann-machine, hopfield, generative-model, contrastive-learning, stochastic, rbm, energy-based]
created: 2026-06-12
updated: 2026-06-12
sources: [bolzman-machine-transcript]
related: [wiki/entities/boltzmann-machine.md, wiki/concepts/predictive-coding.md, wiki/concepts/attention.md, wiki/concepts/information-theory.md]
---

# Boltzmann Machine — From Hopfield to Generative Models (transcript)

**Citation:** Tutorial video transcript (YouTube), ~30 min. No author/date given. Builds directly on a prior Hopfield network video; derives Boltzmann distribution from statistical physics, stochastic update rule, contrastive Hebbian learning, and RBM (Restricted Boltzmann Machine) variant from first principles.

---

## Key Computational Insights

- **Boltzmann distribution derives sigmoid:** P(x_i=1) = σ(2h_i/T) is not an architectural choice — it is derived from the Boltzmann distribution applied to the binary on/off case with Hopfield energy; the sigmoid and the Boltzmann distribution are the same object.
- **Contrastive Hebbian learning has two phases:** positive phase (data-clamped) computes ⟨x_i x_j⟩_data; negative phase (free-running) computes ⟨x_i x_j⟩_free; Δw ∝ difference — strengthening data-correlated weights, weakening hallucination-correlated weights.
- **Partition function Z is intractable:** computing log Z = log Σ_s exp(−E(s)/T) over all 2^N states is the computational bottleneck; this is the problem that variational inference (ELBO/FEP) was developed to solve.
- **Hidden units as latent variables:** hidden units develop internal representations capturing higher-order correlations absent in visible units alone; conceptual precursor to VAE latent codes and TEM's structural code g.
- **RBM bipartite structure enables parallel updates:** removing within-layer connections allows simultaneous update of all units in a layer given the other layer — O(1) instead of O(N) serial updates.

## Limitations

- Contrastive divergence (k-step approximation to negative phase) introduced as a practical workaround but not derived; its bias is not discussed.
- Temperature T treated as a static hyperparameter; annealing schedules (simulated annealing) not covered.
- Connection to modern generative models (VAEs, diffusion) mentioned in conclusion but not formalized; the ELBO bridge not derived.

## Relevant Pages

- [[wiki/entities/boltzmann-machine.md]]
- [[wiki/concepts/predictive-coding.md]]
- [[wiki/concepts/attention.md]]
- [[wiki/concepts/information-theory.md]]
- [[wiki/concepts/two-learning-timescales.md]]
- [[wiki/entities/tem-model.md]]
