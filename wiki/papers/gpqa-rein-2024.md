---
title: "GPQA: A Graduate-Level Google-Proof Q&A Benchmark"
type: paper
tags: [benchmark, reasoning, scalable-oversight, expert-knowledge]
created: 2026-06-24
updated: 2026-06-24
sources: [gpqa-rein-2024]
related: [wiki/entities/gpqa-benchmark.md, wiki/concepts/latent-graph-discovery.md]
---

Rein, D., Hou, B. L., Stickland, A. C., Petty, J., Pang, R. Y., Dirani, J., Michael, J., & Bowman, S. R. (2024). *GPQA: A Graduate-Level Google-Proof Q&A Benchmark.* arXiv:2311.12022.

- 4-stage construction pipeline: expert writes → peer expert validates → author revises → second validation plus 3 non-expert validators (≥15 min Google access each); workers paid ~$95/hr.
- Three splits by difficulty: Extended (546), Main (448; ≥1/2 experts agree, ≤2/3 non-experts correct), Diamond (198; 2/2 experts agree, ≤1/3 non-experts correct).
- Expert accuracy 65–72% (chemistry highest, physics lowest at 57%); non-experts with unrestricted web search reach only 22–34% — barely above 25% random baseline on 4-choice.
- AI baselines (2023): GPT-4 with few-shot CoT (Chain of Thought) reaches ~39%; adding web search yields 39.4% with 37% abstention rate — search provides no meaningful gain.
- Motivates scalable oversight: when validators cannot verify answers directly (because they lack the expertise), the only tractable supervision strategy is checking the reasoning chain, not the conclusion.

**Limitations:** Small (448 examples); expert pool not demographically diverse; questions may be contaminated in future large-scale training corpora.

**Related pages:** [[wiki/entities/gpqa-benchmark.md]], [[wiki/concepts/latent-graph-discovery.md]]
