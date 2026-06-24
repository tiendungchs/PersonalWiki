---
title: "Challenging the Boundaries of Reasoning: An Olympiad-Level Math Benchmark for LLMs"
type: paper
tags: [benchmark, mathematical-reasoning, formal-verification, abstract-reasoning]
created: 2026-06-24
updated: 2026-06-24
sources: [olymmath]
related: [wiki/entities/olymmath.md, wiki/concepts/latent-graph-discovery.md, wiki/concepts/abstract-reasoning.md]
---

# OlymMATH (Sun et al., Renmin University — ArXiv:2503.21380)

**Citation:** Sun, Min, Chen, Zhao, Wen — Renmin University of China, 2025.

## Key Computational Insights

- **Dual evaluation paradigm:** Unifies NL outcome evaluation (200 problems, numerical answers) with Lean 4 formal process verification (150 problems) — first benchmark to measure both whether a model gets the right answer and whether the reasoning path is correct.
- **Consistency gap exposes brittleness:** Pass@64 vs Cons@64 diverges sharply (e.g., 74% vs 22% for DeepSeek-R1-7B) — models occasionally traverse the latent proof graph but cannot discover it reliably; outcome-only metrics mask this failure.
- **Heuristic guessing is prevalent at the frontier:** o3-mini and Gemini 2.5 Pro bypass rigorous reasoning via symmetry assumptions and empirical shortcuts; Lean 4 uniquely detects such shortcuts because formal proofs require explicit intermediate-node traversal.
- **Discriminative power above AIME:** OlymMATH-HARD reveals capability gaps hidden by AIME saturation — Gemini 2.5 Pro drops 92%→58.4%, o3-mini drops 87.3%→31.2%, placing this tier above AIME but below FrontierMath.
- **EN>ZH gap is structural:** Wilcoxon signed-rank tests across 14 models confirm consistent English dominance; attributable to pretraining corpus imbalance, not task format.

## Limitations

- Text-only; geometry problems reformulated from diagrams (no vision-language evaluation).
- "Guessing" quantified only via case studies — no scalable metric for shortcut prevalence in NL track.
- Static benchmark; contamination risk grows post-release.

## Links

- [[wiki/entities/olymmath.md]]
- [[wiki/concepts/latent-graph-discovery.md]]
