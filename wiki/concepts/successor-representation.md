---
title: "Successor Representation (SR)"
type: concept
tags: [successor-representation, reinforcement-learning, predictive-map, planning]
created: 2026-06-12
updated: 2026-07-18
sources: [cognitivemap]
related: [wiki/concepts/path-integration.md, wiki/concepts/structural-generalization.md, wiki/concepts/factorized-representations.md, wiki/concepts/temporal-context.md, wiki/entities/grid-cells.md, wiki/entities/place-cells.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/tem-model.md, wiki/entities/cscg-model.md, wiki/papers/whittington-cognitive-map-2022.md, wiki/papers/tem-whittington-2020.md, wiki/entities/spacetime-attractor.md, wiki/concepts/planning-as-inference.md, wiki/papers/mechanistic-planning-pfc-jensen-2026.md, wiki/papers/tcm-mtl-howard-2005.md, wiki/papers/garvert-abstract-relational-map-2017.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/hierarchical-reinforcement-learning.md, wiki/papers/daw-niv-dayan-uncertainty-arbitration-2005.md]
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

## Direct Human Evidence: SR as the Native Metric of an Abstract Graph

Garvert, Dolan & Behrens 2017 ([[wiki/papers/garvert-abstract-relational-map-2017.md]]) provide the most direct human confirmation that the brain represents a relational graph with an **SR-like predictive metric rather than a veridical/Euclidean one**. Subjects implicitly learned a hidden graph from random-walk object sequences (no explicit awareness); next-day entorhinal/subicular fMRI adaptation reconstructed the graph, and the best predictor of both the neural signal and behavioral RT was **communicability** $-e^{A}$ / the **successor representation** $(I-\gamma A)^{-1}$ — a weighted sum of future states — beating Euclidean distance in direct competition.

- This is the SR object itself (the RL-navigation representation) recovered for a **discrete, non-spatial** structure, learned **unconsciously** from experienced transitions.
- **Communicability** ($\sum_n A^n/n!$, the graph-theoretic matrix exponential) and the SR ($\sum_n \gamma^n A^n$) are near-equivalent weighted-future-state measures; communicability needs no free $\gamma$. Both **warp** the graph — shortening links on many random-walk paths, lengthening rarely-traversed ones — exactly the non-Euclidean distortion the SR predicts and a Euclidean map cannot.
- Trigger condition: the SR code appears when the graph is **sampled via transitions** (random walks), not merely known declaratively — see the metric-vs-declarative boundary in [[wiki/entities/hippocampal-entorhinal-system.md]].

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

## The MB/MF Online Arbiter (Daw, Niv & Dayan 2005)

The taxonomy above says *which* algorithm is accurate in which regime; **Daw, Niv & Dayan 2005** ([[wiki/papers/daw-niv-dayan-uncertainty-arbitration-2005.md]]) supply the missing runtime rule for *choosing between them per decision*. Two controllers sit at opposite ends of one trade-off — **tree-search** (model-based, PFC + dorsomedial striatum: value built on the fly by chaining transition/reward models, flexible but search-expensive) vs. **caching** (model-free TD, dorsolateral striatum: cached scalar values, cheap but bootstrapping-delayed and outcome-insensitive). SR is the *middle ground* — a cached predictive map that is still model-free but stores multi-step structure — so it sits *between* Daw's two poles rather than being one of them.

**Arbitration rule: run each controller's approximate-Bayesian version, track its posterior uncertainty (variance) over values, and let the *more certain* controller drive the response** (not the higher-value one). Uncertainty ≠ risk: it is ignorance about true values and asymptotes at a finite floor because the task can change (finite effective data-horizon).

| Regime | Lower-uncertainty controller | Behavior |
|---|---|---|
| Early training | MB (data propagate immediately; no bootstrap delay) | goal-directed / devaluation-sensitive |
| Over-trained, distal action, simple task | MF (MB accrues "computational noise" per search step; cache recalls) | habitual / devaluation-insensitive |
| Action proximal to reward | MB (fewer search steps → less accrued noise) | stays goal-directed |
| Complex task (data spread thin) | MB (data-efficiency edge preserved) | stays goal-directed |

**Partial evaluation:** search partway, substitute cached values for unexplored sub-trees, comparing uncertainties at each node to decide *expand-tree vs. fall-back-on-cache* — the same expand/skip decision that HRL option models make ([[wiki/concepts/hierarchical-reinforcement-learning.md]] saltatory search).

**Design implication (fills mechanism #4 of the HRL coverage audit / the D3 arbiter):** the proposed reasoning model handles MB/MF by *offline consolidation* only (replay-MCTS → STA weights). Daw adds the complementary *online* mechanism: a per-decision, uncertainty-gated switch between the deliberative planner (explore mode) and the cached policy (exploit mode). The gate is the **calibrated posterior variance** each controller already needs — the Neural-Process 3A encoder (diffuse K=1 → sharp K≥3) supplies exactly this signal, so the arbiter is a comparison of two uncertainties the model computes anyway rather than a new module.

## Temporal Precursor: The Temporal Context Model

SR did not appear in isolation. The Temporal Context Model (TCM; Howard & Kahana 2002; Howard et al. 2005 [[wiki/papers/tcm-mtl-howard-2005.md]]) is its conceptual ancestor: a leaky integrator `t_i = ρ_i t_{i-1} + β t_iᴵᴺ` whose similarity structure `t_i·t_j = ρ^{|i−j|}` is a decaying trace of past experience — exactly the object SR generalizes.

| | TCM temporal context | Successor Representation |
|---|---|---|
| Accumulated object | Item-driven inputs `t_iᴵᴺ` | State occupancy |
| Decay operator | Scalar ρ (single fixed rate) | Policy-dependent γT (full transition matrix) |
| Similarity kernel | `ρ^{|i−j|}` | `(I−γT)^{−1}` |
| Structure | Implicit (one leaky rate) | Explicit (learned/estimated T) |

The move from TCM to SR (and then to TEM's learned W) is the move from an unstructured scalar decay to a structured, action-conditioned transition operator. TCM already demonstrated that such a decaying trace produces place-like fields and transitive-inference gradients — SR explains *why* those fall out of the transition structure.

---

## Connections

- **[[wiki/concepts/temporal-context.md]]** — TCM is the temporal precursor from which SR descends: its scalar-ρ leaky integrator is the degenerate case of SR's policy-dependent γT, and its memory-space transitive-inference gradient is the pre-structural version of SR's predictive map.
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
- **[[wiki/concepts/recursion.md]]** — the successor function that generates discrete infinity (natural numbers, recursive count list) is the same iterated operation the SR applies (γT); Hauser-Chomsky-Fitch's domain-general-recursion hypothesis proposes this navigation/number machinery is what became the uniquely-human combinatorial engine.
- **[[wiki/papers/garvert-abstract-relational-map-2017.md]]** — direct human evidence that entorhinal cortex represents an implicitly-learned abstract graph with an SR/communicability metric (weighted sum of future states), not a Euclidean one; the SR object recovered for discrete non-spatial structure.
- **[[wiki/concepts/latent-graph-discovery.md]]** — the SR is the brain's native distance metric over a discovered latent graph; Garvert 2017 shows this metric is recovered unconsciously from random-walk experience, making SR the read-out of the discovery process.
- **[[wiki/concepts/hierarchical-reinforcement-learning.md]]** — SR/DR is the *flat* predictive map (per-primitive-step occupancy); HRL option models are its temporally-abstract counterpart (multi-step outcome/reward/duration predictions), letting model-based planning skip over primitive sub-sequences (saltatory search) — the temporal-abstraction extension of the same predictive-map idea.
- **[[wiki/papers/daw-niv-dayan-uncertainty-arbitration-2005.md]]** — supplies the *online* arbiter (uncertainty-gated per-decision switch) between pure model-based tree-search and pure model-free caching; SR sits as the cached-predictive-map middle ground between Daw's two poles, and the arbiter reuses the same calibrated posterior variance the model already tracks.
