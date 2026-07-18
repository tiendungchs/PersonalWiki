---
title: "Cognitive Control over Learning: Creating, Clustering and Generalizing Task-Set Structure — Collins & Frank 2013"
type: paper
tags: [task-set, structure-learning, corticostriatal-gating, dirichlet-process, nonparametric-bayes, cognitive-control, pbwm, transfer, clustering]
created: 2026-07-18
updated: 2026-07-18
sources: [Cognitive control over learning Creating, clustering and generalizing task-set structure]
related: [wiki/entities/basal-ganglia.md, wiki/concepts/cognitive-control.md, wiki/concepts/contextual-inference.md, wiki/papers/pbwm-oreilly-frank-2006.md, wiki/papers/heald-coin-contextual-inference-2021.md, wiki/queries/hrl-goal-decomposition-coverage.md, wiki/entities/prefrontal-cortex.md]
---

# Cognitive Control over Learning — Collins & Frank 2013

**Collins, A. G. E. & Frank, M. J. (2013). Cognitive control over learning: Creating, clustering, and generalizing task-set structure. *Psychological Review*, 120(1), 190–229.**

Three-level account (Bayesian model → neural network → human experiments) of how the brain *creates, reuses, and generalizes* latent task-set (TS) structure during uninstructed learning. The direct ancestor of COIN ([[wiki/papers/heald-coin-contextual-inference-2021.md]]) on the cognitive-control side, and the structure-learning extension of PBWM ([[wiki/papers/pbwm-oreilly-frank-2006.md]]).

## Key computational insights

- **C-TS model = Dirichlet-process (Chinese-restaurant) clustering of contexts onto latent task-sets.** A TS defines stimulus→action→outcome contingencies; contexts cue TSs but *not* 1:1 — many contexts can share one TS. Prior on a new context `c`: reuse TS_i with prob ∝ its popularity `N_i`, create a new TS with prob ∝ **α** (concentration parameter). Low α → aggressive clustering/reuse; high α → flat learner (one state per context).
- **Approximate online inference = single-particle filter.** Each trial the joint posterior over clusterings is collapsed onto one MAP task-set assignment (ex-post, after reward); only that TS's S-A weights update, and it becomes the inferred TS on the next encounter of `c`. Tractable, incremental, trial-by-trial fittable — deliberately *not* exact inference (which is intractable).
- **Neural implementation = two nested corticostriatal gating loops.** Anterior PFC-BG loop gates an *abstract* TS stripe in response to context (the same Go/NoGo/DA machinery as motor selection, but PFC stripes carry latent states with **no a-priori "correct" target** — the network invents its own structure). The gated PFC TS multiplexes with the stimulus in parietal cortex → serves as input to a posterior PMC-BG loop that gates the motor action. This extends PBWM/Frank & Badre 2011 from WM-gating to **structure creation**: adding a "blank" PFC stripe = creating a new TS.
- **Diagonal cross-loop projection → RT signature.** TS-level conflict (co-active PFC stripes) drives STN in the motor loop, raising the motor decision threshold until the TS is resolved → switch-cost RTs; also expands the effective state space, reducing cross-task interference.
- **Incidental structure building (the headline behavioral result).** Humans (2 experiments, N=33+) spontaneously impose C-TS structure on a *flat* learning problem that neither requires nor benefits from it during acquisition — and even pays a cost for it (6 links vs. 4; harder credit assignment; slower initial learning). Payoff is **transfer**: positive transfer when a new context maps to a known TS (C3), **negative transfer** when a new context overlaps old TSs (C4, elevated neglect-context errors). α governs the positive↔negative transfer tradeoff.

## Limitations

- Which input dimension is context vs. stimulus is **given**, not inferred, in the core model (the "generalized structure model" infers it but is only lightly explored).
- Single-trial MAP collapse discards assignment uncertainty (no backward inference); the ambiguous Group-2 subjects hint humans may retain more.
- Task-set structure is **representational abstraction** (create/cluster/reuse latent rules), *not* temporal abstraction — no options, subgoals, or pseudo-reward. It does not address HRL goal *decomposition*.

## Links
- [[wiki/entities/basal-ganglia.md]] — nested corticostriatal loops; create-or-reuse stripe gating.
- [[wiki/concepts/cognitive-control.md]] — C-TS as the create/cluster/generalize mechanism atop the rostro-caudal hierarchy.
- [[wiki/concepts/contextual-inference.md]] — C-TS is the cognitive-control ancestor of COIN's HDP context inference.
- [[wiki/queries/hrl-goal-decomposition-coverage.md]] — the audit this ingest was requested against (item #2).
