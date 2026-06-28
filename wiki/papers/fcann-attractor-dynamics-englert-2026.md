---
title: "Functional connectivity-based attractor dynamics of the human brain in rest, task, and disease"
type: paper
tags: [attractor-networks, functional-connectivity, free-energy-principle, brain-dynamics, resting-state, autism, kanter-sompolinsky]
created: 2026-06-25
updated: 2026-06-25
sources: [fcann-attractor-dynamics-englert-2026]
related: [wiki/entities/fcann.md, wiki/concepts/energy-based-models.md, wiki/concepts/predictive-coding.md, wiki/entities/default-mode-network.md, wiki/concepts/ring-attractor.md, wiki/concepts/working-memory.md, wiki/entities/gwt-model.md]
---

# Functional connectivity-based attractor dynamics of the human brain in rest, task, and disease

Englert R, Kincses B, Kotikalapudi R, Gallitto G, Li J, Hoffschlag K, Woo CW, Wager TD, Timmann D, Bingel U. (2026). *eLife*. https://doi.org/10.7554/eLife.98725

---

## Key Computational Insights

- **fcANN construction**: J = −Σ⁻¹ (negative precision matrix of regional fMRI time series = attractor coupling weights); functional connectome directly encodes the attractor landscape without additional fitting
- **K-S projector confirmed (Q1)**: eigenvectors of J align with attractor states significantly above null (permutation p<0.001 across 7 datasets); brain approximates a Kanter-Sompolinsky projector network — the capacity-optimal attractor architecture where memories are exactly the coupling eigenvectors and are mutually orthogonal
- **Self-orthogonalization**: approximate orthogonality of brain attractors is predicted by the FEP-ANN learning rule (ΔJ ∝ Hebbian − anti-Hebbian contrastive PC) and is not a generic property of all attractor networks — constitutes evidence for FEP-based macro-scale self-organization
- **Fast convergence (Q2)**: FC topology confers ~9× faster attractor convergence than permuted null (383 vs. 3,543 iterations at β=0.04) — functional topology is pre-optimized for efficient attractor dynamics
- **4 biologically grounded attractors (Q3–4)**: at β=0.04 four states emerge in symmetric pairs: (1) DMN vs. (2) anti-DMN/sensorimotor-extrinsic axis, (3–4) perception-action cycle axis; CV classification accuracy 96.5%
- **Resting-state reproduction (Q5)**: stochastic relaxation (ε=0.37) reproduces non-Gaussian conditional dependencies, state occupancy, and temporal trajectory of empirical fMRI beyond a covariance-matched Gaussian (Glass δ = −11.63)
- **Task prediction (Q6)**: resting-state fcANN + weak condition-specific perturbation predicts pain vs. rest and self-regulation task dynamics in held-out data
- **Disease prediction (Q7)**: ASD-initialized fcANN predicts observed group differences in attractor basin occupancy vs. typically developing controls; ASD maps to altered attractor geometry

## Limitations

- J = −Σ⁻¹ assumes symmetric effective couplings; asymmetric (directed) components J^A induce only solenoidal flow and are not captured — true directional connectivity is lost
- β=0.04 and ε=0.37 are heuristically optimized for one dataset; generalization to other parcellations/tasks requires refit
- Macro-scale parcellation (~122 regions) abstracts away meso/micro-scale variability; attractors are population-level summaries, not cellular

## Links

→ [[wiki/entities/fcann.md]] — entity page for the model
→ [[wiki/concepts/energy-based-models.md]] — fcANN is an EBM instantiation; K-S projector = orthogonal Hopfield variant
→ [[wiki/concepts/predictive-coding.md]] — FEP-ANN grounding; attractor inference = free energy minimization via stochastic relaxation
→ [[wiki/entities/default-mode-network.md]] — DMN is the principal resting-state attractor
→ [[wiki/concepts/ring-attractor.md]] — macro-scale analog of the ring attractor's equi-spaced fixed points
→ [[wiki/concepts/working-memory.md]] — attractor WM theory: macro-scale orthogonal attractors as systems-level evidence
→ [[wiki/entities/gwt-model.md]] — dynamic repertoire diversity as reasoning-quality indicator
