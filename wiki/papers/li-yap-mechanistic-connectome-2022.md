---
title: "From descriptive connectome to mechanistic connectome: Generative modeling in functional magnetic resonance imaging analysis"
type: paper
tags: [connectome, effective-connectivity, generative-models, fMRI, DCM, BNM, neural-field-theory, excitation-inhibition]
created: 2026-06-28
updated: 2026-06-28
sources: []
related:
  - wiki/concepts/neural-field-theory.md
  - wiki/concepts/excitation-inhibition-balance.md
  - wiki/concepts/criticality.md
  - wiki/entities/default-mode-network.md
---

Li G & Yap PT — Frontiers in Human Neuroscience, 2022. [https://doi.org/10.3389/fnhum.2022.940842](https://doi.org/10.3389/fnhum.2022.940842)

---

## Key Computational Insights

- **FC (Functional Connectivity) is descriptive, EC (Effective Connectivity) is mechanistic**: FC (undirected, unsigned, correlational) cannot reveal circuit directionality or excitation/inhibition polarity; EC (directed, signed) requires a generative model of neural interactions, enabling mechanistic inference about coupling strengths
- **Three generative modeling frameworks** for fMRI EC estimation:
  - **DCM (Dynamic Causal Model)** — Bayesian model inversion (Variational Laplace) for individual-subject EC; two-stage (inversion + model comparison via Bayes factor); gold standard for small networks; computationally expensive for whole-brain
  - **BNM (Biophysical Network Model)** — population-level neural dynamics (Wilson-Cowan, Hopf) fit to empirical SC; estimation methods MOU-EC (moment-based) and MNMI (E/I-balanced); whole-brain tractable; loses single-subject granularity
  - **DNM (Dynamic Neural Model)** — direct parameterization of connectivity matrix from data without full biophysical simulation; intermediate trade-off (faster than BNM, more flexible than DCM)
- **"Mechanistic connectome" concept**: transformation from correlation-based SC/FC atlas to causal, directed, signed EC map; enables prediction of symptom-specific circuit disruptions (e.g., amygdala E/I changes in MDD) and targeted interventions

## Limitations

- Review paper only — no novel empirical results; no consensus on best EC estimation method across frameworks
- DCM is limited to small predefined networks; BNM requires assumptions about neural mass model form; DNM lacks biophysical interpretability

## Links to Concept/Entity Pages

- [[wiki/concepts/neural-field-theory.md]] — Wilson-Cowan / Hopf oscillator neural mass models used in BNM are neural field theory instances; MOU-EC and MNMI are estimation methods for NFT-grounded generative models
- [[wiki/concepts/excitation-inhibition-balance.md]] — MNMI directly estimates per-region E/I balance from fMRI; MDD E/I disruption example shows clinical applicability of EC-based E/I inference
- [[wiki/concepts/criticality.md]] — BNMs are typically tuned near the critical (Hopf) bifurcation point; provides additional review context for criticality as the operating regime of large-scale brain models
- [[wiki/entities/default-mode-network.md]] — EC mapping identifies DMN as a key hub in directed information flow; mechanistic models show DMN's role in whole-brain attractor dynamics
