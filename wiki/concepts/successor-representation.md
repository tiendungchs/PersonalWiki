---
title: "Successor Representation (SR)"
type: concept
tags: [successor-representation, reinforcement-learning, predictive-map, planning]
created: 2026-06-12
updated: 2026-06-12
sources: [cognitivemap]
related: [wiki/concepts/path-integration.md, wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/entities/grid-cells.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/tem-model.md, wiki/entities/cscg-model.md, wiki/papers/whittington-cognitive-map-2022.md, wiki/papers/tem-whittington-2020.md]
---

# Successor Representation (SR)

**S_ij = expected discounted future occupancy of state j starting from state i. A "predictive map" connecting model-free RL to the cognitive map literature.**

Dayan (1993). Connected to hippocampal representations by Stachenfeld et al. (2017).

```
S = Σ_n γⁿ Tⁿ = (I − γT)⁻¹
```

Value decomposes cleanly: **v = S r** (map × reward vector). SR is one half of the value function — given S, computing values requires only a dot product, no tree search.

---

## SR and Neural Representations

- **Rows of S** plotted spatially → resemble hippocampal **place cells** (peaked, environment-specific)
- **Eigenvectors of S** plotted spatially → resemble entorhinal **grid cells** (periodic, multi-scale)

Since eigenvectors are identical for all powers of T (T^n = VΛⁿV^T — same V), grid codes support *multi-step* planning with the same representations as 1-step transitions. A single grid code works for local and non-local inference.

**Intuitive planning** (Baram et al., 2018): with start and goal grid representations, navigation reduces to vector operations — no trajectory search needed. Grid codes are metric and uniformly distributed.

---

## Unification with Path Integration

Path integration (CANN/VCO) and SR are the same mathematical structure: both operate on eigenvectors (grid codes as plane waves or grid patterns) and differ only in how eigenvalues are updated per action. Moving in direction `a` adds the corresponding eigenvalue.

This means SR-based planning and path-integration-based navigation are not competing theories — they are the same computation viewed from two different starting points (RL theory vs. navigation).

---

## Limitation: Policy Dependence → DR

SR depends on the current policy π. When rewards move, the SR is no longer optimal. The **Default Representation (DR)** (Piray & Daw, 2020) uses linear RL to build a policy-independent base representation that can be linearly updated when rewards change. The DR resembles SR and can be computed from grid cells. Also provides a compositional account of how grid and border cells represent barriers.

---

## Connections

- **[[wiki/concepts/path-integration.md]]** — SR and path integration are mathematically unified: both operate on grid-code eigenvectors and differ only in how eigenvalues update per action; they are not competing theories but the same computation from two perspectives.
- **[[wiki/concepts/structural-generalization.md]]** — SR provides an RL-theoretic derivation of why grid codes support multi-step planning with the same representations as 1-step transitions (T^n shares eigenvectors with S).
- **[[wiki/concepts/factorized-representations.md]]** — SR independently derives the factorized split: eigenvectors = grid cells (g, structural) and rows = place cells (p, conjunctive); a convergent derivation from RL theory.
- **[[wiki/entities/grid-cells.md]]** — SR eigenvectors → grid cells; same eigenvectors for all T^n means grid codes support multi-step planning at no extra cost. Verified Stachenfeld et al. 2017.
- **[[wiki/entities/place-cells.md]]** — SR rows → place cells; SR predicts their asymmetric fields (Mehta 2000) and barrier-induced fragmentation (Derdikman 2009). Verified Stachenfeld et al. 2017.
- **[[wiki/entities/tem-model.md]]** — TEM's structural code g is the implementation of the SR eigenvector representation; the W matrix in TEM encodes the transition structure that the SR formalizes as (I−γT)⁻¹.
- **[[wiki/entities/cscg-model.md]]** — CSCG uses clone-cell de-aliasing to build an accurate transition structure before computing the SR; the two models are complementary accounts of how the brain estimates T before taking the SR.
- **[[wiki/papers/whittington-cognitive-map-2022.md]]** — source for the SR-eigenvector=grid-cells and SR-rows=place-cells identifications; the paper provides the mathematical derivation that SR eigenvectors match observed grid cell properties.
- **[[wiki/papers/tem-whittington-2020.md]]** — TEM paper that derives the SR grid-cell equivalence from first principles; the path integration g-update RNN implements the SR's iterative γT application.
