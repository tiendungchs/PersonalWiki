---
title: "A map of abstract relational knowledge in the human hippocampal–entorhinal cortex — Garvert, Dolan & Behrens 2017"
type: paper
tags: [successor-representation, entorhinal-cortex, latent-graph-discovery, implicit-learning, communicability, relational-inference]
created: 2026-07-09
updated: 2026-07-09
sources: [garvert-abstract-relational-map-2017]
related: [wiki/concepts/successor-representation.md, wiki/concepts/latent-graph-discovery.md, wiki/entities/hippocampal-entorhinal-system.md, wiki/entities/grid-cells.md, wiki/queries/mec-abstract-codes-vs-declarative-rules.md, wiki/queries/central-framing-epistemic-audit.md, wiki/papers/kumaran-maguire-2005-hippocampus.md, wiki/papers/zheng-parallel-cognitive-maps-2024.md]
---

# A map of abstract relational knowledge in the human hippocampal–entorhinal cortex

**Citation:** Garvert MM, Dolan RJ, Behrens TEJ (2017). *eLife* 6:e17086. https://doi.org/10.7554/eLife.17086

The single most direct test of the "reasoning ≅ navigation over a latent graph" frame on a **discrete, non-spatial, non-metric, unconsciously-learned** relational structure.

## Key computational insights

- **Paradigm:** Day 1 — subjects view object sequences drawn from a **random walk on a hidden graph** (12 nodes) under an unrelated cover task; zero explicit awareness of any structure at debrief. Day 2 — fMRI adaptation on a reduced 7-node graph, objects in *random* order. Adaptation (repetition suppression) indexes representational similarity between successive objects.
- **Result:** bilateral **entorhinal cortex / subiculum** adaptation decreases with graph **link distance** — a map-like code recovered from an *implicitly* learned graph with **no continuous organizing dimension** ("dimensions had to be extracted from the associations").
- **Native metric is predictive, not Euclidean.** The signal (and behavioral RT in a separate n=26 cohort) is best explained by **communicability** ($-e^{A}$, matrix exponential of adjacency $A$) and the **successor representation** $(I-\gamma A)^{-1}$ — a weighted sum of *future* states — and communicability survives with Euclidean distance as a competing regressor. No evidence for a Euclidean embedding.
- **Map-like signatures:** the distance code is **non-directional** (symmetrised shortest-path predicts; directional does not) and MDS on the 7×7 adaptation matrix **recovers the 2D graph** (r=0.65, p=0.003; no link crossings — true of only 13% of random graphs).
- **Localized to HC/EC only:** no map-like code outside the hippocampal formation (notably **not** OFC/vmPFC), attributed to the passive/implicit design — the structure was never used for a task (contrast OFC decision-space maps, Schuck 2016).

## Limitations

- The graph is small and **2D-planar-embeddable** (MDS recovers it in 2D) — it tests discrete/associative but not genuinely *non-embeddable* symbolic structure (modular arithmetic, syntactic recursion).
- Correlational fMRI adaptation; no causal/lesion test. Implicit-only — says nothing about explicit/declarative graph reasoning (where Kumaran & Maguire 2005 found zero MTL).

## Links

Direct human evidence for the SR/communicability as the brain's native graph metric ([[wiki/concepts/successor-representation.md]]); the cleanest demonstration the brain does unconscious [[wiki/concepts/latent-graph-discovery.md]]; refines the metric-vs-declarative boundary in [[wiki/entities/hippocampal-entorhinal-system.md]] and [[wiki/queries/mec-abstract-codes-vs-declarative-rules.md]]; re-scores sub-claims B/C of [[wiki/queries/central-framing-epistemic-audit.md]]. **Reanalyzed by [[wiki/papers/zheng-parallel-cognitive-maps-2024.md]]**, which finds this transition map (anterior EC) coexists with a *parallel, separable* taxonomic-semantic map (posterior HC) over the same objects — not one conjunctive map.
