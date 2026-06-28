---
title: "fcANN (Functional Connectivity-based Attractor Neural Network)"
type: entity
tags: [attractor-networks, functional-connectivity, free-energy-principle, brain-dynamics, kanter-sompolinsky, hopfield, whole-brain-model]
created: 2026-06-25
updated: 2026-06-27
sources: [fcann-attractor-dynamics-englert-2026]
related: [wiki/concepts/energy-based-models.md, wiki/concepts/predictive-coding.md, wiki/entities/default-mode-network.md, wiki/concepts/ring-attractor.md, wiki/concepts/working-memory.md, wiki/entities/gwt-model.md, wiki/entities/boltzmann-machine.md, wiki/papers/fcann-attractor-dynamics-englert-2026.md, wiki/concepts/excitation-inhibition-balance.md, wiki/papers/schirner-deco-ritter-2023.md, wiki/papers/mapping-structural-core-hagmann-2008.md, wiki/papers/honey-2009-sc-fc.md, wiki/entities/c2c-model.md]
---

# fcANN (Functional Connectivity-based Attractor Neural Network)

**A macro-scale brain dynamics model that reconstructs a free-energy-minimizing attractor network from functional MRI data, where coupling weights are the negative precision matrix J = −Σ⁻¹ and attractor states are the eigenvectors of J.**

Proposed by Englert et al. (2026); theoretical basis in Spisak & Friston (2025).

---

## Architecture

| Component | Description |
|---|---|
| **Network nodes** | Brain parcels (~122 regions, BASC atlas); each σᵢ ∈ [−1, 1] |
| **Coupling weights** | J = −Σ⁻¹ (negative precision matrix of resting-state fMRI time series) |
| **Inference rule** | σᵢ(t+1) = L(β Σⱼ Jᵢⱼ σⱼ(t)) + noise; L = Langevin sigmoid |
| **Inverse temperature** | β controls attractor count (β=0.04 → 4 states; increasing β → more states) |
| **Noise parameter** | ε=0.37 for stochastic generative mode; ε→0 for deterministic attractor finding |
| **Attractor finding** | Deterministic relaxation from 100,000 random initializations |
| **Generative mode** | Stochastic relaxation samples from posterior; reproduces empirical resting-state dynamics |

**Steady-state distribution:** p*(σ) ∝ exp(Σᵢ bᵢσᵢ + ½ Σᵢⱼ J^S_ij σᵢσⱼ) where J^S = ½(J + Jᵀ). The antisymmetric component J^A induces only solenoidal flow tangential to p* — steady state depends only on J^S. Structurally identical to a continuous Boltzmann machine.

**Self-orthogonalization learning rule (theoretical):** ΔJᵢⱼ ∝ σᵢσⱼ (Hebbian) − L(bᵢ + Σₖ Jᵢₖ σₖ) σⱼ (anti-Hebbian, contrastive PC). This rule drives attractors toward orthogonality during learning — not implemented in fcANN (J is read off from data), but tested as an empirical prediction.

---

## Key Results (Englert et al. 2026, 7 datasets, ~1,400 participants)

| Question | Finding |
|---|---|
| **Q1** K-S projector? | Eigenvectors of J align with attractor states >> null (permutation p<0.001); brain ≈ Kanter-Sompolinsky projector |
| **Q2** Fast convergence? | ~9× faster than permuted null (383 vs. 3,543 iterations at β=0.04) |
| **Q3** Optimal params | β=0.04 → 4 attractors; ε=0.37 → best non-Gaussian fit (Glass δ = −11.63 vs. Gaussian null) |
| **Q4** Bio plausibility | 4 states: DMN/anti-DMN + perception-action cycle axis; CV accuracy 96.5% |
| **Q5** Resting-state | Stochastic dynamics reproduce state occupancy, temporal trajectory, non-Gaussian conditionals |
| **Q6** Task prediction | Pain/self-regulation dynamics predicted from resting fcANN + weak task perturbation |
| **Q7** ASD prediction | ASD-initialized fcANN predicts group differences in basin occupancy vs. typically developing controls |

---

## Kanter-Sompolinsky (K-S) Projector

In a K-S projector network, all stored patterns are **exactly orthogonal** → coupling matrix W = Σₖ ξₖξₖᵀ (sum of rank-1 outer products) → eigenvectors of W are exactly the stored patterns. Properties:
- **Maximum storage capacity**: N orthogonal attractors in N-dimensional space (vs. ~0.14N for random Hopfield)
- **Perfect recall**: no spurious attractors; each pattern is a strict energy minimum
- **Empirical test**: if eigenvectors of J ≈ attractor states → system is near-K-S → evidence for FEP-based self-organization

fcANN uses eigenvector alignment as the empirical signature to test whether the brain approximates a K-S projector.

---

## Comparison to Related Models

| Model | Coupling source | Attractor type | Scale |
|---|---|---|---|
| **fcANN** | J = −Σ⁻¹ (FC data) | ~Orthogonal K-S | Whole-brain (macro) |
| **Classic Hopfield** | Hebbian write Σ ξξᵀ/N | Random, overlapping | Any |
| **Ring attractor** | Cosine W_ij = A cos(θᵢ − θⱼ) | Continuous circular | Local circuit |
| **Boltzmann machine** | Contrastive Hebbian | Probabilistic | Any |
| **Reservoir computing** | Random fixed W | Chaotic/echo-state | Local |

---

## Design Implications for Reasoning Models

- **Orthogonal discrete latent states**: derive state space from eigenvectors of learned connectivity — orthogonality prevents attractor interference without requiring any explicit regularization
- **Connectivity → attractors**: J = −Σ⁻¹ is a parameter-free way to extract the attractor landscape from co-activation statistics; no architecture search needed for state space
- **β as cognitive regime**: low β = few broad basins (coarse task/rest distinction); high β = many fine-grained states; β is the precision/temperature of the prior over cognitive states
- **Basin occupancy entropy as health diagnostic**: collapse to a single dominant basin = disease (ASD) or reduced consciousness (anesthesia); high entropy = rich reasoning capacity

---

## Connections

- **[[wiki/concepts/energy-based-models.md]]** — fcANN is an EBM instantiation at whole-brain scale; J = −Σ⁻¹ specifies the energy landscape; K-S orthogonality is the biologically observed solution to EBM collapse at the systems level
- **[[wiki/concepts/predictive-coding.md]]** — grounded in FEP-ANNs (Spisak & Friston 2025); stochastic relaxation = free energy minimization; the self-orthogonalization learning rule is a contrastive predictive coding rule (Hebbian − anti-Hebbian)
- **[[wiki/entities/default-mode-network.md]]** — DMN is the principal resting-state attractor (first attractor pair in fcANN); task engagement = transition to anti-DMN or perception-action attractor; ASD's impaired DMN suppression corresponds to altered attractor geometry
- **[[wiki/concepts/ring-attractor.md]]** — fcANN is the whole-brain macro-scale extension of the ring attractor principle: eigenvectors define N-dimensional "positions" analogous to the ring's equi-spaced bump positions; approximate K-S orthogonality replaces the ring's exact circular periodicity
- **[[wiki/concepts/working-memory.md]]** — provides macro-scale empirical support for the attractor WM theory; approximate orthogonality of brain attractors addresses the interference objection at the systems level
- **[[wiki/entities/gwt-model.md]]** — basin occupancy entropy parallels GNW's dynamic repertoire diversity: disease/anesthesia reduces the brain's attractor state space, just as GNW documents collapse of dynamic repertoire under propofol/sevoflurane
- **[[wiki/entities/boltzmann-machine.md]]** — fcANN has the same steady-state form as a continuous Boltzmann machine; the self-orthogonalization rule is a specific contrastive Hebbian variant
- **[[wiki/concepts/excitation-inhibition-balance.md]]** — Schirner et al. 2023 shows that resting-state FC (the quantity fcANN uses as its attractor landscape via J = −Σ⁻¹) is a monotonic proxy for the whole-brain E/I regime; this provides mechanistic grounding for fcANN's design: J encodes the E/I operating point, not merely resting co-activation geometry, and thereby predicts individual differences in decision-making quality.
- **[[wiki/papers/fcann-attractor-dynamics-englert-2026.md]]** — primary source
- **[[wiki/papers/mapping-structural-core-hagmann-2008.md]]** — provides the structural ground for fcANN's J = −Σ⁻¹ design: r² = 0.62 between DSI-derived structural connectivity and resting-state FC means the functional precision matrix encodes white-matter topology; the structural core (PCC, precuneus, parietal) directly maps onto fcANN's principal DMN/anti-DMN attractor axis
- **[[wiki/papers/honey-2009-sc-fc.md]]** — companion SC→FC analysis (same DSI dataset): SC-rsFC r = 0.66 at 66 regions; indirect 2-hop SC induces FC between unconnected pairs (r = 0.29); rsFC reliability r = 0.38–0.69 shows J = −Σ⁻¹ samples from a distribution, not a fixed landscape; neural mass model reproduces rsFC from SC alone, validating the SC-topology-as-attractor-landscape principle underlying fcANN
- **[[wiki/entities/c2c-model.md]]** — complementary generative model: C2C learns the linear trajectory through the attractor landscape (rest → specific task state) while fcANN recovers the static energy landscape itself; C2C's task-general subsystems (especially the DMN component 6) correspond to the stable basin structure that fcANN's DMN/anti-DMN primary axis represents
