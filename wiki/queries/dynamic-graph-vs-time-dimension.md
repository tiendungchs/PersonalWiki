---
title: "Is the Latent Graph Dynamic, or Is Time Just Another Dimension?"
type: query
tags: [latent-graph-discovery, planning, world-models, time, exogenous-dynamics]
created: 2026-07-01
updated: 2026-07-02
sources: []
related: [wiki/concepts/latent-graph-discovery.md, wiki/entities/spacetime-attractor.md, wiki/concepts/planning-as-inference.md, wiki/concepts/successor-representation.md, wiki/concepts/world-models.md, wiki/entities/baba-is-ai.md, wiki/queries/rule-changes-as-meta-graph-rules.md]
---

# Is the Latent Graph Dynamic, or Is Time Just Another Dimension?

## Question

Even when an agent does nothing, the world keeps moving. Reasoning — strategizing, planning — often means concluding something based on what *might* happen next. Does this mean the latent graph the reasoning model must discover is itself dynamic (changes over time), or does it just mean time is one more dimension folded into an otherwise static graph?

## Answer

Three distinct things are tangled in this question, and the wiki's existing planning literature already separates two of them cleanly.

**(1) Time-as-dimension is the default, and it's well supported.** [[wiki/entities/spacetime-attractor.md]] makes this literal: it duplicates state space into T subspaces (δ = 0…T−1) chained by the *same* fixed adjacency matrix `W_{δ,δ+1} ≈ A_{ij}`. The graph topology never changes — only which timestep's copy is being read out, and which reward is attached to which (node, time) pair (`R_{δ,i}`). [[wiki/concepts/successor-representation.md]] does the same thing more compactly: `S = (I − γT)⁻¹` collapses all future timesteps into eigenvectors of one static transition matrix. Both "what might happen" queries are answered by indexing a fixed structure differently, not by changing the structure. This is the correct default framing for [[wiki/concepts/latent-graph-discovery.md]]: stationarity of the meta-graph is what licenses treating time as just another axis.

**(2) Genuinely dynamic topology is a real, separate, mostly-unsolved case.** There is a difference between the *reward landscape at nodes* changing over time (STA solves this — see the TD/SR/STA taxonomy in [[wiki/concepts/successor-representation.md]]) and the *edge set itself* changing over time (doors opening, rules changing mid-episode, other agents altering reachability). STA's "structural generalization" result (wall inputs gate/inhibit specific future-transition representations) is the only mechanism in the wiki that touches this, and it only *masks* a fixed, already-known edge set contextually — it does not re-infer topology that is actually rewriting itself over the course of an episode. No architecture in the wiki handles a meta-graph whose edge set is non-stationary at the timescale of a single episode.

Rule-changing games (Nomic, Fluxx, [[wiki/entities/baba-is-ai.md]]) show this case is not monolithic — it decomposes along tractability axes (legibility, driver, meta-stationarity, bounded vocabulary; full table in [[wiki/concepts/latent-graph-discovery.md]] → *Anatomy of Non-Stationary Topology*). The decisive one is **meta-stationarity**: Nomic is playable self-amendment *only* because its two-tier immutable/mutable hierarchy provides a stationary rule-for-changing-rules. Formally, non-stationary topology is learnable **iff the rewrite process is itself a stationary rewrite-graph** (recursing W/M one level up); when rewrites are *truly random* — an incompressible i.i.d. resampling of the edge set — there is no generator to discover and the problem is unsolvable in principle (an information-theoretic wall, not AIXI's computability wall). Every playable rule-changing game is deliberately non-random precisely to stay inside the solvable regime.

**(3) Exogenous vs. controllable edges — this is what "the world moves when we do nothing" is actually pointing at, and it's neither (1) nor (2).** The current graph formalism in [[wiki/concepts/latent-graph-discovery.md]] (Nodes = observations, Edges = transformations/actions) implicitly assumes the agent drives every edge. But an agent doing nothing still experiences state transitions — physics evolving, other agents acting, resources decaying. Formally this is not "no edge fires," it's "an edge fires that the agent didn't choose." Strategizing/planning is precisely the asymmetry this creates: the agent *searches* over controllable edges (which one to take) while it can only *predict* (not choose) exogenous edges (what the environment will do regardless). Mode-2 MPC planning ([[wiki/concepts/world-models.md]]) and STA's parallel trajectory evaluation ([[wiki/concepts/planning-as-inference.md]]) both implicitly assume the transition function is `s_{t+1} = T(s_t, a_t)` — which already has room for `a_t = ∅` producing autonomous drift — but nothing in the wiki's taxonomy currently separates "edges I choose among" from "edges I must predict." This distinction is missing from the Nodes/Edges/Topology table.

## Implications

- Don't reify "the world keeps moving" as evidence the latent graph is dynamic — in the common case (stationary environment physics/rules) it just means time is a navigable axis over a static structure, exactly as STA and SR already formalize.
- A reasoning architecture needs the controllable/exogenous edge split explicit: planning search only branches on controllable edges; exogenous edges need a predictive (world-model) component that runs regardless of what the agent decides. This is a refinement to the Five Sources of Hardness in [[wiki/concepts/latent-graph-discovery.md]], not a new hardness source on its own — it sharpens what "Edges" means in the base formalism.
- The same time-as-dimension construction extends to *rule-state-as-dimension* for non-stationary topology: augment the node with the current rule-config and the graph is stationary again — see [[wiki/queries/rule-changes-as-meta-graph-rules.md]], which argues source 6 therefore constrains M's update schedule (continuous vs. write-once) rather than defeating the W/M factorization.
- Genuinely time-varying topology (rules/edges rewriting mid-episode) is a distinct, harder, and currently unaddressed case — closer to non-stationary MDPs / continual learning within a single episode than to anything STA or SR solve. **This has since been promoted to a formal sixth source of hardness (Non-stationary topology) in [[wiki/concepts/latent-graph-discovery.md]]**, on the grounds that it is the only phenomenon that breaks the stationarity assumption the other five sources share, and that it mutates the instance-graph *inside* the fast-M binding window where the W/M architecture assumes stability. Note the asymmetry with implication #2 above: the controllable/exogenous edge split is *not* a hardness source (the transition function stays stationary), whereas non-stationary topology is.

## Follow-up Questions

- Is there empirical/biological evidence (PFC or elsewhere) for a circuit that explicitly separates "predict what happens if I do nothing" from "evaluate what happens if I act" — i.e., a neural implementation of the controllable/exogenous edge split?
- Does the wall-gating mechanism in STA generalize to edges *appearing* (not just being masked away), or is appearance of new edges architecturally a different problem (more like online structure learning / continual latent graph discovery)?
- For multi-agent settings, is "exogenous" edges best modeled as a single opaque environment dynamics function, or does strategizing require modeling other agents' own controllable/exogenous split recursively (theory-of-mind-style)?
