---
title: "ConceptARC: Evaluating Understanding and Generalization in the ARC Domain"
type: paper
tags: [ARC, abstract-reasoning, concept-formation, benchmark, compositional-generalization, core-knowledge]
created: 2026-06-22
updated: 2026-06-22
sources: [The ConceptARC Benchmark]
related: [wiki/entities/arc-agi.md, wiki/concepts/abstract-reasoning.md, wiki/concepts/compositional-generalization.md, wiki/concepts/structural-generalization.md, wiki/papers/pgm-barrett-2018.md, wiki/papers/arc-agi-overview.md]
---

# ConceptARC: Evaluating Understanding and Generalization in the ARC Domain

**Citation:** Moskvichev A., Odouard V.V. & Mitchell M. Santa Fe Institute, 2023.

---

- **16-concept taxonomy from Core Knowledge priors** — Decomposes ARC into 16 spatial/semantic concept groups (Above/Below, Center, Copy, Count, Order, Inside/Outside, etc.) derived from Spelke's objectness/numerosity/geometry priors. Each group: 10 tasks × 3 test inputs = 30 evaluation points. High performance across all 30 is evidence of genuine concept abstraction vs. task-specific shortcut.

- **Performance dissociation at concept level** — Humans: 83–97% per concept (avg ~91%, all 16 >80%); ARC-Kaggle 1st: 23–77% (never >80%, below 60% on 11/16); GPT-4: 3–33% (below 30% on 15/16). Granularity reveals differential difficulty hidden in overall ARC scores: spatial-relational concepts easier (Extend to Boundary 77%, Count 60%) than compositional transformation concepts (Copy 23%, Order 27%).

- **Error type dissociation** — Human errors are near-misses (concept grasped, execution wrong: off-by-one, wrong size, deleted original after copy). Machine errors indicate concept not grasped — outputs are not interpretable as rule applications. This qualitative distinction is the behavioral marker of model-building vs. pattern matching and cannot be captured by accuracy alone.

- **Concept-group methodology as diagnostic** — Partial success within a concept group indicates shortcut, not concept abstraction. ARC-domain instantiation of PGM's controlled regime testing: the within-concept generalization score distinguishes rule extraction from rule-instance memorization.

- **LARC: language mediates concept transfer** — Natural-language descriptions (Acquaviva et al. 2022) allow humans to solve ARC tasks 88% of the time without demonstrations; best machine solver with same descriptions: 12%. Linguistic representation carries information absent from grid-transformation programs.

**Limitations:** 480 test inputs total; manually constructed; small number of ambiguous tasks; 8–14 participants per test input.

**Links:** [[wiki/entities/arc-agi.md]] · [[wiki/concepts/abstract-reasoning.md]] · [[wiki/concepts/compositional-generalization.md]] · [[wiki/papers/pgm-barrett-2018.md]]
