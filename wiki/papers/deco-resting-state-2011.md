---
title: "Deco, Jirsa, McIntosh (2011) — Emerging Concepts for RSN Organization"
type: paper
tags: [resting-state-networks, criticality, neural-field-theory, metastability, default-mode-network, small-world-networks]
created: 2026-06-26
updated: 2026-06-26
sources: [deco-resting-state-2011]
related:
  - wiki/concepts/neural-field-theory.md
  - wiki/concepts/criticality.md
  - wiki/entities/default-mode-network.md
  - wiki/concepts/excitation-inhibition-balance.md
  - wiki/concepts/small-world-networks.md
  - wiki/entities/fcann.md
---

# Deco, Jirsa, McIntosh (2011) — Emerging Concepts for the Dynamical Organization of Resting-State Activity in the Brain

**Deco G, Jirsa VK, McIntosh AR (2011). Nature Reviews Neuroscience, 12, 43–56.**

---

## Key Computational Insights

Three RSN models, each isolating a mechanistic ingredient:

- **Model 1 (Honey et al. 2008):** Chaotic local oscillators + instantaneous anatomical coupling → cluster synchronization → anticorrelated RSN pairs. No delays, no noise. RSNs depend on complexity of local dynamics.
- **Model 2 (Ghosh et al. 2008):** Oscillators near stable equilibrium + transmission delays + noise → noise-driven exploration near the "critical line" (onset of oscillatory instability). Traveling alpha waves whose amplitude modulation produces 0.1-Hz BOLD fluctuations. Must operate near the critical line for RSNs to emerge.
- **Model 3 (Deco et al. 2009):** Wilson-Cowan nodes near Hopf bifurcation + delays + noise → stochastic resonance between two multistable cluster-synchronization states at optimal velocity v ≈ 1.65 m/s → anticorrelated RSN pairs and ultraslow 0.1-Hz oscillations.

**Unifying principle:** RSNs require *all three* of: (1) local dynamics near a bifurcation, (2) anatomical connectivity with transmission delays, (3) noise. Remove any one → RSN structure collapses (demonstrated explicitly in Model 3 by zeroing delays).

**Criticality as prerequisite:** "the stochasticity can express itself only if the deterministic framework of the network is critical — that is, close to instability" (p. 53).

**Metastability:** Brain explores possible functional network configurations (its "dynamic repertoire") without settling into a fixed attractor. DMN nodes are the key constituents that move the whole system toward this metastable state.

**Resting state as anticipatory exploration:** noise provides kinetic energy to sample possible functional architectures; anatomical skeleton constrains the repertoire; brain generates predictions about likely future network configurations (anticipatory Bayesian framing of spontaneous activity).

---

## Limitations

- Coarse 38–47 region parcellations; finer parcellations reveal additional RSNs
- Macaque CoCoMac connectivity extrapolated to human using Euclidean distances — underestimates realistic fiber lengths and delays
- Balloon–Windkessel BOLD approximation introduces hemodynamic confounds
- Predates high-resolution diffusion tractography; structural connectivity estimates less accurate than modern DSI/dMRI

---

## Links

- [[wiki/concepts/criticality.md]] — this paper establishes criticality as the necessary condition for RSN emergence
- [[wiki/concepts/neural-field-theory.md]] — Wilson-Cowan and oscillator models reviewed here are neural mass / neural field implementations
- [[wiki/entities/default-mode-network.md]] — DMN nodes are the critical metastability anchors in all three models
- [[wiki/concepts/excitation-inhibition-balance.md]] — near-Hopf working point (Model 3) is the E/I-balanced critical regime
- [[wiki/concepts/small-world-networks.md]] — all three models use CoCoMac small-world anatomical connectivity as structural skeleton
- [[wiki/entities/fcann.md]] — fcANN (Englert et al. 2026) formalizes the attractor landscape that Deco 2011 describes as the "dynamic repertoire"
