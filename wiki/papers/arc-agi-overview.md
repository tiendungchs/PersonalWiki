---
title: "ARC-AGI Benchmark Series — Chollet 2019 / arcprize.org 2025"
type: paper
tags: [ARC-AGI, benchmark, fluid-intelligence, skill-acquisition, test-time-reasoning, compositional-reasoning]
created: 2026-06-19
updated: 2026-06-19
sources: [ARC-AGI-1.md, ARC-AGI-2.md, ARC-AGI-3.md, What is ARC-AGI.md]
related: [wiki/entities/arc-agi.md, wiki/concepts/structural-generalization.md, wiki/concepts/compositional-generalization.md, wiki/concepts/meta-learning.md, wiki/queries/building-blocks-mec-hc-pfc.md]
---

# ARC-AGI Benchmark Series — Chollet 2019 / arcprize.org 2025

**Citations:** Chollet, F. (2019). On the Measure of Intelligence. arXiv:1911.01547. ARC-AGI-2 and ARC-AGI-3 (2025) from arcprize.org.

---

## Key Computational Insights

- **Intelligence = skill-acquisition efficiency, not task skill:** Chollet's formal definition excludes crystallized knowledge (developer-encoded priors) and isolates fluid generalization. Benchmarks testing PhD-level knowledge or domain-specific skills measure the developer's encoding cleverness, not the system's intelligence — a critical distinction for designing principled evaluations.
- **Core Knowledge Priors define the fair prior budget:** Restricting to objectness, numbers/counting, geometry/spatial relations, and agency/intentionality creates a universal substrate accessible to both humans and any AI system without prior exposure. Anything beyond this is crystallized knowledge that biases the comparison toward well-pretrained systems.
- **Scale alone fails fluid intelligence — test-time adaptation is the lever:** ARC-AGI-1 resisted 50,000× LLM scale-up from 2019 to 2024. o3 solved it via test-time reasoning rather than additional pre-training — empirically establishing that fast within-episode adaptation, not slow weight accumulation, is the critical variable for novel-task generalization.
- **ARC-AGI-2 identifies three specific architectural deficits:** Symbolic interpretation (semantic role beyond visual pattern → Block 3A), compositional reasoning (multiple simultaneously interacting rules → Block 3C), contextual rule application (context-gated rule selection → Block 3B). These are not data or scale problems — they require novel architectural mechanisms targeting each block.
- **ARC-AGI-3 defines the complete agent loop:** Moving from static puzzles to interactive environments requires on-the-fly goal acquisition, experience-driven world-model building, and long-horizon planning with sparse feedback — the full closed-loop architecture (Blocks 3A + 3B + 3D + world-model update) operating across sequential time steps, not just single inference passes.

---

## Limitations

- Grid-based format is heavier in visuo-spatial priors than the four Core Knowledge claims strictly require; may under-test symbolic/linguistic abstract reasoning.
- ARC-AGI-1 is solved; its ongoing relevance is primarily as a methods comparator.
- Cost-based efficiency metric for ARC-AGI-2 is a rough proxy — human effort and AI compute cost are not directly commensurable.

---

- [[wiki/entities/arc-agi.md]] — full benchmark structure, three capability gaps, mapping to building blocks, results table
- [[wiki/concepts/structural-generalization.md]] — ARC-AGI as the empirical target; three ARC-AGI-2 gaps operationalise remaining structural generalization failures post-o3
- [[wiki/concepts/meta-learning.md]] — test-time reasoning as the meta-learning lever that solved ARC-AGI-1; fast inner loop over pre-training scale
- [[wiki/queries/building-blocks-mec-hc-pfc.md]] — three ARC-AGI-2 capability gaps map to Blocks 3A/3B/3C; ARC-AGI-3 requirements add Block 3D
