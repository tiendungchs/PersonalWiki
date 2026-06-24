---
title: "OlymMATH Benchmark"
type: entity
tags: [benchmark, mathematical-reasoning, formal-verification, olympiad, lean4]
created: 2026-06-24
updated: 2026-06-24
sources: [olymmath]
related: [wiki/entities/frontiermath-benchmark.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/abstract-reasoning.md, wiki/papers/olymmath.md]
---

# OlymMATH Benchmark

**Bilingual (EN/ZH) olympiad-level math benchmark with a Lean 4 formal verification track, designed to discriminate frontier models and detect heuristic reasoning.**

## Structure

| Subset | Size | Type | Key feature |
|---|---|---|---|
| EASY | 100 problems | NL, numerical answer | Computational, olympiad easy |
| HARD | 100 problems | NL, numerical answer | Olympiad hard; discriminates top models |
| LEAN | 150 problems | Lean 4 formalization | Process-level verification; detects shortcuts |

Domains: Algebra, Geometry, Number Theory, Combinatorics. Manually curated from printed publications (not web-sourced). 582k+ reasoning trajectories released.

## Taxonomy Position

OlymMATH-HARD occupies the **intermediate tier** between AIME (largely solved, high-density vocabulary) and FrontierMath (near-zero vocabulary coverage). The Lean track is the first benchmark track providing a process-level oracle for whether a model genuinely traverses the latent reasoning graph vs. uses heuristic shortcuts.

## Limitations

- Text-only; no multimodal geometry
- Static benchmark (contamination risk)
- NL track has no scalable shortcut-detection metric (Lean track only)

## Connections

- **[[wiki/concepts/latent-graph-discovery.md]]** — OlymMATH-LEAN's Lean 4 verification distinguishes genuine latent path traversal from shortcut guessing; OlymMATH-HARD fills the intermediate tier between AIME (solved) and FrontierMath (open) in the path-discovery taxonomy.
- **[[wiki/entities/frontiermath-benchmark.md]]** — upper bound comparison; FrontierMath additionally makes the meta-graph vocabulary latent, whereas OlymMATH assumes olympiad-level known vocabulary.
- **[[wiki/concepts/abstract-reasoning.md]]** — olympiad problems require rule induction and multi-step causal chaining, placing them in the abstract reasoning category alongside ARC-AGI.
- **[[wiki/papers/olymmath.md]]** — source paper.
