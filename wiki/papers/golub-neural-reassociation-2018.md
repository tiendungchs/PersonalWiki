---
title: "Learning by neural reassociation — Golub et al., Nature Neuroscience 2018"
type: paper
tags: [bci, neural-manifolds, action-semantics, contextual-inference, arbitrary-mapping, motor-cortex, two-learning-timescales]
created: 2026-07-17
updated: 2026-07-17
sources: [Learning by neural reassociation]
related: [wiki/papers/sadtler-neural-constraints-learning-2014.md, wiki/concepts/neural-manifolds.md, wiki/concepts/contextual-inference.md, wiki/concepts/arbitrary-mapping.md, wiki/concepts/two-learning-timescales.md, wiki/queries/action-semantics-contextual-inference.md, wiki/papers/heald-coin-contextual-inference-2021.md, wiki/papers/boettiger-desposito-sr-rule-learning-2005.md, wiki/papers/brain-learning-limits-transcript.md, wiki/architectural-gaps.md]
---

# Learning by neural reassociation

Golub, Sadtler, Oby, Quick, Ryu, Tyler-Kabara, Batista, Chase & Yu. *Nat. Neurosci.* 21(4):607–616, 2018. doi:10.1038/s41593-018-0095-3. Sequel to Sadtler et al. 2014 ([[wiki/papers/sadtler-neural-constraints-learning-2014.md]]); 48 experiments, 3 rhesus macaques, ~90 M1 units each.

**Design.** A BCI makes the action→outcome map *exactly known*: 10-D factors $z_t$ (factor analysis on 45-ms spike counts, the *intrinsic manifold*) → 2-D cursor velocity $v_t$ via a Kalman filter $v_t = A v_{t-1} + B z_t + c$. Mid-session, $B$'s columns are permuted (a **within-manifold** perturbation) — the action semantics change while the reachable state space does not. This is the cleanest existing experimental analog of "the same button now does something else."

## Key computational insights

- **Reassociation wins; the repertoire is preserved.** Three pre-registered strategies were formalized as convex programs constrained to the manifold, physiological firing ranges, and realistic variability. *Realignment* (the optimal strategy — grow novel patterns aligned to the new mapping) and *Rescaling* (gain adaptation per dimension) both predict repertoire change and are **refuted** ($p<10^{-10}$ on repertoire change; $p<10^{-8}$ on covariability). *Reassociation* — the same patterns, re-associated with different movement intents — matches the data on every measure ($p=0.55$ repertoire change, $p=0.76$ pushing-magnitude slope).
- **Cross-pointer re-binding, not pruning.** *Subselection* (keep only the still-correct patterns from each movement's own before-learning cloud) is **also refuted**. After learning, a movement recruits patterns that previously belonged to *other* movements. The binding between intent and pattern is genuinely re-shuffled across the repertoire.
- **The repertoire is a behavioral ceiling, not a speed limit.** Reassociation is suboptimal by construction and predicts the animals' **incomplete** performance recovery — the finding that distinguishes it from Partial Realignment (which needs only ~15% migration to match behavior and is refuted on movement-specific clouds). Animals did not close the gap despite residual pressure, and showed *no more* Realignment when the incentive to realign was larger.
- **Repertoire preservation implicates M1's *inputs*, not M1's connectivity.** The authors' own inference: rewiring *within* M1 would have changed the repertoire it can produce. So what learning rewrites sits upstream of the executor — converging from population physiology on the disjoint acquisition/execution circuits Boettiger & D'Esposito 2005 found in humans ([[wiki/papers/boettiger-desposito-sr-rule-learning-2005.md]]).
- **Two timescales, both distinct from the W/M split.** Reassociation (hours) and Realignment (days–weeks) may run in parallel — a subtle covariability effect correlating with learning hints at a minor Realignment component ($p=0.006$, small effect). The split is *re-use of repertoire* vs. *extension of repertoire*, which cuts across the fast-M/slow-W axis rather than aligning with it.
- **Not an artifact of the paradigm.** Reassociation was equally evident from the first experiments onward (no progressive consolidation of intuitive-mapping patterns), and perturbations were hard enough to leave standing pressure to do better.

## Limitations

- Timescale is 1–2 h (≈600–870 perturbed trials); the paper cannot exclude that longer exposure yields Realignment, and explicitly proposes it does.
- Within-manifold perturbations only; outside-manifold learning is a different regime, left to Sadtler et al. 2014.
- All analyses are on factor-analysis factors (shared covariance) — private, Poisson-like per-unit variability is excluded by construction (checked post-hoc for plausibility, not for effect).
- No mechanism: the inputs-not-connectivity reading is an inference from repertoire preservation, not a measurement, and the driver (cortical vs. subcortical) is untested.
- Only ~2/3 of monkey J's experiments contributed; experiments were **selected for showing significant behavioral learning**, so the sample conditions on successful adaptation.

## Feeds

- [[wiki/concepts/neural-manifolds.md]] — the within-manifold constraint (stronger than the outside-manifold boundary the wiki already carried).
- [[wiki/concepts/contextual-inference.md]] — reassociation as the population-level instance of COIN's *apparent learning*.
- [[wiki/concepts/arbitrary-mapping.md]] — the binding-rate tension (hundreds of trials here vs. ~3 trials/cue).
- [[wiki/queries/action-semantics-contextual-inference.md]] — supplies the mechanism behind that query's BCI evidence row.
