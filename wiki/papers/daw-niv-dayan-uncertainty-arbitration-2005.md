---
title: "Uncertainty-based competition between prefrontal and dorsolateral striatal systems for behavioral control"
type: paper
tags: [model-based, model-free, arbitration, uncertainty, reinforcement-learning, tree-search, caching, prefrontal-cortex, dorsolateral-striatum, devaluation, hierarchical-reinforcement-learning]
created: 2026-07-18
updated: 2026-07-18
sources: [Uncertainty-based competition between prefrontal and dorsolateral striatal systems for behavioral control]
related: [wiki/concepts/successor-representation.md, wiki/concepts/meta-learning.md, wiki/concepts/hierarchical-reinforcement-learning.md, wiki/concepts/neuromodulation.md, wiki/entities/basal-ganglia.md, wiki/entities/prefrontal-cortex.md, wiki/queries/hrl-goal-decomposition-coverage.md, wiki/queries/proposed-reasoning-model-block-architectures.md]
---

# Uncertainty-based competition between prefrontal and dorsolateral striatal systems for behavioral control

**Daw, Niv & Dayan (2005). *Nature Neuroscience* 8(12): 1704–1711. doi: 10.1038/nn1560**

Normative RL account of *why* the brain has two action controllers and *how* it arbitrates when they disagree. Model + simulations reproduce the rat outcome-devaluation literature.

---

## Key Computational Insights

**Two controllers = two approximations to the value function, on opposite ends of one trade-off:**

| | Tree-search (model-based) | Caching (model-free) |
|---|---|---|
| Substrate | prefrontal cortex (+ dorsomedial striatum) | dorsolateral striatum + DA afferents |
| Value estimate | built *on the fly* by chaining one-step transition/reward models (tree search) | cached scalar `V`/`Q`, updated by TD **bootstrapping** |
| Strength | **statistically efficient** — one datum propagates to all states at once; flexible (tracks outcome devaluation) | **computationally cheap** — recall, no search |
| Weakness | search is expensive/error-prone → **"computational noise" accumulates per tree-search step** | bootstrapping **delays** data propagation → data-inefficient; **outcome-insensitive** (habitual) |
| Behavior | goal-directed (devaluation-sensitive) | habitual (devaluation-insensitive) |

**The arbitration rule (the paper's core proposal): deploy whichever controller is *more certain*.** Each system runs an approximate-Bayesian version of its algorithm and tracks the **posterior uncertainty (variance)** of its value estimates; the estimate from the lower-uncertainty controller wins (not the larger estimate). Uncertainty ≠ risk — it is ignorance about true values, which persists even with infinite experience because the task can change (finite effective time-horizon on data → uncertainties asymptote).

**What the uncertainty profiles predict** (matches the devaluation data):
- **Early training** → MB more certain (data propagate immediately) → goal-directed control.
- **Over-training** → MF catches up and, for actions *distal* from reward in *simple* tasks, wins (each extra tree-search step adds computational noise the cache does not incur) → habitual.
- **Proximity to reward** → fewer search steps → MB stays more certain even asymptotically → proximal actions stay devaluation-sensitive.
- **Task complexity** (more states/actions) → data spread thin → data-efficient MB keeps its edge → complex tasks stay goal-directed.
- **Structure:** fan-out favors caching; linear/fan-in favors search.

**Partial evaluation / interaction:** search partway down the tree, then substitute cached values for unexplored sub-trees — compare uncertainties at each node to decide *expand vs. fall back on cache* (Daw's SMDP-style DA account). Cache learning can also train/inform the tree (BG→cortex).

**Neural/arbitration substrate (tentative):** infralimbic cortex and ACC as candidate arbitrators (IL lesions reinstate goal-directed control); cholinergic/noradrenergic neuromodulation and population codes as uncertainty carriers.

---

## Limitations

- Strict-separation assumption is a modeling simplification; real substrates are intertwined (PFC is DA-innervated; cortico-striatal loops), and competition may be dorsomedial vs. dorsolateral *loops*, not cortex vs. striatum.
- Qualitative (not quantitative) fit to stylized tasks; DA's role in the tree-search controller is left "wholly unresolved."
- Uncertainty-tracking substrate is speculative; no direct measurement of the two posteriors.

---

## Links
- [[wiki/concepts/successor-representation.md]] — the MB/MF arbiter extends the TD/SR/STA reward-timescale taxonomy with an *online, uncertainty-gated* controller switch.
- [[wiki/concepts/meta-learning.md]] — Wang 2018 derives MB behavior emergent from MF training; Daw is the alternative where MB and MF are *separate* systems arbitrated per-decision by uncertainty.
- [[wiki/concepts/hierarchical-reinforcement-learning.md]] — partial evaluation (expand-tree vs. use-cache by uncertainty) is the option-model/saltatory-search decision at each node.
- [[wiki/entities/basal-ganglia.md]] / [[wiki/entities/prefrontal-cortex.md]] — DLS cache vs. PFC/DMS tree-search substrates.
- [[wiki/queries/hrl-goal-decomposition-coverage.md]] — fills mechanism #4 (explicit MB↔MF online arbiter) of the coverage audit.
