---
title: "Successor Representation (SR)"
type: concept
tags: [successor-representation, reinforcement-learning, predictive-map, planning]
created: 2026-06-12
updated: 2026-06-28
sources: [cognitivemap]
related: [wiki/concepts/path-integration.md, wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/entities/grid-cells.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/tem-model.md, wiki/entities/cscg-model.md, wiki/papers/whittington-cognitive-map-2022.md, wiki/papers/tem-whittington-2020.md, wiki/entities/spacetime-attractor.md, wiki/concepts/planning-as-inference.md, wiki/papers/mechanistic-planning-pfc-jensen-2026.md]
---

# Successor Representation (SR)

**S_ij = expected discounted future occupancy of state j starting from state i. A "predictive map" connecting model-free RL to the cognitive map literature.**

Dayan (1993). Connected to hippocampal representations by Stachenfeld et al. (2017).

```
S = Σ_n γⁿ Tⁿ = (I − γT)⁻¹
```

Value decomposes cleanly: **v = S r** (map × reward vector). SR (Successor Representation) is one half of the value function — given S, computing values requires only a dot product, no tree search.

---

## SR (Successor Representation) and Neural Representations

- **Rows of S** plotted spatially → resemble hippocampal **place cells** (peaked, environment-specific)
- **Eigenvectors of S** plotted spatially → resemble entorhinal **grid cells** (periodic, multi-scale)

Since eigenvectors are identical for all powers of T (T^n = VΛⁿV^T — same V), grid codes support *multi-step* planning with the same representations as 1-step transitions. A single grid code works for local and non-local inference.

**Intuitive planning** (Baram et al., 2018): with start and goal grid representations, navigation reduces to vector operations — no trajectory search needed. Grid codes are metric and uniformly distributed.

---

## Unification with Path Integration

Path integration (CANN/VCO) and SR (Successor Representation) are the same mathematical structure: both operate on eigenvectors (grid codes as plane waves or grid patterns) and differ only in how eigenvalues are updated per action. Moving in direction `a` adds the corresponding eigenvalue.

This means SR-based planning and path-integration-based navigation are not competing theories — they are the same computation viewed from two different starting points (RL theory vs. navigation).

---

## Limitation: Policy Dependence → DR

SR depends on the current policy π. When rewards move, the SR (Successor Representation) is no longer optimal. The **Default Representation (DR)** (Piray & Daw, 2020) uses linear RL to build a policy-independent base representation that can be linearly updated when rewards change. The DR resembles SR (Successor Representation) and can be computed from grid cells. Also provides a compositional account of how grid and border cells represent barriers.

---

## Three-Algorithm Taxonomy by Reward Timescale

Jensen et al. 2026 provide a clean empirical dissociation across task types:

| Algorithm | Neural substrate | Handles | Fails on |
|---|---|---|---|
| **TD learning** | Striatum | Static rewards (fixed goal) | Any reward change |
| **SR** | Hippocampus | Cross-trial reward change (v = Sr̄) | Within-trial dynamic rewards (averages over time) |
| **STA (Spacetime Attractor)** | PFC | Within-trial dynamic rewards (separate R_{δi} per timestep) | Novel environments (W must be pre-learned) |

SR fails on within-trial dynamic tasks because the successor matrix collapses future occupancy across time, producing time-averaged values. The STA avoids this by maintaining a separate representation for each future timestep, so each subspace δ can receive an independent reward input R_{δi}.

Design implication: SR and STA are complementary, not competing. SR provides efficient planning when environment structure is stable and rewards change between but not within trials. STA takes over when rewards change within a single trial or episode.

## Connections

- **[[wiki/concepts/path-integration.md]]** — SR (Successor Representation) and path integration are mathematically unified: both operate on grid-code eigenvectors and differ only in how eigenvalues update per action; they are not competing theories but the same computation from two perspectives.
- **[[wiki/concepts/structural-generalization.md]]** — SR (Successor Representation) provides an RL-theoretic derivation of why grid codes support multi-step planning with the same representations as 1-step transitions (T^n shares eigenvectors with S).
- **[[wiki/concepts/factorized-representations.md]]** — SR (Successor Representation) independently derives the factorized split: eigenvectors = grid cells (g, structural) and rows = place cells (p, conjunctive); a convergent derivation from RL theory.
- **[[wiki/entities/grid-cells.md]]** — SR (Successor Representation) eigenvectors → grid cells; same eigenvectors for all T^n means grid codes support multi-step planning at no extra cost. Verified Stachenfeld et al. 2017.
- **[[wiki/entities/place-cells.md]]** — SR (Successor Representation) rows → place cells; SR (Successor Representation) predicts their asymmetric fields (Mehta 2000) and barrier-induced fragmentation (Derdikman 2009). Verified Stachenfeld et al. 2017.
- **[[wiki/entities/tem-model.md]]** — TEM's structural code g is the implementation of the SR (Successor Representation) eigenvector representation; the W matrix in TEM encodes the transition structure that the SR (Successor Representation) formalizes as (I−γT)⁻¹.
- **[[wiki/entities/cscg-model.md]]** — CSCG uses clone-cell de-aliasing to build an accurate transition structure before computing the SR; the two models are complementary accounts of how the brain estimates T before taking the SR.
- **[[wiki/papers/whittington-cognitive-map-2022.md]]** — source for the SR-eigenvector=grid-cells and SR-rows=place-cells identifications; the paper provides the mathematical derivation that SR (Successor Representation) eigenvectors match observed grid cell properties.
- **[[wiki/papers/tem-whittington-2020.md]]** — TEM paper that derives the SR (Successor Representation) grid-cell equivalence from first principles; the path integration g-update RNN implements the SR's iterative γT application.
- **[[wiki/entities/spacetime-attractor.md]]** — STA is the PFC complement to HC's SR: SR collapses future occupancy across time into time-averaged value; STA maintains a separate representation per future timestep, extending SR's power to within-trial dynamic rewards.
- **[[wiki/concepts/planning-as-inference.md]]** — SR is a special case of planning as inference where the future is compressed into a single time-averaged representation (v = Sr); STA generalizes this by maintaining per-timestep representations and using attractor dynamics rather than a dot product.
