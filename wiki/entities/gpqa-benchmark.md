---
title: "GPQA Benchmark"
type: entity
tags: [benchmark, expert-reasoning, scalable-oversight, science]
created: 2026-06-24
updated: 2026-06-24
sources: [gpqa-rein-2024]
related: [wiki/papers/gpqa-rein-2024.md, wiki/concepts/latent-graph-discovery.md]
---

**Graduate-Level Google-Proof Q&A Benchmark** — 4-choice MCQ benchmark in biology, physics, and chemistry, designed so that web search does not help non-experts.

| Property | Value |
|----------|-------|
| Domains | Molecular biology, genetics; quantum mechanics, particle physics, astrophysics; organic, inorganic, general chemistry |
| Main split | 448 questions (≥1/2 experts agree, ≤2/3 non-experts correct) |
| Diamond split | 198 questions (2/2 experts agree, ≤1/3 non-experts correct) |
| Expert accuracy | 65% overall; 72% chemistry; 57% physics |
| Non-expert + web | 22–34% (≈ 25% random baseline) |
| GPT-4 + CoT (Chain of Thought) (2023) | ~39%; web search yields no gain |

**Key result:** The google-proof gap — ~31 percentage points between PhD experts and web-enabled non-experts — demonstrates that correct answers require traversing implicit causal-chain reasoning, not keyword lookup. Current frontier models (2023 era) cluster near non-expert level, well below the expert ceiling.

**Latent-graph framing:** GPQA problems sit at the intersection of "node content latent" and "path latent" in the latent-graph-discovery taxonomy. The intermediate reasoning states (molecular orbital configurations, relativistic corrections, enzyme kinetics) are never given; solvers must discover the correct edge vocabulary (physical laws, reaction mechanisms) and traverse it. The google-proof design is a direct empirical test of spurious-edge suppression — surface keyword matching fails; only the correct causal graph path succeeds.

**Limitations:** Small size; expert pool not demographically diverse; chemistry-heavy; likely contaminated in large post-2023 training corpora.

## Connections

**[[wiki/concepts/latent-graph-discovery.md]]** — GPQA's google-proof property operationalizes spurious-edge suppression: solvers that match surface keywords fail; only models that traverse the correct causal/logical reasoning chain succeed, mapping directly onto the "node content latent" hardness source.

**[[wiki/papers/gpqa-rein-2024.md]]** — source paper.
