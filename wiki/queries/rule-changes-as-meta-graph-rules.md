---
title: "Are Rule Changes Just Another Rule in the Meta-Graph?"
type: query
tags: [latent-graph-discovery, non-stationary-topology, two-learning-timescales, factorized-representations, rule-learning]
created: 2026-07-02
updated: 2026-07-02
sources: []
related: [wiki/concepts/latent-graph-discovery.md, wiki/queries/dynamic-graph-vs-time-dimension.md, wiki/concepts/two-learning-timescales.md, wiki/concepts/factorized-representations.md, wiki/entities/baba-is-ai.md]
---

# Are Rule Changes Just Another Rule in the Meta-Graph?

## Question

Hardness source 6 (non-stationary topology) in [[wiki/concepts/latent-graph-discovery.md]] says the edge set rewriting mid-episode "defeats the W/M scheme directly." But most real rule-changes are *structured*, hence learnable. So how does the brain learn them — and isn't "how the rules change" itself just a rule in the meta-graph, with the currently-active rules treated as instance-graph quirks?

## Answer

**Yes — for a large tractable class, and this vindicates W/M rather than defeating it.** The original phrasing conflated the W/M *factorization* with the write-once *scheduling* of M. Only the latter breaks.

**Two things get called "the rule":**
- **(a) object-level edges currently in effect** (`rock is push`) — mutate mid-episode
- **(b) the generator that changes (a)** (tile alignment activates an edge) — stationary

Correct assignment: **(b) → slow W**, **(a) → fast M** (now continuously updated, not written once). The factorization survives; what dies is the TEM-style *bind-during-exploration, read-during-exploitation* schedule. So the accurate claim is "non-stationary topology defeats write-once M scheduling," not "defeats W/M."

**The lifting move — rule-state as a dimension.** This is the same trick [[wiki/queries/dynamic-graph-vs-time-dimension.md]] uses for time. Define augmented node `s' = (base_state, rule_config)`; on the lifted space the graph is **stationary again**. Non-stationary topology is an artifact of *marginalizing out* the rule dimension. Fold time into the node → reward dynamics become static-index lookups (STA/SR); fold rule-state into the node → topology dynamics become ordinary edges. Source 6 then reduces to ordinary latent graph discovery over a larger stationary graph.

**Two catches:**

| Catch | Consequence |
|---|---|
| **Blowup** | Lifted space `|base| × |rule-configs|`; stationarity free, tractability not. Learnable iff rule-config **factorizes** ([[wiki/concepts/factorized-representations.md]]) and rewrites are **sparse** — exactly the meta-stationary/bounded poles of the Anatomy table. Reduction holds over the tractable interior only; unsolvable pole = "lifted graph has no compressible generator." |
| **Third tier survives** | Fold works only when (b) shares vocabulary with base transitions (Baba-class). When a rewrite edits the meta-graph itself in vocabulary not available at object level (**Nomic**: a mutable rule changes the voting rule governing rule-changes), the immutable/mutable tiers are irreducibly distinct. **Two levels for Baba-class; three for Nomic-class self-amendment.** |

**Brain angle — reification.** The parsimonious mechanism is to represent a *rule as a first-class graph object* (a node with its own factorized code), so "rule-change" is an ordinary edge over rule-nodes handled by the same HC-entorhinal machinery — no special module. The slower W-over-rules timescale maps onto the cortical hierarchy of temporal receptive windows (posterior/HC fast; anterior PFC slow), i.e. depth in the timescale hierarchy, not a new subsystem.

## Implications

- Revise the framing of hardness source 6: it constrains M's *update schedule* (continuous, not write-once), not the W/M factorization. Done in [[wiki/concepts/latent-graph-discovery.md]] → *Rule-State as a Dimension*.
- Time-as-dimension and rule-state-as-dimension are the **same construction**: augment the node with the varying quantity to restore stationarity, then pay for it in state-space size unless the augmentation factorizes.
- Architectural target: a factorized rule-code that lets the augmented graph stay sparse — the tractability of source 6 is a *factorization* question, not a fundamentally new mechanism.

## Follow-up Questions

- Can a single factorized code carry both `g` (base meta-graph position) and a `g_rule` (position in rule-space) such that Baba-class rule-changes are literally path-integration in the rule sub-space?
- Is Nomic-class self-amendment (irreducible third tier) actually needed for any *biological* competence, or is human rule-learning empirically always Baba-class (rule-changes expressible in base vocabulary)?
- Does the continuously-updated M (vs. write-once) require a different plasticity rule than TEM's Hebbian bind — e.g. an overwrite/gating mechanism to retract now-inactive edges without catastrophic interference?
