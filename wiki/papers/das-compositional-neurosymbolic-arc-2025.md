---
title: "Compositional Neuro-Symbolic Reasoning (CoreThink ARC-AGI-2 Reasoner)"
type: paper
tags: [neuro-symbolic, ARC-AGI, DSL, program-synthesis, object-centric, compositional-generalization, test-time-compute]
created: 2026-07-13
updated: 2026-07-13
sources: [Compositional Neuro-Symbolic Reasoning]
related: [wiki/concepts/refinement-loops.md, wiki/concepts/shortcut-reasoning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/latent-graph-discovery.md, wiki/entities/arc-agi.md, wiki/entities/vsa-model.md, wiki/concepts/core-knowledge.md, wiki/queries/sota-review-brain-inspired-abstract-reasoning.md]
---

# Compositional Neuro-Symbolic Reasoning

**Das, Ghugarkar, Bhat, Aali (CoreThink AI / Stanford), Nov 2025.** ARC-AGI-2 Reasoner. Code: github.com/CoreThink-AI/arc-agi-2-reasoner. SOTA under its experimental setup at release.

## Key computational insights

- **Design principle: strict separation of perceptual abstraction from rule induction.** A four-stage pipeline replaces end-to-end neural mapping (which entangles perception + rule + application in one forward pass — the diagnosed source of ARC failure).
- **Stage 1 — structured symbolic scene abstraction.** Grid → scene graph `S(I) = {o_j}` via deterministic 8-connected-component decomposition; per-object features `ϕ(o_j)`: bounding box, centroid, translation-normalized canonical shape, 10-d color histogram, cavity detection (fully-enclosed background regions). Objectness is *hand-coded*, not learned. LLM (Claude Opus 4) enriches only ambiguous shape/cavity cues → "structured symbolic," not pure parser.
- **Stage 2 — neural-guided hypothesis proposal over a fixed DSL.** 22 parameterized "Unit Patterns" (Horizontal/Vertical Fill, Connecting Bridges, Cavity Fill, Gravity, Ray-Cast, Symmetry, …), hand-curated from ARC-1/2 training sets as a "core knowledge" primitive set. A program `π = p_{a_m} ∘ … ∘ p_{a_1}` is a composition of primitives; a neural proposal distribution `q_θ(π | S(I), S(O))` (o4-mini, structured JSON output) proposes/ranks compositions — operates purely in symbolic hypothesis space, never emits pixels.
- **Stage 3 — cross-example consistency filtering.** Keep only programs reproducing the output on *every* demonstration: `Π* = ∩_i {π : π ⊨_i}`. Eliminates per-example-fit explanations that fail to generalize. If `Π* = ∅`, pick minimal-depth program (parsimony / Occam). Operationally approximated by retaining recurrent top-3 Unit Patterns across 5 repeated detections.
- **Stage 4 — guided solution generation.** Consensus hints + test scene → rule-based executor (for directly solvable families, e.g. jigsaw-symmetry when symmetry score > 0.70) or LLM (Grok-4) conditioned on demos + hint; N self-consistency samples aggregated by cell-wise majority vote.
- **Ablation (the load-bearing result):** symbolic hints +6.9pp (24.4→17.5 when removed) = **largest single driver**; self-consistency +3.9pp (24.4→20.5) = secondary robustness. Symbolic preprocessing is negligible cost vs. N-fold LLM sampling. "Gains stem from structural bias, not brute-force search or scaling."
- **Meta-classifier ensemble:** discriminative selector over 4 candidates (2 compositional + 2 ARC Lang Solver), run twice without replacement for pass@2. +4.2pp over best single solver (26.6→30.8) — **structural diversity, not stochastic averaging**: the two solvers solve non-identical task subsets (compositional wins cavity/fill/symmetry; LLM wins semantic regrouping).

## Results (ARC-AGI-2 public eval, pass@2)

| System | Category | Score |
|---|---|---|
| Human | Human | 100.0 |
| CoreThink Meta-Classifier | Neuro-Symbolic + Ensemble | 30.8 |
| Compositional Reasoner | Neuro-Symbolic | 24.4 |
| GPT-5-Pro (best pure LLM) | LLM | 18.3 |
| Claude Opus 4 (16K) | LLM | 8.6 |

## Limitations

- DSL is admittedly incomplete — fails on deeply compositional / multi-stage relational tasks and implicit latent groupings beyond the 22 patterns; absolute scores already surpassed by later systems.
- Vocabulary (the 22 patterns) and objectness (connected components) are both **hand-supplied**, not co-discovered — sidesteps rather than solves Gaps #3 and #9.
- Meta-classifier relies on candidate diversity, not principled program verification; parts of the symbolic representation are LLM-assisted → robustness depends on prompt-stack calibration.
- Self-consistency imposes a multiplicative N× inference cost.

## Links
- [[wiki/concepts/refinement-loops.md]] — the symbolic-hint + self-consistency pipeline as a structured neuro-symbolic variant of test-time compute.
- [[wiki/concepts/shortcut-reasoning.md]] — hand-coded connected-components as objectness supplied externally.
- [[wiki/concepts/latent-graph-discovery.md]] — DSL primitives = candidate edge labels; cross-example intersection = edge-inference constraint.
- [[wiki/entities/arc-agi.md]] · [[wiki/entities/vsa-model.md]] — sister neuro-symbolic ARC approaches.
