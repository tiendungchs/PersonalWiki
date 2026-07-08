---
title: "Baba Is AI"
type: entity
tags: [benchmark, non-stationary-topology, rule-manipulation, compositional-generalization, latent-graph-discovery]
created: 2026-07-02
updated: 2026-07-02
sources: [baba-is-ai]
related: [wiki/concepts/latent-graph-discovery.md, wiki/queries/dynamic-graph-vs-time-dimension.md, wiki/entities/arc-agi.md, wiki/concepts/compositional-generalization.md, wiki/entities/spacetime-attractor.md]
---

# Baba Is AI

**Benchmark (Cloos et al. 2024, arXiv:2407.13729) based on the puzzle game *Baba Is You*: the rules of the environment are movable objects the agent rewrites to win — the canonical *controllable, fully-legible* instance of non-stationary topology ([[wiki/concepts/latent-graph-discovery.md]] source 6).**

## What It Tests

| Element | Implementation |
|---|---|
| **Rules as objects** | Rules are text tiles of form `{noun} is {property}` (e.g. `[wall is stop]`, `[door is win]`); a rule is **active only when three tiles are horizontally aligned** |
| **Rewrite = a move** | The agent pushes tiles to *break* (de-align) or *make* (align) rules — the edge set of the environment graph is rewritten by the agent's own actions |
| **Win condition is latent + mutable** | No way to win until the agent builds a `{noun} is win` rule; the target node itself must be constructed |
| **Task primitives** | `goto{object}`, `make{rule}`, `break{rule}` — high-level plans, not low-level control |
| **Generalization probe** | Compose primitives in novel order at test time (train on `goto` / `make,goto` / `break,goto` → test `break,make,goto`) |

Implemented on Gymnasium MiniGrid; models receive the initial grid **image** and emit a textual plan.

## Key Results (GPT-4o, Gemini-1.5-Pro/Flash)

- **Distractor robustness is near-solved**: GPT-4o hits ~100% when the only challenge is ignoring irrelevant objects/rules — until *both* an object distractor and an active-rule distractor are present, where all models drop.
- **Compositional rule manipulation collapses**: novel composition `break→make→goto` yields **~15–20% accuracy** (Table 1: 14.7–20.0%) across all three frontier models; alternating which triplet is held out does not help.
- **Failure modes are structural, not perceptual**: *grounding mistakes* (referencing a non-existent object) and *path-planning mistakes* (asserting a clear path is blocked).

## Significance for Latent Graph Discovery

Baba Is AI isolates the **maximally tractable pole** of non-stationary topology: the rewrite is **controllable** (agent-driven), **legible** (rules are visible tiles), **bounded** (`noun × property` is a finite vocabulary), and **meta-stationary** (the alignment rule that decides what counts as a rule never changes). Every axis that could make topology-change unsolvable is pinned to its easy setting — yet frontier LLMs still fail at composing rewrites. This localizes the current-model bottleneck well *below* the in-principle hardness ceiling: models cannot plan over an edge set that they themselves edit, even when every edit is observable and finite.

## Comparison

| Benchmark | Topology | Target node | Vocabulary |
|---|---|---|---|
| **Baba Is AI** | non-stationary, agent-rewritten, observable | latent + constructible | bounded (`noun × property`) |
| ARC-AGI ([[wiki/entities/arc-agi.md]]) | static per task; edges latent | fixed | ~fixed (Core Knowledge) |
| ARC-AGI-3 | static rules, state evolves via action | latent | fixed action set, **per-game latent semantics** |
| FrontierMath | static; edges + path latent | fixed | near-empty (open) |

Baba Is AI is the only wiki benchmark where the **edge set mutates within an episode by design**, making it the empirical counterpart to source-6 hardness — as ARC-AGI is to latent-edge discovery. ARC-AGI-3 occupies a distinct cell: the rule set does *not* mutate, but the *edge labels are latent* (per-game action semantics discovered only by probing) **and** the target node is latent, all in an environment whose state the agent's own actions change — combining latent-edge discovery with latent-goal discovery under dynamic state, without the self-editing topology that defines Baba.

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — empirical instantiation of hardness source 6 (non-stationary topology) at its most tractable pole; frontier failure shows current models cannot plan over a self-edited edge set even when fully legible.
- **[[wiki/queries/dynamic-graph-vs-time-dimension.md]]** — Baba's rule-tiles are the concrete case where the rewrite is *controllable* (agent pushes tiles) rather than exogenous, and *observable* rather than latent — two of the tractability axes that query analyzes.
- **[[wiki/entities/arc-agi.md]]** — sister benchmark: ARC-AGI holds topology static and makes edges latent; Baba makes edges observable but non-stationary and agent-editable — orthogonal axes of the taxonomy.
- **[[wiki/concepts/compositional-generalization.md]]** — the `break→make→goto` test is compositional generalization over *rule-manipulation* primitives, not object features; frontier models fail this specific composition.
- **[[wiki/entities/spacetime-attractor.md]]** — STA's wall-gating masks a known edge set contextually; Baba requires *appearance/removal* of edges the agent causes, which STA does not model.
